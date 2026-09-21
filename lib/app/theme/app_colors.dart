import 'package:flutter/material.dart';

/// Colores de marca: no cambian con el tema.
class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF1E6FD9);

  /// Fondo de las pantallas en el tema claro.
  static const Color background = Color(0xFFF4F7FB);
}

/// Colores con significado (ingreso, gasto, alerta). Cada tema tiene su
/// variante: en oscuro son más claros para leerse bien sobre el fondo.
@immutable
class AppSemanticColors extends ThemeExtension<AppSemanticColors> {
  const AppSemanticColors({
    required this.income,
    required this.expense,
    required this.warning,
  });

  final Color income;
  final Color expense;
  final Color warning;

  static const light = AppSemanticColors(
    income: Color(0xFF2E9E5B),
    expense: Color(0xFFD64545),
    warning: Color(0xFFF2A900),
  );

  static const dark = AppSemanticColors(
    income: Color(0xFF5FD08A),
    expense: Color(0xFFFF8A80),
    warning: Color(0xFFFFC94D),
  );

  @override
  AppSemanticColors copyWith({Color? income, Color? expense, Color? warning}) {
    return AppSemanticColors(
      income: income ?? this.income,
      expense: expense ?? this.expense,
      warning: warning ?? this.warning,
    );
  }

  @override
  AppSemanticColors lerp(ThemeExtension<AppSemanticColors>? other, double t) {
    if (other is! AppSemanticColors) return this;
    return AppSemanticColors(
      income: Color.lerp(income, other.income, t)!,
      expense: Color.lerp(expense, other.expense, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
    );
  }
}

/// Atajo: `context.appColors.income`.
extension AppColorsContext on BuildContext {
  AppSemanticColors get appColors =>
      Theme.of(this).extension<AppSemanticColors>() ?? AppSemanticColors.light;
}
