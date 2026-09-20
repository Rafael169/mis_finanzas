import 'package:flutter_test/flutter_test.dart';
import 'package:mis_finanzas/core/domain/cut_rule.dart';

void main() {
  group('CutRule.cutFor', () {
    test('del 1 al 15 es Corte 1', () {
      expect(CutRule.cutFor(DateTime(2026, 8, 1)), 1);
      expect(CutRule.cutFor(DateTime(2026, 8, 15)), 1);
    });

    test('del 16 al último día es Corte 2', () {
      expect(CutRule.cutFor(DateTime(2026, 8, 16)), 2);
      expect(CutRule.cutFor(DateTime(2026, 8, 30)), 2);
      expect(CutRule.cutFor(DateTime(2026, 8, 31)), 2);
      expect(CutRule.cutFor(DateTime(2026, 2, 28)), 2);
    });
  });

  group('CutRule.lastDayOfMonth', () {
    test('febrero, bisiesto y meses de 30 y 31 días', () {
      expect(CutRule.lastDayOfMonth(2026, 2), 28);
      expect(CutRule.lastDayOfMonth(2028, 2), 29);
      expect(CutRule.lastDayOfMonth(2026, 4), 30);
      expect(CutRule.lastDayOfMonth(2026, 12), 31);
    });
  });

  group('CutRule.paymentDate', () {
    test('Corte 1 se paga el 15', () {
      expect(CutRule.paymentDate(2026, 8, 1), DateTime(2026, 8, 15));
      expect(CutRule.paymentDate(2026, 2, 1), DateTime(2026, 2, 15));
    });

    test('Corte 2 se paga el 30, o el último día si el mes es más corto', () {
      expect(CutRule.paymentDate(2026, 8, 2), DateTime(2026, 8, 30));
      expect(CutRule.paymentDate(2026, 12, 2), DateTime(2026, 12, 30));
      expect(CutRule.paymentDate(2026, 4, 2), DateTime(2026, 4, 30));
      expect(CutRule.paymentDate(2026, 2, 2), DateTime(2026, 2, 28));
      expect(CutRule.paymentDate(2028, 2, 2), DateTime(2028, 2, 29));
    });
  });

  group('CutRule.rangeFor', () {
    test('Corte 1 va del 1 al 15', () {
      final range = CutRule.rangeFor(2026, 8, 1);
      expect(range.start, DateTime(2026, 8, 1));
      expect(range.end, DateTime(2026, 8, 15));
    });

    test('Corte 2 va del 16 al último día del mes', () {
      final august = CutRule.rangeFor(2026, 8, 2);
      expect(august.start, DateTime(2026, 8, 16));
      expect(august.end, DateTime(2026, 8, 31));

      final leapFebruary = CutRule.rangeFor(2028, 2, 2);
      expect(leapFebruary.start, DateTime(2028, 2, 16));
      expect(leapFebruary.end, DateTime(2028, 2, 29));
    });
  });

  test('un corte distinto de 1 o 2 lanza error', () {
    expect(() => CutRule.paymentDate(2026, 8, 3), throwsArgumentError);
    expect(() => CutRule.rangeFor(2026, 8, 0), throwsArgumentError);
  });
}