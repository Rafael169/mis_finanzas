import 'package:flutter_test/flutter_test.dart';
import 'package:mis_finanzas/core/domain/money.dart';
import 'package:mis_finanzas/features/categories/domain/finance_category.dart';
import 'package:mis_finanzas/features/transactions/domain/movement_impact.dart';

void main() {
  const amount = Money.fromUnits(1000);

  const salary = FinanceCategory(
    id: 'a',
    name: 'Salario',
    isIncome: true,
    isFixed: true,
  );
  const extra = FinanceCategory(
    id: 'b',
    name: 'Ingresos adicionales',
    isIncome: true,
    isFixed: false,
  );
  const rent = FinanceCategory(
    id: 'c',
    name: 'Arriendo',
    isIncome: false,
    isFixed: true,
  );
  const snacks = FinanceCategory(
    id: 'd',
    name: 'Mecatos',
    isIncome: false,
    isFixed: false,
    isAntExpense: true,
  );

  test('un ingreso fijo suma solo a ingresos', () {
    final impact = MovementImpact.of(category: salary, amount: amount);

    expect(impact.income, amount);
    expect(impact.extraIncome, Money.zero);
    expect(impact.expense, Money.zero);
    expect(impact.antExpense, Money.zero);
  });

  test('un ingreso esporádico suma a ingresos y a adicionales', () {
    final impact = MovementImpact.of(category: extra, amount: amount);

    expect(impact.income, amount);
    expect(impact.extraIncome, amount);
    expect(impact.expense, Money.zero);
  });

  test('un gasto fijo suma solo a gastos', () {
    final impact = MovementImpact.of(category: rent, amount: amount);

    expect(impact.expense, amount);
    expect(impact.antExpense, Money.zero);
    expect(impact.income, Money.zero);
  });

  test('un gasto hormiga suma a gastos y a hormiga', () {
    final impact = MovementImpact.of(category: snacks, amount: amount);

    expect(impact.expense, amount);
    expect(impact.antExpense, amount);
  });

  test('reversed devuelve el efecto contrario', () {
    final impact = MovementImpact.of(category: snacks, amount: amount).reversed;

    expect(impact.expense, -amount);
    expect(impact.antExpense, -amount);
    expect(impact.income, Money.zero);
  });
}