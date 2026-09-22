import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/domain/money.dart';
import '../../categories/domain/finance_category.dart';
import '../domain/analytics_repository.dart';
import '../domain/category_year_total.dart';
import '../domain/yearly_summary.dart';

class DriftAnalyticsRepository implements AnalyticsRepository {
  DriftAnalyticsRepository(this._db);

  final AppDatabase _db;

  /// Esta consulta no devuelve datos: solo avisa cuando cambia alguna de
  /// las tablas que intervienen, y entonces se vuelve a leer todo.
  Stream<void> get _trigger => _db.customSelect(
        'SELECT 1',
        readsFrom: {_db.financialPeriods, _db.categoryPeriodTotals, _db.categories},
      ).watch();

  @override
  Stream<YearlySummary> watchYear(int year) {
    return _trigger.asyncMap((_) => _loadYear(year));
  }

  Future<YearlySummary> _loadYear(int year) async {
    final periods = await (_db.select(_db.financialPeriods)
          ..where((p) => p.year.equals(year)))
        .get();

    if (periods.isEmpty) return YearlySummary.empty(year);

    var income = 0;
    var expense = 0;
    final balances = List<Money>.filled(12, Money.zero);

    for (final period in periods) {
      income += period.incomeActualTotal;
      expense += period.expenseActualTotal;
      balances[period.month - 1] = Money.fromMinor(
        period.incomeActualTotal - period.expenseActualTotal,
      );
    }

    return YearlySummary(
      year: year,
      totalIncome: Money.fromMinor(income),
      totalExpense: Money.fromMinor(expense),
      monthlyBalances: balances,
    );
  }

  @override
  Stream<List<CategoryYearTotal>> watchExpenseBreakdown(int year) {
    return _trigger.asyncMap((_) => _loadBreakdown(year));
  }

  Future<List<CategoryYearTotal>> _loadBreakdown(int year) async {
    final periods = await (_db.select(_db.financialPeriods)
          ..where((p) => p.year.equals(year)))
        .get();
    if (periods.isEmpty) return const [];

    final periodIds = periods.map((p) => p.id).toList();
    final t = _db.categoryPeriodTotals;
    final c = _db.categories;

    final rows = await (_db
            .select(t)
            .join([innerJoin(c, c.id.equalsExp(t.categoryId))])
          ..where(t.periodId.isIn(periodIds) & c.isIncome.equals(false)))
        .get();

    final totals = <String, int>{};
    final categoriesById = <String, Category>{};
    for (final row in rows) {
      final total = row.readTable(t);
      final category = row.readTable(c);
      categoriesById[category.id] = category;
      totals[category.id] = (totals[category.id] ?? 0) + total.actualTotal;
    }

    final result = [
      for (final entry in totals.entries)
        CategoryYearTotal(
          category: _toEntity(categoriesById[entry.key]!),
          actual: Money.fromMinor(entry.value),
        ),
    ]..sort((a, b) => b.actual.minorUnits.compareTo(a.actual.minorUnits));

    return result;
  }

  FinanceCategory _toEntity(Category row) {
    return FinanceCategory(
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
    );
  }
}