import 'package:uuid/uuid.dart';

import '../../../core/domain/cut_rule.dart';
import '../../../core/domain/money.dart';
import '../../categories/domain/finance_category.dart';
import 'movement_impact.dart';
import 'movement_repository.dart';

/// Error de validación con un mensaje que se puede mostrar al usuario.
class MovementException implements Exception {
  const MovementException(this.message);

  final String message;

  @override
  String toString() => message;
}

/// Registra un ingreso o un gasto.
class RegisterMovement {
  RegisterMovement(this._repository, {Uuid? uuid})
      : _uuid = uuid ?? const Uuid();

  static const int maxDescriptionLength = 120;

  final MovementRepository _repository;
  final Uuid _uuid;

  Future<void> call({
    required FinanceCategory category,
    required Money amount,
    required DateTime date,
    String description = '',
  }) async {
    if (amount <= Money.zero) {
      throw const MovementException('El monto debe ser mayor a cero.');
    }
    if (category.isArchived) {
      throw const MovementException('Esa categoría está archivada.');
    }

    // Solo importa el día: se descarta la hora.
    final day = DateTime(date.year, date.month, date.day);

    var text = description.trim();
    if (text.length > maxDescriptionLength) {
      text = text.substring(0, maxDescriptionLength);
    }

    final movement = NewMovement(
      id: _uuid.v4(),
      categoryId: category.id,
      isIncome: category.isIncome,
      amount: amount,
      date: day,
      cutNumber: CutRule.cutFor(day),
      description: text,
    );

    await _repository.add(
      movement,
      MovementImpact.of(category: category, amount: amount),
    );
  }
}