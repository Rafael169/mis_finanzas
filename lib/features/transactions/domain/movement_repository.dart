import '../../../core/domain/money.dart';

/// Datos de un movimiento, ya validados. Sirve para crear y para editar.
class MovementData {
  const MovementData({
    required this.id,
    required this.categoryId,
    required this.isIncome,
    required this.amount,
    required this.date,
    required this.cutNumber,
    this.description = '',
  });

  final String id;
  final String categoryId;
  final bool isIncome;
  final Money amount;

  /// Solo la fecha (a las 00:00).
  final DateTime date;

  /// 1 = primera quincena, 2 = segunda.
  final int cutNumber;
  final String description;
}

abstract class MovementRepository {
  /// Guarda el movimiento y recalcula los totales del mes, todo o nada.
  Future<void> add(MovementData movement);

  /// Reemplaza los datos del movimiento con ese id. Puede cambiarlo de mes.
  Future<void> update(MovementData movement);

  /// Borrado lógico: el movimiento queda marcado como eliminado.
  Future<void> softDelete(String id);

  /// Deshace un borrado lógico.
  Future<void> restore(String id);
}
