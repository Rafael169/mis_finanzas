import '../../../core/domain/money.dart';
import '../../../core/domain/year_month.dart';
import '../../categories/domain/finance_category.dart';
import 'budget_repository.dart';

/// Error de validación con un mensaje que se puede mostrar al usuario.
class BudgetException implements Exception {
  const BudgetException(this.message);

  final String message;

  @override
  String toString() => message;
}

/// Asigna, cambia o quita el presupuesto de una categoría en un mes.
///
/// Un presupuesto es mensual o por corte, nunca ambos. Un monto en cero
/// se toma como "sin presupuesto".
class SaveBudget {
  SaveBudget(this._repository);

  final BudgetRepository _repository;

  Future<void> call({
    required YearMonth month,
    required FinanceCategory category,
    Money? monthly,
    Money? cut1,
    Money? cut2,
  }) async {
    Money? clean(Money? value) {
      if (value == null) return null;
      if (value.isNegative) {
        throw const BudgetException('Los montos no pueden ser negativos.');
      }
      return value.isZero ? null : value;
    }

    final monthlyLimit = clean(monthly);
    final firstCut = clean(cut1);
    final secondCut = clean(cut2);

    if (monthlyLimit != null && (firstCut != null || secondCut != null)) {
      throw const BudgetException(
        'Elige un presupuesto para todo el mes o uno por corte, no ambos.',
      );
    }
    if (category.isArchived) {
      throw const BudgetException('Esa categoría está archivada.');
    }

    await _repository.replaceLimits(
      month: month,
      categoryId: category.id,
      limits: {
        if (monthlyLimit != null) 0: monthlyLimit,
        if (firstCut != null) 1: firstCut,
        if (secondCut != null) 2: secondCut,
      },
    );
  }
}