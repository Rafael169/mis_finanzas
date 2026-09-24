import 'package:flutter/material.dart';

import 'category_icons.dart';

/// Icono de una categoría a partir de su clave guardada.
IconData categoryIcon(String key) =>
    selectableCategoryIcons[key] ?? Icons.category_outlined;

/// Color de una categoría a partir de su código guardado (por ejemplo #1E6FD9).
Color categoryColor(String hex) {
  final cleaned = hex.replaceAll('#', '');
  final value = int.tryParse(cleaned, radix: 16);
  if (value == null || cleaned.length != 6) return const Color(0xFF1E6FD9);
  return Color(0xFF000000 | value);
}
