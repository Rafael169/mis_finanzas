import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light => _build(
        brightness: Brightness.light,
        colors: AppSemanticColors.light,
        background: AppColors.background,
      );

  static ThemeData get dark => _build(
        brightness: Brightness.dark,
        colors: AppSemanticColors.dark,
      );

  static ThemeData _build({
    required Brightness brightness,
    required AppSemanticColors colors,
    Color? background,
  }) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: brightness,
      ),
      scaffoldBackgroundColor: background,
      extensions: [colors],
    );
  }
}