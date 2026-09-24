import 'package:csv/csv.dart';

import 'backup_repository.dart';
import 'csv_row.dart';

/// Genera el texto CSV completo del respaldo.
class ExportBackup {
  ExportBackup(this._repository);

  final BackupRepository _repository;

  Future<String> call() async {
    final rows = await _repository.exportAll();
    final table = [
      BackupRow.header,
      for (final row in rows) row.toCsvFields(),
    ];
    return Csv().encode(table);
  }
}

