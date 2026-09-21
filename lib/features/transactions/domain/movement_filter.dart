import 'movement_item.dart';

enum MovementTypeFilter { all, income, expense }

/// Filtros de la lista de movimientos. Es inmutable: cada cambio crea uno nuevo.
class MovementFilter {
  const MovementFilter({
    this.type = MovementTypeFilter.all,
    this.cut,
    this.categoryId,
  });

  final MovementTypeFilter type;

  /// null = ambos cortes; 1 o 2 = solo ese corte.
  final int? cut;

  /// null = todas las categorías.
  final String? categoryId;

  bool get isActive =>
      type != MovementTypeFilter.all || cut != null || categoryId != null;

  /// Cambiar el tipo limpia la categoría, porque la elegida podría no
  /// corresponder al nuevo tipo (por ejemplo, un gasto al pasar a Ingresos).
  MovementFilter withType(MovementTypeFilter value) =>
      MovementFilter(type: value, cut: cut);

  MovementFilter withCut(int? value) =>
      MovementFilter(type: type, cut: value, categoryId: categoryId);

  MovementFilter withCategory(String? value) =>
      MovementFilter(type: type, cut: cut, categoryId: value);

  bool matches(MovementItem item) {
    switch (type) {
      case MovementTypeFilter.all:
        break;
      case MovementTypeFilter.income:
        if (!item.isIncome) return false;
      case MovementTypeFilter.expense:
        if (item.isIncome) return false;
    }
    if (cut != null && item.cutNumber != cut) return false;
    if (categoryId != null && item.categoryId != categoryId) return false;
    return true;
  }

  List<MovementItem> apply(List<MovementItem> items) =>
      items.where(matches).toList();
}