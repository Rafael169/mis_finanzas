import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import '../../../core/domain/year_month.dart';
import '../domain/movement_impact.dart';
import '../domain/movement_repository.dart';

class DriftMovementRepository implements MovementRepository {
  DriftMovementRepository(this._db, {Uuid? uuid})
      : _uuid = uuid ?? const Uuid();

  final AppDatabase _db;
  final Uuid _uuid;

  @override
  Future<void> add(NewMovement movement, MovementImpact impact) {
    // Todo dentro de una transacción: o se guarda todo, o nada.
    return _db.transaction(() async {
      final now = DateTime.now();
      final period = await _getOrCreatePeriod(
        YearMonth.fromDate(movement.date),
        now,
      );

      await _db.into(_db.financialTransactions).insert(
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

      await _addToCategoryTotal(period.id, movement, now);

      await (_db.update(_db.financialPeriods)
            ..where((p) => p.id.equals(period.id)))
          .write(
        FinancialPeriodsCompanion(
          incomeActualTotal:
              Value(period.incomeActualTotal + impact.income.minorUnits),
          extraIncomeActualTotal: Value(
            period.extraIncomeActualTotal + impact.extraIncome.minorUnits,
          ),
          expenseActualTotal:
              Value(period.expenseActualTotal + impact.expense.minorUnits),
          antExpenseActualTotal: Value(
            period.antExpenseActualTotal + impact.antExpense.minorUnits,
          ),
          updatedAt: Value(now),
        ),
      );
    });
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
    await _db.into(_db.financialPeriods).insert(
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
    return (_db.select(_db.financialPeriods)..where((p) => p.id.equals(id)))
        .getSingle();
  }

  Future<void> _addToCategoryTotal(
    String periodId,
    NewMovement movement,
    DateTime now,
  ) async {
    final amount = movement.amount.minorUnits;

    final query = _db.select(_db.categoryPeriodTotals)
      ..where(
        (t) =>
            t.periodId.equals(periodId) &
            t.categoryId.equals(movement.categoryId) &
            t.cutNumber.equals(movement.cutNumber),
      );
    final existing = await query.getSingleOrNull();

    if (existing == null) {
      await _db.into(_db.categoryPeriodTotals).insert(
            CategoryPeriodTotalsCompanion.insert(
              periodId: periodId,
              categoryId: movement.categoryId,
              cutNumber: movement.cutNumber,
              actualTotal: Value(amount),
              txCount: const Value(1),
              updatedAt: now,
            ),
          );
      return;
    }

    await (_db.update(_db.categoryPeriodTotals)
          ..where(
            (t) =>
                t.periodId.equals(periodId) &
                t.categoryId.equals(movement.categoryId) &
                t.cutNumber.equals(movement.cutNumber),
          ))
        .write(
      CategoryPeriodTotalsCompanion(
        actualTotal: Value(existing.actualTotal + amount),
        txCount: Value(existing.txCount + 1),
        updatedAt: Value(now),
      ),
    );
  }
}