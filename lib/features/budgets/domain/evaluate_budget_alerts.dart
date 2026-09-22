import '../../../core/domain/money.dart';
import '../../categories/domain/finance_category.dart';
import 'budget_alert.dart';

/// Un presupuesto tal como está guardado, para evaluar su alerta.
class BudgetSnapshot {
  const BudgetSnapshot({
    required this.category,
    required this.actual,
    required this.limit,
    required this.previousLevel,
  });

  final FinanceCategory category;
  final Money actual;
  final Money limit;
  final AlertLevel previousLevel;
}

/// Resultado: el nuevo nivel a guardar, y si hay que avisar al usuario.
class AlertEvaluation {
  const AlertEvaluation({required this.newLevel, this.alert});

  final AlertLevel newLevel;

  /// No nulo solo cuando el nivel subió (por ejemplo, de ok a advertencia).
  final BudgetAlert? alert;
}

/// Evalúa un presupuesto y decide si hay que avisar.
///
/// Solo avisa cuando el nivel SUBE respecto al guardado. Si el nivel baja
/// (por ejemplo, tras editar o borrar un movimiento), se actualiza el
/// nivel guardado en silencio, sin mostrar nada.
AlertEvaluation evaluateBudgetAlert({
  required FinanceCategory category,
  required Money actual,
  required Money limit,
  required AlertLevel previousLevel,
  required int alertPercent,
}) {
  final newLevel = alertLevelFor(
    actual: actual,
    limit: limit,
    alertPercent: alertPercent,
  );

  if (newLevel.value <= previousLevel.value) {
    return AlertEvaluation(newLevel: newLevel);
  }

  return AlertEvaluation(
    newLevel: newLevel,
    alert: BudgetAlert(
      category: category,
      level: newLevel,
      actual: actual,
      limit: limit,
    ),
  );
}