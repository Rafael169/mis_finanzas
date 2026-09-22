import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mis_finanzas/core/database/app_database.dart';
import 'package:mis_finanzas/core/domain/money.dart';
import 'package:mis_finanzas/features/analytics/data/drift_analytics_repository.dart';
import 'package:mis_finanzas/features/categories/data/drift_category_repository.dart';
import 'package:mis_finanzas/features/categories/domain/finance_category.dart';
import 'package:mis_finanzas/features/categories/domain/seed_default_categories.dart';
import 'package:mis_finanzas/features/transactions/data/drift_movement_repository.dart';
import 'package:mis_finanzas/features/transactions/domain/register_movement.dart';

void main() {
  late AppDatabase db;
  late DriftAnalyticsRepository analytics;
  late RegisterMovement register;
  late Map<String, FinanceCategory> byName;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());

    final categoryRepository = DriftCategoryRepository(db);
    await SeedDefaultCategories(categoryRepository)();
    final all = await categoryRepository.watchActive().first;
    byName = {for (final c in all) c.name: c};

    register = RegisterMovement(DriftMovementRepository(db));
    analytics = DriftAnalyticsRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('un año sin datos devuelve todo en cero', () async {
    final summary = await analytics.watchYear(2026).first;

    expect(summary.totalIncome, Money.zero);
    expect(summary.totalExpense, Money.zero);
    expect(summary.monthlyBalances.every((m) => m.isZero), isTrue);
  });

  test('suma los meses del año y ubica el balance en su mes', () async {
    await register(
      category: byName['Salario']!,
      amount: const Money.fromUnits(2000000),
      date: DateTime(2026, 3, 15),
    );
    await register(
      category: byName['Arriendo']!,
      amount: const Money.fromUnits(800000),
      date: DateTime(2026, 3, 20),
    );
    await register(
      category: byName['Mercado']!,
      amount: const Money.fromUnits(300000),
      date: DateTime(2026, 7, 5),
    );

    final summary = await analytics.watchYear(2026).first;

    expect(summary.totalIncome, const Money.fromUnits(2000000));
    expect(summary.totalExpense, const Money.fromUnits(1100000));
    expect(summary.monthlyBalances[2], const Money.fromUnits(1200000)); // marzo
    expect(summary.monthlyBalances[6], -const Money.fromUnits(300000)); // julio
    expect(summary.monthlyBalances[0], Money.zero); // enero
  });

  test('un mes de otro año no se cuenta', () async {
    await register(
      category: byName['Mercado']!,
      amount: const Money.fromUnits(50000),
      date: DateTime(2025, 12, 31),
    );

    final summary = await analytics.watchYear(2026).first;

    expect(summary.totalExpense, Money.zero);
  });

  test(
    'el desglose por categoría suma el año y ordena de mayor a menor',
    () async {
      await register(
        category: byName['Mecatos']!,
        amount: const Money.fromUnits(30000),
        date: DateTime(2026, 2, 10),
      );
      await register(
        category: byName['Mecatos']!,
        amount: const Money.fromUnits(20000),
        date: DateTime(2026, 8, 10),
      );
      await register(
        category: byName['Arriendo']!,
        amount: const Money.fromUnits(500000),
        date: DateTime(2026, 5, 1),
      );

      final breakdown = await analytics.watchExpenseBreakdown(2026).first;

      expect(breakdown.first.category.name, 'Arriendo');
      expect(breakdown.first.actual, const Money.fromUnits(500000));
      final snacks = breakdown.firstWhere((b) => b.category.name == 'Mecatos');
      expect(snacks.actual, const Money.fromUnits(50000));
    },
  );

  test('el desglose no incluye ingresos', () async {
    await register(
      category: byName['Salario']!,
      amount: const Money.fromUnits(2000000),
      date: DateTime(2026, 1, 15),
    );

    final breakdown = await analytics.watchExpenseBreakdown(2026).first;

    expect(breakdown, isEmpty);
  });
}
