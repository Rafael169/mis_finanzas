import '../../../core/domain/money.dart';
import 'movement_item.dart';

/// Movimientos de un mismo día.
class DayGroup {
  const DayGroup(this.date, this.items);

  final DateTime date;
  final List<MovementItem> items;
}

/// Agrupa por día. Espera la lista ya ordenada por fecha (la que entrega el
/// repositorio) y conserva ese orden.
List<DayGroup> groupByDay(List<MovementItem> items) {
  final groups = <DayGroup>[];
  for (final item in items) {
    final day = DateTime(item.date.year, item.date.month, item.date.day);
    if (groups.isNotEmpty && groups.last.date == day) {
      groups.last.items.add(item);
    } else {
      groups.add(DayGroup(day, [item]));
    }
  }
  return groups;
}

/// Totales de ingresos y gastos de una lista de movimientos.
class MovementTotals {
  const MovementTotals({required this.income, required this.expense});

  final Money income;
  final Money expense;
}

MovementTotals totalsOf(List<MovementItem> items) {
  var income = Money.zero;
  var expense = Money.zero;
  for (final item in items) {
    if (item.isIncome) {
      income += item.amount;
    } else {
      expense += item.amount;
    }
  }
  return MovementTotals(income: income, expense: expense);
}