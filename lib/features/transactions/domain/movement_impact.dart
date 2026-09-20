import '../../../core/domain/money.dart';
import '../../categories/domain/finance_category.dart';

/// Cuánto cambian los totales del mes al registrar un movimiento.
/// Con [reversed] se obtiene el efecto contrario (para eliminar o editar).
class MovementImpact {
  const MovementImpact({
    this.income = Money.zero,
    this.extraIncome = Money.zero,
    this.expense = Money.zero,
    this.antExpense = Money.zero,
  });

  factory MovementImpact.of({
    required FinanceCategory category,
    required Money amount,
  }) {
    if (category.isIncome) {
      return MovementImpact(
        income: amount,
        // Ingreso esporádico (no fijo) = ingreso adicional.
        extraIncome: category.isFixed ? Money.zero : amount,
      );
    }
    return MovementImpact(
      expense: amount,
      antExpense: category.isAntExpense ? amount : Money.zero,
    );
  }

  final Money income;
  final Money extraIncome;
  final Money expense;
  final Money antExpense;

  MovementImpact get reversed => MovementImpact(
        income: -income,
        extraIncome: -extraIncome,
        expense: -expense,
        antExpense: -antExpense,
      );
}