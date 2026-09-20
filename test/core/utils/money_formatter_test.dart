import 'package:flutter_test/flutter_test.dart';
import 'package:mis_finanzas/core/domain/currency.dart';
import 'package:mis_finanzas/core/domain/money.dart';
import 'package:mis_finanzas/core/utils/money_formatter.dart';

void main() {
  // Quita espacios (incluido el espacio de no separación) para que la
  // prueba no dependa de cómo intl separa el símbolo del número.
  String clean(String text) => text.replaceAll(RegExp(r'\s'), '');

  test('COP en es_CO: separador de miles y sin decimales', () {
    final text = clean(
      formatMoney(
        const Money.fromUnits(1169841),
        currency: Currency.cop,
        locale: 'es_CO',
      ),
    );
    expect(text, contains('1.169.841'));
    expect(text, contains(r'$'));
    expect(text, isNot(contains(',')));
  });

  test('USD en es_CO: dos decimales con coma', () {
    final text = clean(
      formatMoney(
        const Money.fromMinor(123456),
        currency: Currency.usd,
        locale: 'es_CO',
      ),
    );
    expect(text, contains('1.234,56'));
    expect(text, contains('US'));
  });

  test('el mismo monto guardado se ve distinto según la moneda', () {
    const stored = Money.fromMinor(5000000);
    final cop = clean(
      formatMoney(stored, currency: Currency.cop, locale: 'es_CO'),
    );
    final usd = clean(
      formatMoney(stored, currency: Currency.usd, locale: 'es_CO'),
    );
    expect(cop, contains('50.000'));
    expect(usd, contains('50.000,00'));
  });
}
