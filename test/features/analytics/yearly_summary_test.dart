import 'package:flutter_test/flutter_test.dart';
import 'package:mis_finanzas/core/domain/money.dart';
import 'package:mis_finanzas/features/analytics/domain/yearly_summary.dart';

void main() {
  test('empty tiene todo en cero y 12 meses', () {
    final summary = YearlySummary.empty(2026);

    expect(summary.totalIncome, Money.zero);
    expect(summary.totalExpense, Money.zero);
    expect(summary.monthlyBalances, hasLength(12));
    expect(summary.balance, Money.zero);
  });

  test('balance es ingresos menos gastos', () {
    final summary = YearlySummary(
      year: 2026,
      totalIncome: const Money.fromUnits(2000000),
      totalExpense: const Money.fromUnits(800000),
      monthlyBalances: List.filled(12, Money.zero),
    );

    expect(summary.balance, const Money.fromUnits(1200000));
  });
}