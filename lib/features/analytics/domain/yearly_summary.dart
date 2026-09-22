import '../../../core/domain/money.dart';

/// Totales de un año.
class YearlySummary {
  const YearlySummary({
    required this.year,
    required this.totalIncome,
    required this.totalExpense,
    required this.monthlyBalances,
  });

  static YearlySummary empty(int year) => YearlySummary(
        year: year,
        totalIncome: Money.zero,
        totalExpense: Money.zero,
        monthlyBalances: List.filled(12, Money.zero),
      );

  final int year;
  final Money totalIncome;
  final Money totalExpense;

  /// Balance de cada mes; índice 0 = enero, 11 = diciembre.
  final List<Money> monthlyBalances;

  Money get balance => totalIncome - totalExpense;
}