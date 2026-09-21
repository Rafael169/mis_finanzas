import '../../../core/domain/year_month.dart';
import 'movement_item.dart';

/// Lectura de movimientos para las pantallas.
abstract class MovementReader {
  /// Movimientos no eliminados de un mes, del más reciente al más antiguo.
  /// Emite de nuevo cada vez que cambian los datos.
  Stream<List<MovementItem>> watchMonth(YearMonth month);

  /// Un movimiento por id, o null si no existe o fue eliminado.
  Future<MovementItem?> getById(String id);
}