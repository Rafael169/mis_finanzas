import 'package:flutter_test/flutter_test.dart';
import 'package:mis_finanzas/features/categories/domain/default_categories.dart';

void main() {
  test('tiene 49 categorías: 14 de ingreso y 35 de gasto', () {
    final incomes = defaultCategorySeeds.where((c) => c.isIncome);
    final expenses = defaultCategorySeeds.where((c) => !c.isIncome);

    expect(defaultCategorySeeds, hasLength(49));
    expect(incomes, hasLength(14));
    expect(expenses, hasLength(35));
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

  test('las categorías hormiga son las esperadas', () {
    final antNames = defaultCategorySeeds
        .where((c) => c.isAntExpense)
        .map((c) => c.name)
        .toSet();
    expect(antNames, {
      'Mecatos',
      'Otras D',
      'Antojos Diarios',
      'Suscripciones Digitales',
      'Comida a Domicilio',
      'Transporte por Comodidad',
      'Otros gastos hormiga',
    });
  });
}
