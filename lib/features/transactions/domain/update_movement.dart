import '../../../core/domain/money.dart';
import '../../categories/domain/finance_category.dart';
import 'movement_repository.dart';
import 'register_movement.dart';

/// Edita un movimiento existente con las mismas reglas que al crearlo.
class UpdateMovement {
  UpdateMovement(this._repository);

  final MovementRepository _repository;

  Future<void> call({
    required String id,
    required FinanceCategory category,
    required Money amount,
    required DateTime date,
    String description = '',
  }) async {
    final valid = validateMovement(
      category: category,
      amount: amount,
      date: date,
      description: description,
    );

    await _repository.update(
      MovementData(
        id: id,
        categoryId: category.id,
        isIncome: category.isIncome,
        amount: amount,
        date: valid.day,
        cutNumber: valid.cutNumber,
        description: valid.description,
      ),
    );
  }
}