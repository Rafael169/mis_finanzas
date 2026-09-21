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

  /// Versión del esquema. Sube en 1 cada vez que cambian las tablas y
  /// siempre con su migración en [migration].
  ///
  /// - 1: versión inicial.
  /// - 2: tema de la app (columna `themeMode` en los ajustes).
  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (migrator, from, to) async {
          if (from < 2) {
            await migrator.addColumn(appSettings, appSettings.themeMode);
          }
        },
        beforeOpen: (details) async {
          // SQLite no hace cumplir las claves foráneas si no se activan.
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );
}