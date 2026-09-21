import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import '../../../core/domain/year_month.dart';
import '../domain/movement_repository.dart';
import '../domain/register_movement.dart';

class DriftMovementRepository implements MovementRepository {
  DriftMovementRepository(this._db, {Uuid? uuid})
    : _uuid = uuid ?? const Uuid();

  final AppDatabase _db;
  final Uuid _uuid;

  @override
  Future<void> add(MovementData movement) {
    // Todo dentro de una transacción: o se guarda todo, o nada.
    return _db.transaction(() async {
      final now = DateTime.now();
      final period = await _getOrCreatePeriod(
        YearMonth.fromDate(movement.date),
        now,
      );

      await _db
          .into(_db.financialTransactions)
          .insert(
            FinancialTransactionsCompanion.insert(
              id: movement.id,
              periodId: period.id,
              categoryId: movement.categoryId,
              isIncome: movement.isIncome,
              amount: movement.amount.minorUnits,
              date: movement.date,
              cutNumber: movement.cutNumber,
              description: Value(movement.description),
              createdAt: now,
              updatedAt: now,
            ),
          );

      await _recalculatePeriod(period.id, now);
    });
  }

  @override
  Future<void> update(MovementData movement) {
    return _db.transaction(() async {
      final now = DateTime.now();

      final existing = await _findActive(movement.id);
      if (existing == null) {
        throw const MovementException('Ese movimiento ya no existe.');
      }

      final period = await _getOrCreatePeriod(
        YearMonth.fromDate(movement.date),
        now,
      );

      await (_db.update(
        _db.financialTransactions,
      )..where((t) => t.id.equals(movement.id))).write(
        FinancialTransactionsCompanion(
          periodId: Value(period.id),
          categoryId: Value(movement.categoryId),
          isIncome: Value(movement.isIncome),
          amount: Value(movement.amount.minorUnits),
          date: Value(movement.date),
          cutNumber: Value(movement.cutNumber),
          description: Value(movement.description),
          updatedAt: Value(now),
        ),
      );

      // Se recalcula el mes nuevo y, si cambió de mes, también el anterior.
      await _recalculatePeriod(period.id, now);
      if (existing.periodId != period.id) {
        await _recalculatePeriod(existing.periodId, now);
      }
    });
  }

  @override
  Future<void> softDelete(String id) {
    return _db.transaction(() async {
      final existing = await _findActive(id);
      if (existing == null) return;

      final now = DateTime.now();
      await (_db.update(
        _db.financialTransactions,
      )..where((t) => t.id.equals(id))).write(
        FinancialTransactionsCompanion(
          deletedAt: Value(now),
          updatedAt: Value(now),
        ),
      );

      await _recalculatePeriod(existing.periodId, now);
    });
  }

  @override
  Future<void> restore(String id) {
    return _db.transaction(() async {
      final deleted =
          await (_db.select(_db.financialTransactions)
                ..where((t) => t.id.equals(id) & t.deletedAt.isNotNull()))
              .getSingleOrNull();
      if (deleted == null) return;

      final now = DateTime.now();
      await (_db.update(
        _db.financialTransactions,
      )..where((t) => t.id.equals(id))).write(
        FinancialTransactionsCompanion(
          deletedAt: const Value<DateTime?>(null),
          updatedAt: Value(now),
        ),
      );

      await _recalculatePeriod(deleted.periodId, now);
    });
  }

  Future<FinancialTransaction?> _findActive(String id) {
    return (_db.select(
      _db.financialTransactions,
    )..where((t) => t.id.equals(id) & t.deletedAt.isNull())).getSingleOrNull();
  }

  Future<FinancialPeriod> _getOrCreatePeriod(
    YearMonth month,
    DateTime now,
  ) async {
    final query = _db.select(_db.financialPeriods)
      ..where((p) => p.year.equals(month.year) & p.month.equals(month.month));

    final existing = await query.getSingleOrNull();
    if (existing != null) return existing;

    final id = _uuid.v4();
    await _db
        .into(_db.financialPeriods)
        .insert(
          FinancialPeriodsCompanion.insert(
            id: id,
            year: month.year,
            month: month.month,
            startDate: month.firstDay,
            endDate: month.lastDay,
            createdAt: now,
            updatedAt: now,
          ),
        );
    return (_db.select(
      _db.financialPeriods,
    )..where((p) => p.id.equals(id))).getSingle();
  }

  /// Recalcula los totales de un mes a partir de sus movimientos vigentes:
  /// los totales por categoría y corte, y los totales generales del mes.
  Future<void> _recalculatePeriod(String periodId, DateTime now) async {
    final t = _db.financialTransactions;
    final c = _db.categories;

    final rows = await (_db.select(t).join([
      innerJoin(c, c.id.equalsExp(t.categoryId)),
    ])..where(t.periodId.equals(periodId) & t.deletedAt.isNull())).get();

    var income = 0;
    var extraIncome = 0;
    var expense = 0;
    var antExpense = 0;
    final byCategoryAndCut = <(String, int), _CategoryTotal>{};

    for (final row in rows) {
      final tx = row.readTable(t);
      final category = row.readTable(c);

      if (tx.isIncome) {
        income += tx.amount;
        // Ingreso esporádico (no fijo) = ingreso adicional.
        if (!category.isFixed) extraIncome += tx.amount;
      } else {
        expense += tx.amount;
        if (category.isAntExpense) antExpense += tx.amount;
      }

      final total = byCategoryAndCut.putIfAbsent((
        tx.categoryId,
        tx.cutNumber,
      ), _CategoryTotal.new);
      total.amount += tx.amount;
      total.count += 1;
    }

    await (_db.delete(
      _db.categoryPeriodTotals,
    )..where((x) => x.periodId.equals(periodId))).go();

    await _db.batch((batch) {
      batch.insertAll(_db.categoryPeriodTotals, [
        for (final entry in byCategoryAndCut.entries)
          CategoryPeriodTotalsCompanion.insert(
            periodId: periodId,
            categoryId: entry.key.$1,
            cutNumber: entry.key.$2,
            actualTotal: Value(entry.value.amount),
            txCount: Value(entry.value.count),
            updatedAt: now,
          ),
      ]);
    });

    await (_db.update(
      _db.financialPeriods,
    )..where((p) => p.id.equals(periodId))).write(
      FinancialPeriodsCompanion(
        incomeActualTotal: Value(income),
        extraIncomeActualTotal: Value(extraIncome),
        expenseActualTotal: Value(expense),
        antExpenseActualTotal: Value(antExpense),
        updatedAt: Value(now),
      ),
    );
  }
}

class _CategoryTotal {
  int amount = 0;
  int count = 0;
}
