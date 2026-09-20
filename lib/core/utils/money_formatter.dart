import 'package:intl/intl.dart';

import '../domain/currency.dart';
import '../domain/money.dart';

/// Convierte un [Money] a texto según la moneda y el idioma elegidos.
String formatMoney(
  Money money, {
  required Currency currency,
  required String locale,
}) {
  final formatter = NumberFormat.currency(
    locale: locale,
    symbol: currency.symbol,
    decimalDigits: currency.displayDecimals,
  );
  return formatter.format(money.minorUnits / Money.scale);
}