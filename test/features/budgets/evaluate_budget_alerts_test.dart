import 'package:flutter_test/flutter_test.dart';
import 'package:mis_finanzas/core/domain/money.dart';
import 'package:mis_finanzas/features/budgets/domain/budget_alert.dart';
import 'package:mis_finanzas/features/budgets/domain/evaluate_budget_alerts.dart';
import 'package:mis_finanzas/features/categories/domain/finance_category.dart';

void main() {
  const snacks = FinanceCategory(
    id: 'snacks',
    name: 'Mecatos',
    isIncome: false,
    isFixed: false,
    isAntExpense: true,
  );
  const limit = Money.fromUnits(100000);

  test('sube de ok a advertencia: avisa', () {
    final result = evaluateBudgetAlert(
      category: snacks,
      actual: const Money.fromUnits(80000),
      limit: limit,
      previousLevel: AlertLevel.none,
      alertPercent: 80,
    );

    expect(result.newLevel, AlertLevel.warning);
    expect(result.alert, isNotNull);
    expect(result.alert!.level, AlertLevel.warning);
  });

  test('sube de advertencia a superado: avisa', () {
    final result = evaluateBudgetAlert(
      category: snacks,
      actual: const Money.fromUnits(150000),
      limit: limit,
      previousLevel: AlertLevel.warning,
      alertPercent: 80,
    );

    expect(result.newLevel, AlertLevel.over);
    expect(result.alert, isNotNull);
  });

  test('se mantiene en el mismo nivel: no avisa de nuevo', () {
    final result = evaluateBudgetAlert(
      category: snacks,
      actual: const Money.fromUnits(85000),
      limit: limit,
      previousLevel: AlertLevel.warning,
      alertPercent: 80,
    );

    expect(result.newLevel, AlertLevel.warning);
    expect(result.alert, isNull);
  });

  test('baja de nivel (se editó o borró un movimiento): no avisa', () {
    final result = evaluateBudgetAlert(
      category: snacks,
      actual: const Money.fromUnits(50000),
      limit: limit,
      previousLevel: AlertLevel.over,
      alertPercent: 80,
    );

    expect(result.newLevel, AlertLevel.none);
    expect(result.alert, isNull);
  });
}
