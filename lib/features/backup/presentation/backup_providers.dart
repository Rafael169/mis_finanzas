import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_provider.dart';
import '../data/drift_backup_repository.dart';
import '../domain/backup_repository.dart';
import '../domain/export_backup.dart';
import '../domain/import_backup.dart';

final backupRepositoryProvider = Provider<BackupRepository>((ref) {
  return DriftBackupRepository(ref.watch(appDatabaseProvider));
});

final exportBackupProvider = Provider<ExportBackup>((ref) {
  return ExportBackup(ref.watch(backupRepositoryProvider));
});

final importBackupProvider = Provider<ImportBackup>((ref) {
  return ImportBackup(ref.watch(backupRepositoryProvider));
});