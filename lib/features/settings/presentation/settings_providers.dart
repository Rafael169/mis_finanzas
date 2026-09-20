import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_provider.dart';
import '../../../core/domain/currency.dart';
import '../../../core/domain/money.dart';
import '../../../core/utils/money_formatter.dart';
import '../data/drift_settings_repository.dart';
import '../domain/settings_repository.dart';
import '../domain/user_settings.dart';

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return DriftSettingsRepository(ref.watch(appDatabaseProvider));
});

/// Ajustes actuales; se actualiza solo cuando cambian en la base de datos.
final userSettingsProvider = StreamProvider<UserSettings>((ref) {
  return ref.watch(settingsRepositoryProvider).watch();
});

/// Moneda elegida. Mientras los ajustes cargan, usa los valores por defecto.
final currencyProvider = Provider<Currency>((ref) {
  final settings =
      ref.watch(userSettingsProvider).value ?? UserSettings.defaults;
  return settings.currency;
});

/// Formateador de dinero listo para usar en cualquier pantalla:
/// `ref.watch(moneyFormatterProvider)(money)`. Al cambiar la moneda, todas
/// las pantallas que lo usan se actualizan.
final moneyFormatterProvider = Provider<String Function(Money)>((ref) {
  final settings =
      ref.watch(userSettingsProvider).value ?? UserSettings.defaults;
  return (money) => formatMoney(
        money,
        currency: settings.currency,
        locale: settings.locale,
      );
});