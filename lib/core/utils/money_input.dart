import '../domain/currency.dart';
import '../domain/money.dart';

/// Texto con el que se llena el campo de monto al editar un movimiento.
/// Sin símbolo ni separador de miles, y con coma decimal cuando hay
/// centavos: 50000, 10 o 10,50. Es lo que `parseMoneyInput` interpreta.
String formatMoneyForInput(Money money, Currency currency) {
  final units = money.minorUnits ~/ Money.scale;
  final cents = money.minorUnits % Money.scale;

  if (currency.displayDecimals == 0 || cents == 0) return units.toString();
  return '$units,${cents.toString().padLeft(2, '0')}';
}