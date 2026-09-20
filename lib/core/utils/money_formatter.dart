import 'package:intl/intl.dart';

import '../domain/currency.dart';

/// Los montos se guardan siempre como entero con 2 decimales implícitos
/// ("centavos"), sin importar la moneda. Así cambiar de moneda nunca
/// reinterpreta los datos guardados.
const int kStorageScale = 100;

/// Convierte un monto guardado en "centavos" a texto para mostrar.
String formatMinorUnits(
  int minorUnits, {
  required Currency currency,
  required String locale,
}) {
  final formatter = NumberFormat.currency(
    locale: locale,
    symbol: currency.symbol,
    decimalDigits: currency.displayDecimals,
  );
  return formatter.format(minorUnits / kStorageScale);
}