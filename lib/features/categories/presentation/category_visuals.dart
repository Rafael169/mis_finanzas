import 'package:flutter/material.dart';

const Map<String, IconData> _icons = {
  'work': Icons.work_outline,
  'add_card': Icons.add_card,
  'home': Icons.home_outlined,
  'bolt': Icons.bolt,
  'account_balance': Icons.account_balance,
  'payments': Icons.payments_outlined,
  'wifi': Icons.wifi,
  'tv': Icons.tv,
  'fitness_center': Icons.fitness_center,
  'shopping_cart': Icons.shopping_cart_outlined,
  'directions_bus': Icons.directions_bus_outlined,
  'checkroom': Icons.checkroom,
  'fastfood': Icons.fastfood_outlined,
  'more_horiz': Icons.more_horiz,
};

/// Icono de una categoría a partir de su clave guardada.
IconData categoryIcon(String key) => _icons[key] ?? Icons.category_outlined;

/// Color de una categoría a partir de su código guardado (por ejemplo #1E6FD9).
Color categoryColor(String hex) {
  final cleaned = hex.replaceAll('#', '');
  final value = int.tryParse(cleaned, radix: 16);
  if (value == null || cleaned.length != 6) return const Color(0xFF1E6FD9);
  return Color(0xFF000000 | value);
}