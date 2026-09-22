import 'package:flutter_test/flutter_test.dart';
import 'package:mis_finanzas/core/domain/money.dart';
import 'package:mis_finanzas/features/budgets/domain/budget_alert.dart';

void main() {
  const limit = Money.fromUnits(100000);

  test('por debajo del umbral no hay alerta', () {
    expect(
      alertLevelFor(
        actual: const Money.fromUnits(79999),
        limit: limit,
        alertPercent: 80,
      ),
      AlertLevel.none,
    );
  });

  test('al llegar al umbral es advertencia', () {
    expect(
      alertLevelFor(
        actual: const Money.fromUnits(80000),
        limit: limit,
        alertPercent: 80,
      ),
      AlertLevel.warning,
    );
  });

  test('por encima del límite está superado', () {
    expect(
      alertLevelFor(
        actual: const Money.fromUnits(100001),
        limit: limit,
        alertPercent: 80,
      ),
      AlertLevel.over,
    );
  });

  test('sin límite no hay alerta', () {
    expect(
      alertLevelFor(actual: const Money.fromUnits(5), limit: Money.zero, alertPercent: 80),
      AlertLevel.none,
    );
  });
}