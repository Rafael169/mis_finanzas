import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/domain/money.dart';
import '../../transactions/data/drift_movement_repository.dart';
import '../../transactions/domain/movement_repository.dart';
import '../domain/backup_repository.dart';
import '../domain/csv_row.dart';

import 'package:uuid/uuid.dart';

class DriftBackupRepository implements BackupRepository {
  DriftBackupRepository(this._db) : _movements = DriftMovementRepository(_db);

  final AppDatabase _db;
  final MovementRepository _movements;

  @override
  Future<List<BackupRow>> exportAll() async {
    final t = _db.financialTransactions;
    final c = _db.categories;

    final query =
        _db.select(t).join([innerJoin(c, c.id.equalsExp(t.categoryId))])
          ..where(t.deletedAt.isNull())
          ..orderBy([OrderingTerm.asc(t.date)]);

    final rows = await query.get();
    return [
      for (final row in rows)
        BackupRow(
          date: row.readTable(t).date,
          isIncome: row.readTable(t).isIncome,
          categoryName: row.readTable(c).name,
          amount: Money.fromMinor(row.readTable(t).amount),
          cutNumber: row.readTable(t).cutNumber,
          description: row.readTable(t).description,
        ),
    ];
  }

  @override
  Future<int> importRows(List<BackupRow> rows) async {
    if (rows.isEmpty) return 0;

    final categoryRows = await _db.select(_db.categories).get();
    final categoryByName = {for (final c in categoryRows) c.name: c};

    var imported = 0;
    for (final row in rows) {
      final category = categoryByName[row.categoryName];
      // La categoría del CSV no existe en este catálogo: se omite.
      if (category == null || category.isIncome != row.isIncome) continue;

      try {
        await _movements.add(
          MovementData(
            id: const Uuid().v4(),
            categoryId: category.id,
            isIncome: row.isIncome,
            amount: row.amount,
            date: row.date,
            cutNumber: row.cutNumber,
            description: row.description,
          ),
        );
        imported++;
      } catch (_) {
        // Fila con datos inválidos para el modelo (por ejemplo, monto en
        // cero); se omite y sigue con las demás.
      }
    }
    return imported;
  }
}

/// Genera ids únicos sin depender directamente del paquete uuid en el
/// repositorio de respaldo (evita otra dependencia cruzada).