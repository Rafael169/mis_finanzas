import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/domain/money.dart';
import '../../../core/domain/year_month.dart';
import '../domain/period_repository.dart';

class DriftPeriodRepository implements PeriodRepository {
  DriftPeriodRepository(this._db);

  final AppDatabase _db;

  @override
  Stream<PeriodSummary> watchSummary(YearMonth month) {
    final query = _db.select(_db.financialPeriods)
      ..where((p) => p.year.equals(month.year) & p.month.equals(month.month));

    return query.watchSingleOrNull().map((row) {
      if (row == null) return PeriodSummary.empty;
      return PeriodSummary(
        income: Money.fromMinor(row.incomeActualTotal),
        extraIncome: Money.fromMinor(row.extraIncomeActualTotal),
        expense: Money.fromMinor(row.expenseActualTotal),
        antExpense: Money.fromMinor(row.antExpenseActualTotal),
      );
    });
  }
}