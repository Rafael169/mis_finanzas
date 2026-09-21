import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../domain/app_theme_mode.dart';
import '../domain/settings_repository.dart';
import '../domain/user_settings.dart';

class DriftSettingsRepository implements SettingsRepository {
  DriftSettingsRepository(this._db);

  final AppDatabase _db;

  /// Los ajustes son una sola fila con un id fijo.
  static const _rowId = 'settings';

  @override
  Stream<UserSettings> watch() {
    return _db.select(_db.appSettings).watchSingleOrNull().map(_toEntity);
  }

  @override
  Future<UserSettings> get() async {
    final row = await _db.select(_db.appSettings).getSingleOrNull();
    return _toEntity(row);
  }

  @override
  Future<void> save(UserSettings settings) async {
    final now = DateTime.now();
    final existing = await _db.select(_db.appSettings).getSingleOrNull();

    await _db.into(_db.appSettings).insertOnConflictUpdate(
          AppSettingsCompanion(
            id: const Value(_rowId),
            currencyCode: Value(settings.currencyCode),
            locale: Value(settings.locale),
            defaultAlertPercent: Value(settings.defaultAlertPercent),
            notificationsEnabled: Value(settings.notificationsEnabled),
            onboardingCompleted: Value(settings.onboardingCompleted),
            themeMode: Value(settings.themeMode.name),
            createdAt: Value(existing?.createdAt ?? now),
            updatedAt: Value(now),
          ),
        );
  }

  UserSettings _toEntity(AppSettingsData? row) {
    if (row == null) return UserSettings.defaults;
    return UserSettings(
      currencyCode: row.currencyCode,
      locale: row.locale,
      defaultAlertPercent: row.defaultAlertPercent,
      notificationsEnabled: row.notificationsEnabled,
      onboardingCompleted: row.onboardingCompleted,
      themeMode: AppThemeMode.fromName(row.themeMode),
    );
  }
}