import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    AppSettings,
    FinancialPeriods,
    Categories,
    FinancialTransactions,
    BudgetItems,
    CategoryPeriodTotals,
  ],
)
class AppDatabase extends _$AppDatabase {
  /// Base de datos real, guardada en el dispositivo.
  AppDatabase.open() : super(driftDatabase(name: 'mis_finanzas'));

  /// Para pruebas: recibe un ejecutor (por ejemplo, una base en memoria).
  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    beforeOpen: (details) async {
      // SQLite no hace cumplir las claves foráneas si no se activan.
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}
