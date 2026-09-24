import 'package:csv/csv.dart';

import 'backup_repository.dart';
import 'csv_row.dart';

class ImportResult {
  const ImportResult({required this.imported, required this.skipped});

  final int imported;
  final int skipped;
}

class BackupFormatException implements Exception {
  const BackupFormatException();

  @override
  String toString() => 'El archivo no tiene el formato de respaldo esperado.';
}

class ImportBackup {
  ImportBackup(this._repository);

  final BackupRepository _repository;

  Future<ImportResult> call(String csvContent) async {
    final table = Csv().decode(csvContent);
    if (table.isEmpty) return const ImportResult(imported: 0, skipped: 0);

    final header = table.first.map((e) => e.toString().trim()).toList();
    if (header.length < 5 || header[0] != 'fecha' || header[1] != 'tipo') {
      throw const BackupFormatException();
    }

    final rows = <BackupRow>[];
    var skipped = 0;
    for (final line in table.skip(1)) {
      if (line.isEmpty || (line.length == 1 && line.first.toString().isEmpty)) {
        continue;
      }
      final row = BackupRow.fromCsvFields(line);
      if (row == null) {
        skipped++;
      } else {
        rows.add(row);
      }
    }

    final imported = await _repository.importRows(rows);
    skipped += rows.length - imported;

    return ImportResult(imported: imported, skipped: skipped);
  }
}
