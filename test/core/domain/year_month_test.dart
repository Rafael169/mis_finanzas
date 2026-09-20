import 'package:flutter_test/flutter_test.dart';
import 'package:mis_finanzas/core/domain/year_month.dart';

void main() {
  test('previous cruza de enero al diciembre del año anterior', () {
    expect(const YearMonth(2026, 1).previous, const YearMonth(2025, 12));
    expect(const YearMonth(2026, 8).previous, const YearMonth(2026, 7));
  });

  test('next cruza de diciembre al enero del año siguiente', () {
    expect(const YearMonth(2026, 12).next, const YearMonth(2027, 1));
    expect(const YearMonth(2026, 8).next, const YearMonth(2026, 9));
  });

  test('primer y último día del mes', () {
    expect(const YearMonth(2026, 8).firstDay, DateTime(2026, 8, 1));
    expect(const YearMonth(2026, 8).lastDay, DateTime(2026, 8, 31));
    expect(const YearMonth(2026, 2).lastDay, DateTime(2026, 2, 28));
    expect(const YearMonth(2028, 2).lastDay, DateTime(2028, 2, 29));
  });

  test('igualdad y orden', () {
    expect(const YearMonth(2026, 8), const YearMonth(2026, 8));
    expect(
      const YearMonth(2026, 8).hashCode,
      const YearMonth(2026, 8).hashCode,
    );
    expect(
      const YearMonth(2025, 12).compareTo(const YearMonth(2026, 1)),
      lessThan(0),
    );
  });

  test('fromDate toma el año y el mes', () {
    expect(YearMonth.fromDate(DateTime(2026, 9, 19)), const YearMonth(2026, 9));
  });
}