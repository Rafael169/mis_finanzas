import 'package:flutter_test/flutter_test.dart';
import 'package:mis_finanzas/core/domain/currency.dart';
import 'package:mis_finanzas/core/domain/money.dart';
import 'package:mis_finanzas/core/utils/money_formatter.dart';

void main() {
  // Quita espacios (incluido el espacio de no separación) para que la
  // prueba no dependa de cómo intl separa el símbolo del número.
  String clean(String text) => text.replaceAll(RegExp(r'\s'), '');

  String format(Money money, Currency currency) =>
      clean(formatMoney(money, currency: currency, locale: 'es_CO'));

  test('COP: 1200 pesos se ve exactamente así', () {
    expect(format(const Money.fromUnits(1200), Currency.cop), r'$1.200');
  });

  test('COP: monto grande con puntos de miles y sin decimales', () {
    expect(format(const Money.fromUnits(1169841), Currency.cop), r'$1.169.841');
  });

  test('USD entero: 10 dólares sin decimales', () {
    expect(format(const Money.fromUnits(10), Currency.usd), r'US$10');
  });

  test('USD con centavos: muestra dos decimales', () {
    expect(format(const Money.fromMinor(1050), Currency.usd), r'US$10,50');
    expect(format(const Money.fromMinor(123456), Currency.usd), r'US$1.234,56');
  });

  test('ARS entero: sin decimales', () {
    expect(
      format(const Money.fromUnits(1169841), Currency.ars),
      r'AR$1.169.841',
    );
  });

  test('un monto negativo lleva el signo menos', () {
    final text = format(-const Money.fromUnits(1500), Currency.cop);
    expect(text, contains('-'));
    expect(text, contains('1.500'));
  });
}