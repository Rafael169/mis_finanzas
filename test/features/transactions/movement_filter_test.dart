import 'package:flutter_test/flutter_test.dart';
import 'package:mis_finanzas/core/domain/money.dart';
import 'package:mis_finanzas/features/transactions/domain/movement_filter.dart';
import 'package:mis_finanzas/features/transactions/domain/movement_item.dart';

MovementItem item({
  String id = '1',
  String categoryId = 'c1',
  bool isIncome = false,
  int cut = 1,
}) {
  return MovementItem(
    id: id,
    categoryId: categoryId,
    categoryName: 'Categoría',
    categoryIconKey: 'category',
    categoryColorHex: '#1E6FD9',
    isIncome: isIncome,
    isAntExpense: false,
    amount: const Money.fromUnits(1000),
    date: DateTime(2026, 8, 10),
    cutNumber: cut,
    description: '',
  );
}

void main() {
  final movements = [
    item(id: 'a', categoryId: 'salario', isIncome: true, cut: 1),
    item(id: 'b', categoryId: 'mecatos', cut: 1),
    item(id: 'c', categoryId: 'mecatos', cut: 2),
    item(id: 'd', categoryId: 'arriendo', cut: 2),
  ];

  List<String> ids(MovementFilter filter) =>
      filter.apply(movements).map((m) => m.id).toList();

  test('sin filtros deja pasar todo y no está activo', () {
    const filter = MovementFilter();

    expect(filter.isActive, isFalse);
    expect(ids(filter), ['a', 'b', 'c', 'd']);
  });

  test('filtra por tipo', () {
    expect(ids(const MovementFilter(type: MovementTypeFilter.income)), ['a']);
    expect(
      ids(const MovementFilter(type: MovementTypeFilter.expense)),
      ['b', 'c', 'd'],
    );
  });

  test('filtra por corte', () {
    expect(ids(const MovementFilter(cut: 1)), ['a', 'b']);
    expect(ids(const MovementFilter(cut: 2)), ['c', 'd']);
  });

  test('filtra por categoría', () {
    expect(ids(const MovementFilter(categoryId: 'mecatos')), ['b', 'c']);
  });

  test('los filtros se combinan', () {
    const filter = MovementFilter(
      type: MovementTypeFilter.expense,
      cut: 2,
      categoryId: 'mecatos',
    );

    expect(filter.isActive, isTrue);
    expect(ids(filter), ['c']);
  });

  test('cambiar el tipo limpia la categoría pero conserva el corte', () {
    const filter = MovementFilter(cut: 2, categoryId: 'mecatos');

    final changed = filter.withType(MovementTypeFilter.income);

    expect(changed.categoryId, isNull);
    expect(changed.cut, 2);
    expect(changed.type, MovementTypeFilter.income);
  });
}