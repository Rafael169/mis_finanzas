import 'user_settings.dart';

abstract class SettingsRepository {
  /// Emite los ajustes actuales y cada cambio posterior.
  /// Si todavía no hay nada guardado, emite los valores por defecto.
  Stream<UserSettings> watch();

  /// Lectura única de los ajustes actuales.
  Future<UserSettings> get();

  /// Guarda los ajustes (crea la fila la primera vez).
  Future<void> save(UserSettings settings);
}