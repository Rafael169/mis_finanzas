import 'package:uuid/uuid.dart';

import '../../../core/domain/cut_rule.dart';
import '../../../core/domain/money.dart';
import '../../categories/domain/finance_category.dart';
import 'movement_repository.dart';

/// Error de validación con un mensaje que se puede mostrar al usuario.
class MovementException implements Exception {
  const MovementException(this.message);

  final String message;

  @override
  String toString() => message;
}

/// Resultado de validar los datos de un movimiento.
class ValidatedMovement {
  const ValidatedMovement({
    required this.day,
    required this.cutNumber,
    required this.description,
  });

  final DateTime day;
  final int cutNumber;
  final String description;
}

/// Reglas comunes para crear y para editar un movimiento.
ValidatedMovement validateMovement({
  required FinanceCategory category,
  required Money amount,
  required DateTime date,
  required String description,
}) {
  if (amount <= Money.zero) {
    throw const MovementException('El monto debe ser mayor a cero.');
  }
  if (category.isArchived) {
    throw const MovementException('Esa categoría está archivada.');
  }

  // Solo importa el día: se descarta la hora.
  final day = DateTime(date.year, date.month, date.day);

  var text = description.trim();
  if (text.length > RegisterMovement.maxDescriptionLength) {
    text = text.substring(0, RegisterMovement.maxDescriptionLength);
  }

  return ValidatedMovement(
    day: day,
    cutNumber: CutRule.cutFor(day),
    description: text,
  );
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
    final valid = validateMovement(
      category: category,
      amount: amount,
      date: date,
      description: description,
    );

    await _repository.add(
      MovementData(
        id: _uuid.v4(),
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