import '../../../core/domain/money.dart';

/// Estado de una categoría frente a su presupuesto.
enum BudgetStatus {
  /// Sin presupuesto asignado.
  none,

  /// Gasto por debajo del umbral de advertencia.
  ok,

  /// Gasto que llegó al umbral (por defecto 80 %) sin superar el límite.
  warning,

  /// Gasto por encima del límite.
  over,

  /// Ingreso por debajo de lo proyectado.
  pending,

  /// Ingreso que alcanzó lo proyectado.
  reached,
}

/// Calcula el estado. Usa enteros para no depender de decimales:
/// actual / límite >= alertPercent / 100.
BudgetStatus budgetStatus({
  required bool isIncome,
  required Money actual,
  required Money? limit,
  int alertPercent = 80,
}) {
  if (limit == null || limit.isZero) return BudgetStatus.none;

  if (isIncome) {
    return actual >= limit ? BudgetStatus.reached : BudgetStatus.pending;
  }

  if (actual > limit) return BudgetStatus.over;
  if (actual.minorUnits * 100 >= limit.minorUnits * alertPercent) {
    return BudgetStatus.warning;
  }
  return BudgetStatus.ok;
}