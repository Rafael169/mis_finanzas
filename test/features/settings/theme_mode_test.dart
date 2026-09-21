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

  test('migrar de la versión 1 a la 2 conserva los ajustes y agrega el tema',
      () async {
    final db = AppDatabase.forTesting(
      NativeDatabase.memory(
        setup: (rawDb) {
          // Esquema de la versión 1: sin la columna del tema.
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
          rawDb.execute(
            "INSERT INTO app_settings "
            "(id, currency_code, onboarding_completed, created_at, updated_at) "
            "VALUES ('settings', 'USD', 1, 1700000000, 1700000000)",
          );
          rawDb.execute('PRAGMA user_version = 1');
        },
      ),
    );
    addTearDown(db.close);

    final row = await db.select(db.appSettings).getSingle();

    expect(row.currencyCode, 'USD');
    expect(row.onboardingCompleted, isTrue);
    expect(row.themeMode, 'system');
  });
}