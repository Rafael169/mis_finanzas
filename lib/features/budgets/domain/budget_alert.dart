import '../../../core/domain/money.dart';
import '../../categories/domain/finance_category.dart';

/// Nivel de alerta de un presupuesto: 0 = nada, 1 = advertencia, 2 = superado.
enum AlertLevel {
  none(0),
  warning(1),
  over(2);

  const AlertLevel(this.value);

  final int value;

  static AlertLevel fromValue(int value) {
    return AlertLevel.values.firstWhere(
      (l) => l.value == value,
      orElse: () => AlertLevel.none,
    );
  }
}

/// Aviso de que una categoría cruzó un umbral de su presupuesto.
class BudgetAlert {
  const BudgetAlert({
    required this.category,
    required this.level,
    required this.actual,
    required this.limit,
  });

  final FinanceCategory category;
  final AlertLevel level;
  final Money actual;
  final Money limit;
}

/// Nivel que corresponde a un gasto frente a su límite. Solo aplica a
/// gastos: en ingresos no hay alertas.
AlertLevel alertLevelFor({
  required Money actual,
  required Money limit,
  required int alertPercent,
}) {
  if (limit.isZero) return AlertLevel.none;
  if (actual > limit) return AlertLevel.over;
  if (actual.minorUnits * 100 >= limit.minorUnits * alertPercent) {
    return AlertLevel.warning;
  }
  return AlertLevel.none;
}