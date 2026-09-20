import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_database.dart';

/// Base de datos única de la app. Se cierra sola al destruirse el contenedor.
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase.open();
  ref.onDispose(db.close);
  return db;
});