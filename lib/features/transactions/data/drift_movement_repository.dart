import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import '../../../core/domain/year_month.dart';
import '../../budgets/domain/budget_alert.dart';
import '../../budgets/domain/evaluate_budget_alerts.dart';
import '../../categories/domain/finance_category.dart';
import '../domain/movement_repository.dart';
import '../domain/register_movement.dart';
import '../../../core/domain/money.dart';

class DriftMovementRepository implements MovementRepository {
  DriftMovementRepository(this._db, {Uuid? uuid})
      : _uuid = uuid ?? const Uuid();

  final AppDatabase _db;
  final Uuid _uuid;

  /// Alertas producidas por la última operación (add, update, softDelete o
  /// restore). Se limpia al empezar cada una; léela justo después de un
  /// `await` a esa operación.
  List<BudgetAlert> lastAlerts = const [];

  @override
  Future<void> add(MovementData movement) {
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

      lastAlerts = await _recalculatePeriod(period.id, now);
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

      await (_db.update(_db.financialTransactions)
            ..where((t) => t.id.equals(movement.id)))
          .write(
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

      final alerts = await _recalculatePeriod(period.id, now);
      if (existing.periodId != period.id) {
        await _recalculatePeriod(existing.periodId, now);
      }
      lastAlerts = alerts;
    });
  }

  @override
  Future<void> softDelete(String id) {
    return _db.transaction(() async {
      final existing = await _findActive(id);
      if (existing == null) {
        lastAlerts = const [];
        return;
      }

      final now = DateTime.now();
      await (_db.update(_db.financialTransactions)
            ..where((t) => t.id.equals(id)))
          .write(
        FinancialTransactionsCompanion(
          deletedAt: Value(now),
          updatedAt: Value(now),
        ),
      );

      lastAlerts = await _recalculatePeriod(existing.periodId, now);
    });
  }

  @override
  Future<void> restore(String id) {
    return _db.transaction(() async {
      final deleted = await (_db.select(_db.financialTransactions)
            ..where((t) => t.id.equals(id) & t.deletedAt.isNotNull()))
          .getSingleOrNull();
      if (deleted == null) {
        lastAlerts = const [];
        return;
      }

      final now = DateTime.now();
      await (_db.update(_db.financialTransactions)
            ..where((t) => t.id.equals(id)))
          .write(
        FinancialTransactionsCompanion(
          deletedAt: const Value<DateTime?>(null),
          updatedAt: Value(now),
        ),
      );

      lastAlerts = await _recalculatePeriod(deleted.periodId, now);
    });
  }

  Future<FinancialTransaction?> _findActive(String id) {
    return (_db.select(_db.financialTransactions)
          ..where((t) => t.id.equals(id) & t.deletedAt.isNull()))
        .getSingleOrNull();
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

  /// Recalcula los totales de un mes a partir de sus movimientos vigentes,
  /// evalúa las alertas de presupuesto y devuelve las que subieron de nivel.
  Future<List<BudgetAlert>> _recalculatePeriod(
    String periodId,
    DateTime now,
  ) async {
    final t = _db.financialTransactions;
    final c = _db.categories;

    final rows = await (_db
            .select(t)
            .join([innerJoin(c, c.id.equalsExp(t.categoryId))])
          ..where(t.periodId.equals(periodId) & t.deletedAt.isNull()))
        .get();

    var income = 0;
    var extraIncome = 0;
    var expense = 0;
    var antExpense = 0;
    final byCategoryAndCut = <(String, int), _CategoryTotal>{};
    final categoriesById = <String, Category>{};

    for (final row in rows) {
      final tx = row.readTable(t);
      final category = row.readTable(c);
      categoriesById[category.id] = category;

      if (tx.isIncome) {
        income += tx.amount;
        if (!category.isFixed) extraIncome += tx.amount;
      } else {
        expense += tx.amount;
        if (category.isAntExpense) antExpense += tx.amount;
      }

      final total = byCategoryAndCut.putIfAbsent(
        (tx.categoryId, tx.cutNumber),
        _CategoryTotal.new,
      );
      total.amount += tx.amount;
      total.count += 1;
    }

    await (_db.delete(_db.categoryPeriodTotals)
          ..where((x) => x.periodId.equals(periodId)))
        .go();

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

    await (_db.update(_db.financialPeriods)
          ..where((p) => p.id.equals(periodId)))
        .write(
      FinancialPeriodsCompanion(
        incomeActualTotal: Value(income),
        extraIncomeActualTotal: Value(extraIncome),
        expenseActualTotal: Value(expense),
        antExpenseActualTotal: Value(antExpense),
        updatedAt: Value(now),
      ),
    );

    return _evaluateAlerts(periodId, byCategoryAndCut, categoriesById, now);
  }

  /// Compara, para cada categoría con presupuesto, el real recién calculado
  /// contra su límite (mensual o por corte) y actualiza el nivel guardado.
  /// Solo devuelve las alertas cuyo nivel subió.
  Future<List<BudgetAlert>> _evaluateAlerts(
    String periodId,
    Map<(String, int), _CategoryTotal> actualsByCategoryAndCut,
    Map<String, Category> categoriesById,
    DateTime now,
  ) async {
    final budgetItems = await (_db.select(_db.budgetItems)
          ..where((b) => b.periodId.equals(periodId)))
        .get();
    if (budgetItems.isEmpty) return const [];

    final settings = await _db.select(_db.appSettings).getSingleOrNull();
    final alertPercent = settings?.defaultAlertPercent ?? 80;

    // Actual por categoría: total del mes (0) o de cada corte (1, 2).
    final actualByCategory = <String, Map<int, int>>{};
    for (final entry in actualsByCategoryAndCut.entries) {
      final (categoryId, cut) = entry.key;
      final map = actualByCategory.putIfAbsent(categoryId, () => {});
      map[cut] = entry.value.amount;
      map[0] = (map[0] ?? 0) + entry.value.amount;
    }

    final alerts = <BudgetAlert>[];

    for (final item in budgetItems) {
      final row = categoriesById[item.categoryId];
      // Un gasto sin ningún movimiento en el mes no está en categoriesById;
      // su real es cero y nunca supera el presupuesto.
      if (row == null || row.isIncome) continue;

      final actualMinor = actualByCategory[item.categoryId]?[item.cutNumber] ?? 0;

      final evaluation = evaluateBudgetAlert(
        category: FinanceCategory(
          id: row.id,
          name: row.name,
          isIncome: row.isIncome,
          isFixed: row.isFixed,
          isAntExpense: row.isAntExpense,
          iconKey: row.iconKey,
          colorHex: row.colorHex,
          sortOrder: row.sortOrder,
        ),
        actual: Money.fromMinor(actualMinor),
        limit: Money.fromMinor(item.amountLimit),
        previousLevel: AlertLevel.fromValue(item.lastAlertLevel),
        alertPercent: alertPercent,
      );

      if (evaluation.newLevel.value != item.lastAlertLevel) {
        await (_db.update(_db.budgetItems)..where((b) => b.id.equals(item.id)))
            .write(
          BudgetItemsCompanion(
            lastAlertLevel: Value(evaluation.newLevel.value),
            updatedAt: Value(now),
          ),
        );
      }

      if (evaluation.alert != null) alerts.add(evaluation.alert!);
    }

    return alerts;
  }
}

class _CategoryTotal {
  int amount = 0;
  int count = 0;
}