import 'package:flutter_test/flutter_test.dart';
import 'package:mis_finanzas/features/categories/domain/default_categories.dart';

void main() {
  test('tiene 14 categorías: 2 de ingreso y 12 de gasto', () {
    final incomes = defaultCategorySeeds.where((c) => c.isIncome);
    final expenses = defaultCategorySeeds.where((c) => !c.isIncome);

    expect(defaultCategorySeeds, hasLength(14));
    expect(incomes, hasLength(2));
    expect(expenses, hasLength(12));
  });

  test('no hay nombres repetidos', () {
    final names = defaultCategorySeeds.map((c) => c.name).toSet();
    expect(names, hasLength(defaultCategorySeeds.length));
  });

  test('solo los gastos variables pueden ser hormiga', () {
    for (final seed in defaultCategorySeeds) {
      if (seed.isAntExpense) {
        expect(seed.isIncome, isFalse, reason: seed.name);
        expect(seed.isFixed, isFalse, reason: seed.name);
      }
    }
  });

  test('Mecatos y Otras D son las únicas categorías hormiga', () {
    final antNames = defaultCategorySeeds
        .where((c) => c.isAntExpense)
        .map((c) => c.name)
        .toSet();
    expect(antNames, {'Mecatos', 'Otras D'});
  });
}