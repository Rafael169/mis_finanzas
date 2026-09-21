import 'package:flutter_test/flutter_test.dart';
import 'package:mis_finanzas/core/domain/currency.dart';
import 'package:mis_finanzas/core/domain/money.dart';
import 'package:mis_finanzas/core/utils/money_input.dart';
import 'package:mis_finanzas/core/utils/money_parser.dart';

void main() {
  test('COP: solo los pesos, sin separadores', () {
    expect(
      formatMoneyForInput(const Money.fromUnits(50000), Currency.cop),
      '50000',
    );
  });

  test('USD entero: sin decimales', () {
    expect(formatMoneyForInput(const Money.fromUnits(10), Currency.usd), '10');
  });

  test('USD con centavos: dos decimales con coma', () {
    expect(
      formatMoneyForInput(const Money.fromMinor(1050), Currency.usd),
      '10,50',
    );
  });

  test('USD: centavos menores a 10 llevan un cero a la izquierda', () {
    expect(
      formatMoneyForInput(const Money.fromMinor(5), Currency.usd),
      '0,05',
    );
  });

  test('lo que se pone en el campo se vuelve a interpretar igual', () {
    for (final money in const [
      Money.fromUnits(1200),
      Money.fromMinor(1050),
      Money.fromMinor(5),
      Money.fromMinor(123456),
    ]) {
      final text = formatMoneyForInput(money, Currency.usd);
      expect(parseMoneyInput(text, Currency.usd), money);
    }

    const pesos = Money.fromUnits(1169841);
    final pesosText = formatMoneyForInput(pesos, Currency.cop);
    expect(parseMoneyInput(pesosText, Currency.cop), pesos);
  });
}