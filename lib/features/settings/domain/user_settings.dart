import '../../../core/domain/currency.dart';
import 'app_theme_mode.dart';

/// Ajustes del usuario. Una sola moneda para toda la app.
class UserSettings {
  const UserSettings({
    required this.currencyCode,
    required this.locale,
    required this.defaultAlertPercent,
    required this.notificationsEnabled,
    required this.onboardingCompleted,
    required this.themeMode,
  });

  /// Valores que se usan mientras no haya nada guardado.
  static const defaults = UserSettings(
    currencyCode: 'COP',
    locale: 'es_CO',
    defaultAlertPercent: 80,
    notificationsEnabled: false,
    onboardingCompleted: false,
    themeMode: AppThemeMode.system,
  );

  final String currencyCode;
  final String locale;
  final int defaultAlertPercent;
  final bool notificationsEnabled;
  final bool onboardingCompleted;
  final AppThemeMode themeMode;

  Currency get currency => Currency.fromCode(currencyCode);

  UserSettings copyWith({
    String? currencyCode,
    String? locale,
    int? defaultAlertPercent,
    bool? notificationsEnabled,
    bool? onboardingCompleted,
    AppThemeMode? themeMode,
  }) {
    return UserSettings(
      currencyCode: currencyCode ?? this.currencyCode,
      locale: locale ?? this.locale,
      defaultAlertPercent: defaultAlertPercent ?? this.defaultAlertPercent,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      themeMode: themeMode ?? this.themeMode,
    );
  }
}