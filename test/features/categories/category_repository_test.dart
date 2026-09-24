import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mis_finanzas/core/database/app_database.dart';
import 'package:mis_finanzas/features/categories/data/drift_category_repository.dart';
import 'package:mis_finanzas/features/categories/domain/finance_category.dart';
import 'package:mis_finanzas/features/categories/domain/seed_default_categories.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

void main() {
  late AppDatabase db;
  late DriftCategoryRepository repository;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repository = DriftCategoryRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  FinanceCategory category(
    String name, {
    int sortOrder = 0,
    bool isArchived = false,
  }) {
    return FinanceCategory(
      id: _uuid.v4(),
      name: name,
      isIncome: false,
      isFixed: false,
      sortOrder: sortOrder,
      isArchived: isArchived,
    );
  }

  test('insertAll guarda las categorías y count las cuenta', () async {
    expect(await repository.count(), 0);
    await repository.insertAll([category('A'), category('B')]);
    expect(await repository.count(), 2);
  });

  test('watchActive ordena por sortOrder y oculta las archivadas', () async {
    await repository.insertAll([
      category('Tercera', sortOrder: 2),
      category('Primera', sortOrder: 0),
      category('Segunda', sortOrder: 1),
      category('Archivada', sortOrder: 3, isArchived: true),
    ]);

    final result = await repository.watchActive().first;
    expect(result.map((c) => c.name), ['Primera', 'Segunda', 'Tercera']);
  });

  test('sembrar categorías por defecto crea las 49 la primera vez', () async {
    final seed = SeedDefaultCategories(repository);

    final created = await seed();

    expect(created, isTrue);
    expect(await repository.count(), 49);

    final categories = await repository.watchActive().first;
    expect(categories.first.name, 'Salario');
    expect(categories.where((c) => c.isAntExpense).map((c) => c.name).toSet(), {
      'Mecatos',
      'Otras D',
      'Antojos Diarios',
      'Suscripciones Digitales',
      'Comida a Domicilio',
      'Transporte por Comodidad',
      'Otros gastos hormiga',
    });
  });

  test('sembrar dos veces no duplica las categorías', () async {
    final seed = SeedDefaultCategories(repository);
    await seed();
    final secondTime = await seed();

    expect(secondTime, isFalse);
    expect(await repository.count(), 49);
  });
}
