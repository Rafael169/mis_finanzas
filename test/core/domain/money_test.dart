import 'package:flutter_test/flutter_test.dart';
import 'package:mis_finanzas/core/domain/money.dart';

void main() {
  group('Money', () {
    test('fromUnits guarda en "centavos"', () {
      expect(const Money.fromUnits(50000).minorUnits, 5000000);
    });

    test('suma y resta sin errores de punto flotante', () {
      // Con double, 0.1 + 0.2 no da exactamente 0.3. Con enteros sí.
      expect(
        const Money.fromMinor(10) + const Money.fromMinor(20),
        const Money.fromMinor(30),
      );
      expect(
        const Money.fromUnits(2025041) - const Money.fromUnits(855200),
        const Money.fromUnits(1169841),
      );
    });

    test('negación y estados', () {
      final debt = -const Money.fromUnits(100);
      expect(debt.isNegative, isTrue);
      expect(Money.zero.isZero, isTrue);
      expect(const Money.fromUnits(1).isNegative, isFalse);
    });

    test('comparación e igualdad', () {
      expect(const Money.fromUnits(5) < const Money.fromUnits(6), isTrue);
      expect(const Money.fromUnits(6) >= const Money.fromUnits(6), isTrue);
      expect(const Money.fromUnits(5), const Money.fromUnits(5));
      expect(
        const Money.fromUnits(5).hashCode,
        const Money.fromUnits(5).hashCode,
      );
    });

    test('sum de una lista, y de una lista vacía', () {
      expect(
        Money.sum(const [Money.fromUnits(1), Money.fromUnits(2)]),
        const Money.fromUnits(3),
      );
      expect(Money.sum(const []), Money.zero);
    });

    test('ratioTo calcula la ejecución y protege la división por cero', () {
      const limit = Money.fromUnits(55000);
      expect(const Money.fromUnits(50000).ratioTo(limit), closeTo(0.909, 0.001));
      expect(const Money.fromUnits(60000).ratioTo(limit)! > 1, isTrue);
      expect(const Money.fromUnits(50000).ratioTo(Money.zero), isNull);
    });
  });
}