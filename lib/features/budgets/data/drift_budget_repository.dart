import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import '../../../core/domain/money.dart';
import '../../../core/domain/year_month.dart';
import '../../categories/domain/finance_category.dart';
import '../domain/budget_repository.dart';
import '../domain/category_budget.dart';

class DriftBudgetRepository implements BudgetRepository {
  DriftBudgetRepository(this._db, {Uuid? uuid}) : _uuid = uuid ?? const Uuid();

  final AppDatabase _db;
  final Uuid _uuid;

  @override
  Stream<List<CategoryBudget>> watchMonth(YearMonth month) {
    // Esta consulta no devuelve datos: solo avisa cuando cambia alguna de
    // las tablas que intervienen, y entonces se vuelve a leer todo.
    final trigger = _db.customSelect(
      'SELECT 1',
      readsFrom: {
        _db.categories,
        _db.financialPeriods,
        _db.budgetItems,
        _db.categoryPeriodTotals,
      },
    ).watch();

    return trigger.asyncMap((_) => _load(month));
  }

  Future<List<CategoryBudget>> _load(YearMonth month) async {
    final categoryRows = await (_db.select(_db.categories)
          ..where((c) => c.isArchived.equals(false))
          ..orderBy([
            (c) => OrderingTerm.asc(c.sortOrder),
            (c) => OrderingTerm.asc(c.name),
          ]))
        .get();

    final period = await _findPeriod(month);

    // categoría -> corte -> monto
    final limits = <String, Map<int, int>>{};
    final actuals = <String, Map<int, int>>{};

    if (period != null) {
      final items = await (_db.select(_db.budgetItems)
            ..where((b) => b.periodId.equals(period.id)))
          .get();
      for (final item in items) {
        (limits[item.categoryId] ??= {})[item.cutNumber] = item.amountLimit;
      }

      final totals = await (_db.select(_db.categoryPeriodTotals)
            ..where((t) => t.periodId.equals(period.id)))
          .get();
      for (final total in totals) {
        (actuals[total.categoryId] ??= {})[total.cutNumber] =
            total.actualTotal;
      }
    }

    return [
      for (final row in categoryRows)
        _toBudget(row, limits[row.id] ?? const {}, actuals[row.id] ?? const {}),
    ];
  }

  CategoryBudget _toBudget(
    Category row,
    Map<int, int> limits,
    Map<int, int> actuals,
  ) {
    Money? limit(int cut) {
      final value = limits[cut];
      return value == null ? null : Money.fromMinor(value);
    }

    Money actual(int cut) => Money.fromMinor(actuals[cut] ?? 0);

    return CategoryBudget(
      category: FinanceCategory(
        id: row.id,
        name: row.name,
        isIncome: row.isIncome,
        isFixed: row.isFixed,
        isAntExpense: row.isAntExpense,
        iconKey: row.iconKey,
        colorHex: row.colorHex,
        sortOrder: row.sortOrder,
        isArchived: row.isArchived,
        isDefault: row.isDefault,
      ),
      monthlyLimit: limit(0),
      cut1Limit: limit(1),
      cut2Limit: limit(2),
      actualCut1: actual(1),
      actualCut2: actual(2),
    );
  }

  @override
  Future<void> replaceLimits({
    required YearMonth month,
    required String categoryId,
    required Map<int, Money> limits,
  }) {
    return _db.transaction(() async {
      final now = DateTime.now();

      final found = await _findPeriod(month);
      // Quitar un presupuesto de un mes que no existe no requiere nada.
      if (found == null && limits.isEmpty) return;
      final period = found ?? await _createPeriod(month, now);

      final existing = await (_db.select(_db.budgetItems)
            ..where(
              (b) =>
                  b.periodId.equals(period.id) &
                  b.categoryId.equals(categoryId),
            ))
          .get();
      final byCut = {for (final item in existing) item.cutNumber: item};

      // Quita los límites que ya no están.
      for (final entry in byCut.entries) {
        if (!limits.containsKey(entry.key)) {
          await (_db.delete(_db.budgetItems)
                ..where((b) => b.id.equals(entry.value.id)))
              .go();
        }
      }

      // Crea o actualiza los demás.
      for (final entry in limits.entries) {
        final current = byCut[entry.key];
        if (current == null) {
          await _db.into(_db.budgetItems).insert(
                BudgetItemsCompanion.insert(
                  id: _uuid.v4(),
                  periodId: period.id,
                  categoryId: categoryId,
                  cutNumber: Value(entry.key),
                  amountLimit: entry.value.minorUnits,
                  createdAt: now,
                  updatedAt: now,
                ),
              );
        } else if (current.amountLimit != entry.value.minorUnits) {
          await (_db.update(_db.budgetItems)
                ..where((b) => b.id.equals(current.id)))
              .write(
            BudgetItemsCompanion(
              amountLimit: Value(entry.value.minorUnits),
              // Con un límite nuevo, las alertas se evalúan de cero.
              lastAlertLevel: const Value(0),
              updatedAt: Value(now),
            ),
          );
        }
      }

      await _recalculateBudgetTotals(period.id, now);
    });
  }

  @override
  Future<int> copyFromPreviousMonth(YearMonth month) {
    return _db.transaction(() async {
      final source = await _findPeriod(month.previous);
      if (source == null) return 0;

      final sourceItems = await (_db.select(_db.budgetItems)
            ..where((b) => b.periodId.equals(source.id)))
          .get();
      if (sourceItems.isEmpty) return 0;

      final now = DateTime.now();
      final target = await _findPeriod(month) ?? await _createPeriod(month, now);

      final alreadyBudgeted = (await (_db.select(_db.budgetItems)
                ..where((b) => b.periodId.equals(target.id)))
              .get())
          .map((b) => b.categoryId)
          .toSet();

      final copied = <String>{};
      for (final item in sourceItems) {
        if (alreadyBudgeted.contains(item.categoryId)) continue;

        await _db.into(_db.budgetItems).insert(
              BudgetItemsCompanion.insert(
                id: _uuid.v4(),
                periodId: target.id,
                categoryId: item.categoryId,
                cutNumber: Value(item.cutNumber),
                amountLimit: item.amountLimit,
                alertPercent: Value(item.alertPercent),
                createdAt: now,
                updatedAt: now,
              ),
            );
        copied.add(item.categoryId);
      }

      if (copied.isEmpty) return 0;
      await _recalculateBudgetTotals(target.id, now);
      return copied.length;
    });
  }

  /// Recalcula los totales de presupuesto del mes (ingresos y gastos).
  Future<void> _recalculateBudgetTotals(String periodId, DateTime now) async {
    final b = _db.budgetItems;
    final c = _db.categories;

    final rows = await (_db
            .select(b)
            .join([innerJoin(c, c.id.equalsExp(b.categoryId))])
          ..where(b.periodId.equals(periodId)))
        .get();

    var income = 0;
    var expense = 0;
    for (final row in rows) {
      final amount = row.readTable(b).amountLimit;
      if (row.readTable(c).isIncome) {
        income += amount;
      } else {
        expense += amount;
      }
    }

    await (_db.update(_db.financialPeriods)
          ..where((p) => p.id.equals(periodId)))
        .write(
      FinancialPeriodsCompanion(
        incomeBudgetTotal: Value(income),
        expenseBudgetTotal: Value(expense),
        updatedAt: Value(now),
      ),
    );
  }

  Future<FinancialPeriod?> _findPeriod(YearMonth month) {
    return (_db.select(_db.financialPeriods)
          ..where(
            (p) => p.year.equals(month.year) & p.month.equals(month.month),
          ))
        .getSingleOrNull();
  }

  Future<FinancialPeriod> _createPeriod(YearMonth month, DateTime now) async {
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
}