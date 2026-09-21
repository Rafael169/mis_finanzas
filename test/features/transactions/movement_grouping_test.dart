import 'package:flutter_test/flutter_test.dart';
import 'package:mis_finanzas/core/domain/money.dart';
import 'package:mis_finanzas/features/transactions/domain/movement_grouping.dart';
import 'package:mis_finanzas/features/transactions/domain/movement_item.dart';

MovementItem item({
  required String id,
  required DateTime date,
  bool isIncome = false,
  int units = 1000,
}) {
  return MovementItem(
    id: id,
    categoryId: 'c1',
    categoryName: 'Categoría',
    categoryIconKey: 'category',
    categoryColorHex: '#1E6FD9',
    isIncome: isIncome,
    isAntExpense: false,
    amount: Money.fromUnits(units),
    date: date,
    cutNumber: date.day <= 15 ? 1 : 2,
    description: '',
  );
}

void main() {
  test('agrupa por día conservando el orden', () {
    final groups = groupByDay([
      item(id: 'a', date: DateTime(2026, 8, 20)),
      item(id: 'b', date: DateTime(2026, 8, 20)),
      item(id: 'c', date: DateTime(2026, 8, 12)),
      item(id: 'd', date: DateTime(2026, 8, 5)),
    ]);

    expect(groups.map((g) => g.date), [
      DateTime(2026, 8, 20),
      DateTime(2026, 8, 12),
      DateTime(2026, 8, 5),
    ]);
    expect(groups.first.items.map((m) => m.id), ['a', 'b']);
    expect(groups.last.items.map((m) => m.id), ['d']);
  });

  test('una lista vacía no genera grupos', () {
    expect(groupByDay(const []), isEmpty);
  });

  test('totalsOf suma ingresos y gastos por separado', () {
    final totals = totalsOf([
      item(id: 'a', date: DateTime(2026, 8, 1), isIncome: true, units: 2000000),
      item(id: 'b', date: DateTime(2026, 8, 2), units: 50000),
      item(id: 'c', date: DateTime(2026, 8, 3), units: 30000),
    ]);

    expect(totals.income, const Money.fromUnits(2000000));
    expect(totals.expense, const Money.fromUnits(80000));
  });

  test('totalsOf de una lista vacía es cero', () {
    final totals = totalsOf(const []);

    expect(totals.income, Money.zero);
    expect(totals.expense, Money.zero);
  });
}