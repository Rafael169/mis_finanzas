import 'package:flutter_test/flutter_test.dart';
import 'package:mis_finanzas/core/domain/currency.dart';
import 'package:mis_finanzas/core/domain/money.dart';
import 'package:mis_finanzas/core/utils/money_parser.dart';

void main() {
  test('COP: solo dígitos, con o sin puntos de miles', () {
    expect(parseMoneyInput('1200', Currency.cop), const Money.fromUnits(1200));
    expect(parseMoneyInput('1.200', Currency.cop), const Money.fromUnits(1200));
    expect(
      parseMoneyInput('1.169.841', Currency.cop),
      const Money.fromUnits(1169841),
    );
  });

  test('texto vacío o con caracteres no válidos devuelve null', () {
    expect(parseMoneyInput('', Currency.cop), isNull);
    expect(parseMoneyInput('   ', Currency.cop), isNull);
    expect(parseMoneyInput('abc', Currency.cop), isNull);
    expect(parseMoneyInput('-5', Currency.usd), isNull);
  });

  test('USD: monto entero', () {
    expect(parseMoneyInput('10', Currency.usd), const Money.fromUnits(10));
  });

  test('USD: decimales con coma o con punto', () {
    expect(parseMoneyInput('10,5', Currency.usd), const Money.fromMinor(1050));
    expect(parseMoneyInput('10.50', Currency.usd), const Money.fromMinor(1050));
    expect(parseMoneyInput('0,05', Currency.usd), const Money.fromMinor(5));
    expect(parseMoneyInput('10,', Currency.usd), const Money.fromUnits(10));
  });

  test('USD: separador de miles con y sin decimales', () {
    expect(parseMoneyInput('1.234', Currency.usd), const Money.fromUnits(1234));
    expect(
      parseMoneyInput('1.234,56', Currency.usd),
      const Money.fromMinor(123456),
    );
    expect(
      parseMoneyInput('1,234.56', Currency.usd),
      const Money.fromMinor(123456),
    );
  });

  test('un número demasiado largo devuelve null', () {
    expect(parseMoneyInput('1234567890123', Currency.cop), isNull);
  });
}