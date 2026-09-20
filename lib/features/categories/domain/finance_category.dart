/// Categoría de ingreso o de gasto.
///
/// Regla: solo un gasto variable puede marcarse como hormiga.
class FinanceCategory {
  const FinanceCategory({
    required this.id,
    required this.name,
    required this.isIncome,
    required this.isFixed,
    this.isAntExpense = false,
    this.iconKey = 'category',
    this.colorHex = '#1E6FD9',
    this.sortOrder = 0,
    this.isArchived = false,
    this.isDefault = false,
  }) : assert(
          !isAntExpense || (!isIncome && !isFixed),
          'Solo un gasto variable puede ser hormiga',
        );

  final String id;
  final String name;
  final bool isIncome;

  /// Gasto fijo/recurrente (true) o variable (false).
  /// En ingresos: recurrente (true) o esporádico (false).
  final bool isFixed;

  /// Gasto hormiga: gasto pequeño y frecuente.
  final bool isAntExpense;

  final String iconKey;
  final String colorHex;
  final int sortOrder;
  final bool isArchived;
  final bool isDefault;
}