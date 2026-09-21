/// Modo de tema elegido por el usuario.
enum AppThemeMode {
  /// Sigue el modo claro u oscuro del teléfono (valor por defecto).
  system('Sistema'),
  light('Claro'),
  dark('Oscuro');

  const AppThemeMode(this.label);

  final String label;

  /// Interpreta el texto guardado; si no lo reconoce, usa [system].
  static AppThemeMode fromName(String? value) {
    return AppThemeMode.values.where((m) => m.name == value).firstOrNull ??
        AppThemeMode.system;
  }
}