import '../../../core/domain/money.dart';

/// Un movimiento tal como se muestra en la lista, con los datos de su
/// categoría ya incluidos.
class MovementItem {
  const MovementItem({
    required this.id,
    required this.categoryId,
    required this.categoryName,
    required this.categoryIconKey,
    required this.categoryColorHex,
    required this.isIncome,
    required this.isAntExpense,
    required this.amount,
    required this.date,
    required this.cutNumber,
    required this.description,
  });

  final String id;
  final String categoryId;
  final String categoryName;
  final String categoryIconKey;
  final String categoryColorHex;
  final bool isIncome;
  final bool isAntExpense;
  final Money amount;

  /// Solo la fecha (a las 00:00).
  final DateTime date;

  /// 1 = primera quincena, 2 = segunda.
  final int cutNumber;
  final String description;
}