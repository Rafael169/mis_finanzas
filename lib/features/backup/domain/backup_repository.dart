import 'csv_row.dart';

abstract class BackupRepository {
  /// Todos los movimientos no eliminados, ordenados por fecha.
  Future<List<BackupRow>> exportAll();

  /// Importa las filas ya válidas. Devuelve cuántos movimientos se
  /// crearon. Las categorías deben existir por nombre; las filas cuya
  /// categoría no se encuentra se omiten (el llamador las cuenta antes).
  Future<int> importRows(List<BackupRow> rows);
}
