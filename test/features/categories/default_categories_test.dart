import 'package:flutter_test/flutter_test.dart';
import 'package:mis_finanzas/features/categories/domain/default_categories.dart';

void main() {
  test('el catálogo básico tiene 15 categorías: 2 de ingreso y 13 de gasto',
      () {
    final incomes = defaultCategorySeeds.where((c) => c.isIncome);
    final expenses = defaultCategorySeeds.where((c) => !c.isIncome);

    expect(defaultCategorySeeds, hasLength(15));
    expect(incomes, hasLength(2));
    expect(expenses, hasLength(13));
  });

  test('no hay nombres repetidos en el catálogo básico', () {
    final names = defaultCategorySeeds.map((c) => c.name).toSet();
    expect(names, hasLength(defaultCategorySeeds.length));
  });

  test('no hay nombres repetidos entre el básico y las sugeridas', () {
    final basicNames = defaultCategorySeeds.map((c) => c.name).toSet();
    final suggestedNames = suggestedCategorySeeds.map((c) => c.name).toSet();
    expect(basicNames.intersection(suggestedNames), isEmpty);
  });

  test('solo los gastos variables pueden ser hormiga', () {
    for (final seed in [...defaultCategorySeeds, ...suggestedCategorySeeds]) {
      if (seed.isAntExpense) {
        expect(seed.isIncome, isFalse, reason: seed.name);
        expect(seed.isFixed, isFalse, reason: seed.name);
      }
    }
  });

  test('las categorías hormiga del catálogo básico son las esperadas', () {
    final antNames = defaultCategorySeeds
        .where((c) => c.isAntExpense)
        .map((c) => c.name)
        .toSet();
    expect(antNames, {'Mecatos', 'Suscripciones Digitales', 'Comida a Domicilio'});
  });

  test('las sugeridas tienen 29 categorías adicionales', () {
    expect(suggestedCategorySeeds, hasLength(29));
  });
}