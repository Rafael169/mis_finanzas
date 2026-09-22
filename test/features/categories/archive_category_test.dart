import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mis_finanzas/core/database/app_database.dart';
import 'package:mis_finanzas/core/domain/money.dart';
import 'package:mis_finanzas/core/domain/year_month.dart';
import 'package:mis_finanzas/features/budgets/data/drift_budget_repository.dart';
import 'package:mis_finanzas/features/budgets/domain/save_budget.dart';
import 'package:mis_finanzas/features/categories/data/drift_category_repository.dart';
import 'package:mis_finanzas/features/categories/domain/archive_category.dart';
import 'package:mis_finanzas/features/categories/domain/seed_default_categories.dart';
import 'package:mis_finanzas/features/categories/domain/update_category.dart';
import 'package:mis_finanzas/features/transactions/data/drift_movement_repository.dart';
import 'package:mis_finanzas/features/transactions/domain/register_movement.dart';

void main() {
  late AppDatabase db;
  late DriftCategoryRepository categories;
  late ArchiveCategory archive;
  late Map<String, String> idByName;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    categories = DriftCategoryRepository(db);
    await SeedDefaultCategories(categories)();
    final all = await categories.watchActive().first;
    idByName = {for (final c in all) c.name: c.id};

    archive = ArchiveCategory(categories);
  });

  tearDown(() async {
    await db.close();
  });

  test('archivar una categoría sin uso la quita de watchActive', () async {
    await archive(idByName['Ropa']!, archive: true);

    final active = await categories.watchActive().first;
    expect(active.any((c) => c.name == 'Ropa'), isFalse);

    final all = await categories.watchAll().first;
    expect(all.any((c) => c.name == 'Ropa'), isTrue);
  });

  test('no se puede archivar una categoría con movimientos este mes', () async {
    final register = RegisterMovement(DriftMovementRepository(db));
    await register(
      category: (await categories.watchActive().first).firstWhere(
        (c) => c.name == 'Mecatos',
      ),
      amount: const Money.fromUnits(5000),
      date: DateTime.now(),
    );

    await expectLater(
      archive(idByName['Mecatos']!, archive: true),
      throwsA(isA<CategoryException>()),
    );
  });

  test('no se puede archivar una categoría con presupuesto este mes', () async {
    final saveBudget = SaveBudget(DriftBudgetRepository(db));
    final rent = (await categories.watchActive().first).firstWhere(
      (c) => c.name == 'Arriendo',
    );

    await saveBudget(
      month: YearMonth.now(),
      category: rent,
      monthly: const Money.fromUnits(500000),
    );

    await expectLater(
      archive(idByName['Arriendo']!, archive: true),
      throwsA(isA<CategoryException>()),
    );
  });

  test('sí se puede archivar si el uso fue en un mes pasado', () async {
    final register = RegisterMovement(DriftMovementRepository(db));
    await register(
      category: (await categories.watchActive().first).firstWhere(
        (c) => c.name == 'Mecatos',
      ),
      amount: const Money.fromUnits(5000),
      date: DateTime(2020, 1, 15),
    );

    await archive(idByName['Mecatos']!, archive: true);

    final active = await categories.watchActive().first;
    expect(active.any((c) => c.name == 'Mecatos'), isFalse);
  });

  test('restaurar una categoría archivada la devuelve a watchActive', () async {
    await archive(idByName['Ropa']!, archive: true);
    await archive(idByName['Ropa']!, archive: false);

    final active = await categories.watchActive().first;
    expect(active.any((c) => c.name == 'Ropa'), isTrue);
  });
}
