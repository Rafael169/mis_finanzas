import 'package:flutter_test/flutter_test.dart';
import 'package:mis_finanzas/core/domain/money.dart';
import 'package:mis_finanzas/features/budgets/domain/budget_status.dart';

void main() {
  const limit = Money.fromUnits(100000);

  BudgetStatus expense(int actualUnits, {int alertPercent = 80}) {
    return budgetStatus(
      isIncome: false,
      actual: Money.fromUnits(actualUnits),
      limit: limit,
      alertPercent: alertPercent,
    );
  }

  test('sin límite no hay estado', () {
    expect(
      budgetStatus(
        isIncome: false,
        actual: const Money.fromUnits(5),
        limit: null,
      ),
      BudgetStatus.none,
    );
  });

  test('un gasto por debajo del umbral está bien', () {
    expect(expense(79999), BudgetStatus.ok);
  });

  test('un gasto que llega al umbral del 80 % pasa a advertencia', () {
    expect(expense(80000), BudgetStatus.warning);
  });

  test('un gasto exactamente en el límite sigue siendo advertencia', () {
    expect(expense(100000), BudgetStatus.warning);
  });

  test('un gasto por encima del límite está superado', () {
    expect(expense(100001), BudgetStatus.over);
  });

  test('el umbral se puede personalizar', () {
    expect(expense(85000, alertPercent: 90), BudgetStatus.ok);
    expect(expense(90000, alertPercent: 90), BudgetStatus.warning);
  });

  test('un ingreso está pendiente hasta alcanzar lo proyectado', () {
    BudgetStatus income(int units) => budgetStatus(
          isIncome: true,
          actual: Money.fromUnits(units),
          limit: limit,
        );

    expect(income(99999), BudgetStatus.pending);
    expect(income(100000), BudgetStatus.reached);
    expect(income(150000), BudgetStatus.reached);
  });
}