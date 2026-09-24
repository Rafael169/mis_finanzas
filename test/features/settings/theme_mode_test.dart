import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mis_finanzas/core/database/app_database.dart';
import 'package:mis_finanzas/features/settings/data/drift_settings_repository.dart';
import 'package:mis_finanzas/features/settings/domain/app_theme_mode.dart';
import 'package:mis_finanzas/features/settings/domain/user_settings.dart';

void main() {
  test('fromName reconoce los tres modos y usa Sistema si no reconoce', () {
    expect(AppThemeMode.fromName('system'), AppThemeMode.system);
    expect(AppThemeMode.fromName('light'), AppThemeMode.light);
    expect(AppThemeMode.fromName('dark'), AppThemeMode.dark);
    expect(AppThemeMode.fromName('otro'), AppThemeMode.system);
    expect(AppThemeMode.fromName(null), AppThemeMode.system);
  });

  test('el modo por defecto es Sistema', () {
    expect(UserSettings.defaults.themeMode, AppThemeMode.system);
  });

  test('guarda y lee el modo de tema', () async {
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(db.close);
    final repository = DriftSettingsRepository(db);

    await repository.save(
      UserSettings.defaults.copyWith(themeMode: AppThemeMode.dark),
    );

    expect((await repository.get()).themeMode, AppThemeMode.dark);
  });

  test('migrar de la versión 1 a la 3 conserva los ajustes, agrega el tema y el grupo', () async {
    final db = AppDatabase.forTesting(
      NativeDatabase.memory(
        setup: (rawDb) {
          // Esquema de la versión 1: sin la columna del tema ni la de grupo.
          rawDb.execute('''
            CREATE TABLE app_settings (
              id TEXT NOT NULL,
              display_name TEXT NULL,
              currency_code TEXT NOT NULL DEFAULT 'COP',
              locale TEXT NOT NULL DEFAULT 'es_CO',
              default_alert_percent INTEGER NOT NULL DEFAULT 80,
              notifications_enabled INTEGER NOT NULL DEFAULT 0,
              onboarding_completed INTEGER NOT NULL DEFAULT 0,
              created_at INTEGER NOT NULL,
              updated_at INTEGER NOT NULL,
              PRIMARY KEY (id)
            )
          ''');
          rawDb.execute('''
            CREATE TABLE categories (
              id TEXT NOT NULL,
              name TEXT NOT NULL,
              is_income INTEGER NOT NULL,
              is_fixed INTEGER NOT NULL DEFAULT 0,
              is_ant_expense INTEGER NOT NULL DEFAULT 0,
              icon_key TEXT NOT NULL DEFAULT 'category',
              color_hex TEXT NOT NULL DEFAULT '#1E6FD9',
              sort_order INTEGER NOT NULL DEFAULT 0,
              is_archived INTEGER NOT NULL DEFAULT 0,
              is_default INTEGER NOT NULL DEFAULT 0,
              created_at INTEGER NOT NULL,
              updated_at INTEGER NOT NULL,
              PRIMARY KEY (id)
            )
          ''');
          rawDb.execute(
            "INSERT INTO app_settings "
            "(id, currency_code, onboarding_completed, created_at, updated_at) "
            "VALUES ('settings', 'USD', 1, 1700000000, 1700000000)",
          );
          rawDb.execute(
            "INSERT INTO categories "
            "(id, name, is_income, created_at, updated_at) "
            "VALUES ('cat1', 'Arriendo', 0, 1700000000, 1700000000)",
          );
          rawDb.execute('PRAGMA user_version = 1');
        },
      ),
    );
    addTearDown(db.close);

    final settingsRow = await db.select(db.appSettings).getSingle();
    expect(settingsRow.currencyCode, 'USD');
    expect(settingsRow.onboardingCompleted, isTrue);
    expect(settingsRow.themeMode, 'system');

    final categoryRow = await db.select(db.categories).getSingle();
    expect(categoryRow.name, 'Arriendo');
    expect(categoryRow.groupLabel, 'Otras');
  });
}
