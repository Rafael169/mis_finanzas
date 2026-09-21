import 'package:flutter_test/flutter_test.dart';
import 'package:mis_finanzas/core/domain/money.dart';
import 'package:mis_finanzas/features/budgets/domain/budget_status.dart';
import 'package:mis_finanzas/features/budgets/domain/category_budget.dart';
import 'package:mis_finanzas/features/categories/domain/finance_category.dart';

void main() {
  const rent = FinanceCategory(
    id: 'rent',
    name: 'Arriendo',
    isIncome: false,
    isFixed: true,
  );
  const food = FinanceCategory(
    id: 'food',
    name: 'Mercado',
    isIncome: false,
    isFixed: false,
  );
  const snacks = FinanceCategory(
    id: 'snacks',
    name: 'Mecatos',
    isIncome: false,
    isFixed: false,
    isAntExpense: true,
  );
  const salary = FinanceCategory(
    id: 'salary',
    name: 'Salario',
    isIncome: true,
    isFixed: true,
  );

  test('sin presupuesto: sin límite y con el real de todo el mes', () {
    const budget = CategoryBudget(
      category: rent,
      actualCut1: Money.fromUnits(1000),
      actualCut2: Money.fromUnits(2000),
    );

    final line = budget.lineFor(BudgetView.month);

    expect(budget.mode, BudgetMode.none);
    expect(line.limit, isNull);
    expect(line.actual, const Money.fromUnits(3000));
    expect(line.status, BudgetStatus.none);
    expect(line.ratio, isNull);
  });

  test('mensual: la vista Mes usa el límite y suma ambos cortes', () {
    const budget = CategoryBudget(
      category: rent,
      monthlyLimit: Money.fromUnits(500000),
      actualCut1: Money.fromUnits(200000),
      actualCut2: Money.fromUnits(100000),
    );

    final line = budget.lineFor(BudgetView.month);

    expect(budget.mode, BudgetMode.monthly);
    expect(line.limit, const Money.fromUnits(500000));
    expect(line.actual, const Money.fromUnits(300000));
    expect(line.ratio, closeTo(0.6, 0.0001));
    expect(line.remaining, const Money.fromUnits(200000));
    expect(line.status, BudgetStatus.ok);
  });

  test('mensual: en la vista de un corte no hay límite pero sí el real', () {
    const budget = CategoryBudget(
      category: rent,
      monthlyLimit: Money.fromUnits(500000),
      actualCut1: Money.fromUnits(200000),
      actualCut2: Money.fromUnits(100000),
    );

    final line = budget.lineFor(BudgetView.cut1);

    expect(line.limit, isNull);
    expect(line.actual, const Money.fromUnits(200000));
    expect(line.status, BudgetStatus.none);
    expect(budget.monthlyLimit, const Money.fromUnits(500000));
  });

  test('por corte: la vista Mes suma los límites de los cortes', () {
    const budget = CategoryBudget(
      category: food,
      cut1Limit: Money.fromUnits(300000),
      cut2Limit: Money.fromUnits(200000),
    );

    expect(budget.mode, BudgetMode.perCut);
    expect(budget.lineFor(BudgetView.month).limit, const Money.fromUnits(500000));
  });

  test('por corte: cada corte usa su límite y uno sin límite queda vacío', () {
    const budget = CategoryBudget(
      category: food,
      cut1Limit: Money.fromUnits(300000),
    );

    expect(budget.lineFor(BudgetView.cut1).limit, const Money.fromUnits(300000));
    expect(budget.lineFor(BudgetView.cut2).limit, isNull);
    expect(budget.lineFor(BudgetView.month).limit, const Money.fromUnits(300000));
  });

  test('el estado depende del real y del límite de la vista', () {
    const overspent = CategoryBudget(
      category: rent,
      monthlyLimit: Money.fromUnits(100000),
      actualCut1: Money.fromUnits(110000),
    );
    final over = overspent.lineFor(BudgetView.month);
    expect(over.status, BudgetStatus.over);
    expect(over.remaining, -const Money.fromUnits(10000));

    const paid = CategoryBudget(
      category: salary,
      cut1Limit: Money.fromUnits(1000000),
      actualCut1: Money.fromUnits(1000000),
    );
    expect(paid.lineFor(BudgetView.cut1).status, BudgetStatus.reached);
  });

  test('los totales separan lo presupuestado de lo que no tiene presupuesto',
      () {
    final lines = [
      const CategoryBudget(
        category: rent,
        monthlyLimit: Money.fromUnits(100000),
        actualCut1: Money.fromUnits(60000),
      ).lineFor(BudgetView.month),
      const CategoryBudget(
        category: food,
        monthlyLimit: Money.fromUnits(50000),
        actualCut2: Money.fromUnits(70000),
      ).lineFor(BudgetView.month),
      const CategoryBudget(
        category: snacks,
        actualCut1: Money.fromUnits(30000),
      ).lineFor(BudgetView.month),
    ];

    final totals = totalsOfLines(lines);

    expect(totals.limit, const Money.fromUnits(150000));
    expect(totals.actual, const Money.fromUnits(130000));
    expect(totals.unbudgeted, const Money.fromUnits(30000));
    expect(totals.hasBudget, isTrue);
    expect(totals.ratio, closeTo(130000 / 150000, 0.0001));
  });
}