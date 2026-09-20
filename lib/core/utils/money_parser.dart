import '../domain/currency.dart';
import '../domain/money.dart';

/// Interpreta lo que el usuario escribe en el campo de monto.
///
/// - Monedas sin decimales (COP, CLP): se ignoran los separadores.
/// - Monedas con decimales: el último separador (punto o coma) es decimal
///   si le siguen 1 o 2 dígitos; con 3 o más era un separador de miles.
///
/// Devuelve null si el texto está vacío, tiene caracteres no válidos o es
/// demasiado largo.
Money? parseMoneyInput(String input, Currency currency) {
  final text = input.trim();
  if (text.isEmpty) return null;
  if (!RegExp(r'^[0-9.,]+$').hasMatch(text)) return null;

  var integerPart = text;
  var fractionPart = '';

  if (currency.displayDecimals > 0) {
    final lastSeparator = _lastSeparatorIndex(text);
    if (lastSeparator != -1) {
      final tail = text.substring(lastSeparator + 1);
      if (tail.length <= currency.displayDecimals) {
        integerPart = text.substring(0, lastSeparator);
        fractionPart = tail;
      }
    }
  }

  final digits = integerPart.replaceAll(RegExp(r'[.,]'), '');
  if (digits.length > 12) return null;

  final units = digits.isEmpty ? 0 : int.parse(digits);
  final cents =
      fractionPart.isEmpty ? 0 : int.parse(fractionPart.padRight(2, '0'));
  return Money.fromMinor(units * Money.scale + cents);
}

int _lastSeparatorIndex(String text) {
  final dot = text.lastIndexOf('.');
  final comma = text.lastIndexOf(',');
  return dot > comma ? dot : comma;
}