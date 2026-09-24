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
  AppDatabase.open() : super(driftDatabase(name: 'mis_finanzas'));
  AppDatabase.forTesting(super.e);

  /// - 1: versión inicial.
  /// - 2: tema de la app (columna `themeMode` en los ajustes).
  /// - 3: grupo de categoría (columna `groupLabel`).
  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (migrator, from, to) async {
          if (from < 2) {
            await migrator.addColumn(appSettings, appSettings.themeMode);
          }
          if (from < 3) {
            await migrator.addColumn(categories, categories.groupLabel);
          }
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );
}