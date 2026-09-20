import 'package:intl/intl.dart';

import '../domain/currency.dart';
import '../domain/money.dart';

/// Convierte un [Money] a texto según la moneda y el idioma elegidos.
///
/// - El símbolo va antes del número: $1.169.841.
/// - Solo se muestran decimales cuando hacen falta: 10 USD se ve US$10,
///   y 10,50 USD se ve US$10,50.
/// - Las monedas sin decimales (COP, CLP) nunca los muestran.
String formatMoney(
  Money money, {
  required Currency currency,
  required String locale,
}) {
  final hasCents = money.minorUnits % Money.scale != 0;
  final decimals =
      (currency.displayDecimals == 0 || !hasCents) ? 0 : currency.displayDecimals;

  final formatter = NumberFormat.currency(
    locale: locale,
    symbol: currency.symbol,
    decimalDigits: decimals,
    customPattern: '¤#,##0.00',
  );
  return formatter.format(money.minorUnits / Money.scale);
}