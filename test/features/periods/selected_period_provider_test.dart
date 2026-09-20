import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mis_finanzas/core/domain/year_month.dart';
import 'package:mis_finanzas/features/periods/presentation/selected_period_provider.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer();
  });

  tearDown(() {
    container.dispose();
  });

  test('empieza en el mes actual', () {
    expect(container.read(selectedPeriodProvider), YearMonth.now());
  });

  test('previous y next cambian el mes elegido', () {
    final notifier = container.read(selectedPeriodProvider.notifier);

    notifier.select(const YearMonth(2026, 1));
    notifier.previous();
    expect(container.read(selectedPeriodProvider), const YearMonth(2025, 12));

    notifier.next();
    expect(container.read(selectedPeriodProvider), const YearMonth(2026, 1));
  });

  test('select cambia el mes y reset vuelve al actual', () {
    final notifier = container.read(selectedPeriodProvider.notifier);

    notifier.select(const YearMonth(2024, 3));
    expect(container.read(selectedPeriodProvider), const YearMonth(2024, 3));

    notifier.reset();
    expect(container.read(selectedPeriodProvider), YearMonth.now());
  });
}