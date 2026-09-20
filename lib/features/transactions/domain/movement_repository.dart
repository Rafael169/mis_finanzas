import '../../../core/domain/money.dart';
import 'movement_impact.dart';

/// Datos de un movimiento nuevo, ya validados.
class NewMovement {
  const NewMovement({
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
  /// Guarda el movimiento y actualiza los totales del mes, todo o nada:
  /// si algo falla, no se guarda nada.
  Future<void> add(NewMovement movement, MovementImpact impact);
}