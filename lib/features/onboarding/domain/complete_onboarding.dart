import '../../../core/domain/currency.dart';
import '../../categories/domain/seed_default_categories.dart';
import '../../settings/domain/settings_repository.dart';

/// Termina la bienvenida: crea las categorías por defecto y guarda la
/// moneda elegida. Se pueden repetir los pasos sin duplicar datos: si
/// algo falla a la mitad, al reintentar las categorías no se vuelven a crear.
class CompleteOnboarding {
  CompleteOnboarding(this._settings, this._seedCategories);

  final SettingsRepository _settings;
  final SeedDefaultCategories _seedCategories;

  Future<void> call(Currency currency) async {
    // Primero las categorías y al final la marca de "bienvenida completa",
    // para que un fallo no deje la app sin categorías.
    await _seedCategories();

    final current = await _settings.get();
    await _settings.save(
      current.copyWith(
        currencyCode: currency.code,
        onboardingCompleted: true,
      ),
    );
  }
}