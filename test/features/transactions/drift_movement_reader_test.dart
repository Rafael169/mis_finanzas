import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mis_finanzas/core/database/app_database.dart';
import 'package:mis_finanzas/core/domain/money.dart';
import 'package:mis_finanzas/core/domain/year_month.dart';
import 'package:mis_finanzas/features/categories/data/drift_category_repository.dart';
import 'package:mis_finanzas/features/categories/domain/finance_category.dart';
import 'package:mis_finanzas/features/categories/domain/seed_default_categories.dart';
import 'package:mis_finanzas/features/transactions/data/drift_movement_reader.dart';
import 'package:mis_finanzas/features/transactions/data/drift_movement_repository.dart';
import 'package:mis_finanzas/features/transactions/domain/register_movement.dart';

void main() {
  late AppDatabase db;
  late RegisterMovement register;
  late DriftMovementReader reader;
  late Map<String, FinanceCategory> byName;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());

    final categoryRepository = DriftCategoryRepository(db);
    await SeedDefaultCategories(categoryRepository)();
    final all = await categoryRepository.watchActive().first;
    byName = {for (final c in all) c.name: c};

    register = RegisterMovement(DriftMovementRepository(db));
    reader = DriftMovementReader(db);
  });

  tearDown(() async {
    await db.close();
  });

  Future<void> spend(String category, int units, DateTime date) {
    return register(
      category: byName[category]!,
      amount: Money.fromUnits(units),
      date: date,
    );
  }

  test('devuelve solo los movimientos del mes pedido', () async {
    await spend('Mercado', 1000, DateTime(2026, 7, 31));
    await spend('Mercado', 2000, DateTime(2026, 8, 1));
    await spend('Mercado', 3000, DateTime(2026, 8, 31));
    await spend('Mercado', 4000, DateTime(2026, 9, 1));

    final august = await reader.watchMonth(const YearMonth(2026, 8)).first;

    expect(august.map((m) => m.amount), [
      const Money.fromUnits(3000),
      const Money.fromUnits(2000),
    ]);
  });

  test('ordena del más reciente al más antiguo', () async {
    await spend('Mercado', 1000, DateTime(2026, 8, 5));
    await spend('Mercado', 2000, DateTime(2026, 8, 20));
    await spend('Mercado', 3000, DateTime(2026, 8, 12));

    final items = await reader.watchMonth(const YearMonth(2026, 8)).first;

    expect(items.map((m) => m.date.day), [20, 12, 5]);
  });

  test('incluye los datos de la categoría', () async {
    await register(
      category: byName['Mecatos']!,
      amount: const Money.fromUnits(50000),
      date: DateTime(2026, 8, 20),
      description: 'Empanadas',
    );

    final items = await reader.watchMonth(const YearMonth(2026, 8)).first;

    expect(items, hasLength(1));
    final item = items.single;
    expect(item.categoryName, 'Mecatos');
    expect(item.categoryIconKey, 'fastfood');
    expect(item.isAntExpense, isTrue);
    expect(item.isIncome, isFalse);
    expect(item.amount, const Money.fromUnits(50000));
    expect(item.cutNumber, 2);
    expect(item.description, 'Empanadas');
  });

  test('no incluye movimientos eliminados', () async {
    await spend('Mercado', 1000, DateTime(2026, 8, 5));
    await spend('Mercado', 2000, DateTime(2026, 8, 6));

    // Simula un borrado lógico marcando todos los movimientos.
    await db.update(db.financialTransactions).write(
          FinancialTransactionsCompanion(deletedAt: Value(DateTime.now())),
        );

    final items = await reader.watchMonth(const YearMonth(2026, 8)).first;

    expect(items, isEmpty);
  });
}