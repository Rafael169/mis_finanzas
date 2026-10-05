import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../features/categories/domain/default_categories.dart';
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
  /// - 3: grupo de categoría (columna `groupLabel`), y además: se
  ///   corrige el grupo de las categorías que ya existían y se agregan
  ///   al catálogo las categorías nuevas que todavía no estén creadas.
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
        await _fixExistingCategoryGroups();
        await _insertMissingDefaultCategories();
      }
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  /// Asigna el grupo correcto a categorías que ya existían antes de que el
  /// campo `groupLabel` existiera (llegaron con el valor por defecto
  /// 'Otras' al agregarse la columna).
  Future<void> _fixExistingCategoryGroups() async {
    const groupByName = {
      'Salario': 'Ingresos Fijos',
      'Ingresos adicionales': 'Ingresos Variables y Extras',
      'Arriendo': 'Gastos Fijos',
      'EPM': 'Gastos Fijos',
      'FNA': 'Gastos Fijos',
      'JFK': 'Gastos Fijos',
      'Internet': 'Gastos Fijos',
      'TV': 'Gastos Fijos',
      'GYM': 'Gastos Fijos',
      'Mercado': 'Gastos Variables',
      'Transporte': 'Gastos Variables',
      'Ropa': 'Gastos Variables',
      'Mecatos': 'Hormiga y Fantasma',
      'Otras D': 'Hormiga y Fantasma',
    };

    for (final entry in groupByName.entries) {
      await customStatement(
        'UPDATE categories SET group_label = ? WHERE name = ?',
        [entry.value, entry.key],
      );
    }
  }

  /// Agrega al catálogo las categorías nuevas que aún no existen (por
  /// nombre), sin tocar las que el usuario ya tiene.
  Future<void> _insertMissingDefaultCategories() async {
    final existingNames = await customSelect('SELECT name FROM categories')
        .map((row) => row.read<String>('name'))
        .get();
    final existing = existingNames.toSet();

    var nextOrder = await _nextSortOrder();
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    for (final seed in defaultCategorySeeds) {
      if (existing.contains(seed.name)) continue;

      await customStatement(
        'INSERT INTO categories '
        '(id, name, is_income, is_fixed, is_ant_expense, icon_key, color_hex, '
        'group_label, sort_order, is_archived, is_default, created_at, updated_at) '
        'VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 0, 1, ?, ?)',
        [
          const Uuid().v4(),
          seed.name,
          seed.isIncome ? 1 : 0,
          seed.isFixed ? 1 : 0,
          seed.isAntExpense ? 1 : 0,
          seed.iconKey,
          seed.colorHex,
          seed.groupLabel,
          nextOrder,
          now,
          now,
        ],
      );
      nextOrder++;
    }
  }

  Future<int> _nextSortOrder() async {
    final result = await customSelect(
      'SELECT MAX(sort_order) AS max_order FROM categories',
    ).getSingleOrNull();
    final max = result?.data['max_order'] as int?;
    return (max ?? 0) + 1;
  }
}
