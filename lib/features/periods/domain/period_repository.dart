import '../../../core/domain/money.dart';
import '../../../core/domain/year_month.dart';

/// Totales de un mes.
class PeriodSummary {
  const PeriodSummary({
    required this.income,
    required this.extraIncome,
    required this.expense,
    required this.antExpense,
  });

  static const empty = PeriodSummary(
    income: Money.zero,
    extraIncome: Money.zero,
    expense: Money.zero,
    antExpense: Money.zero,
  );

  final Money income;
  final Money extraIncome;
  final Money expense;
  final Money antExpense;

  /// Dinero sobrante del mes: ingresos menos gastos.
  Money get balance => income - expense;
}

abstract class PeriodRepository {
  /// Resumen del mes; si aún no tiene movimientos, todo en cero.
  Stream<PeriodSummary> watchSummary(YearMonth month);
}