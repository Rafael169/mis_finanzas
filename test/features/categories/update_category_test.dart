import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mis_finanzas/core/database/app_database.dart';
import 'package:mis_finanzas/features/categories/data/drift_category_repository.dart';
import 'package:mis_finanzas/features/categories/domain/finance_category.dart';
import 'package:mis_finanzas/features/categories/domain/update_category.dart';
import 'package:uuid/uuid.dart';

void main() {
  late AppDatabase db;
  late DriftCategoryRepository repository;
  late AddCategory add;
  late UpdateCategory update;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repository = DriftCategoryRepository(db);
    add = AddCategory(repository);
    update = UpdateCategory(repository);
  });

  tearDown(() async {
    await db.close();
  });

  test('crea una categoría nueva al final de la lista', () async {
    await add(FinanceCategory(
      id: const Uuid().v4(),
      name: 'Suscripciones',
      isIncome: false,
      isFixed: false,
    ));

    final all = await repository.watchAll().first;
    expect(all, hasLength(1));
    expect(all.single.name, 'Suscripciones');
  });

  test('rechaza un nombre vacío', () async {
    await expectLater(
      add(FinanceCategory(
        id: const Uuid().v4(),
        name: '   ',
        isIncome: false,
        isFixed: false,
      )),
      throwsA(isA<CategoryException>()),
    );
  });

  test('rechaza hormiga en un gasto fijo o en un ingreso', () async {
    await expectLater(
      add(FinanceCategory(
        id: const Uuid().v4(),
        name: 'X',
        isIncome: false,
        isFixed: true,
        isAntExpense: true,
      )),
      throwsA(isA<CategoryException>()),
    );
  });

  test('editar cambia los datos sin duplicar la fila', () async {
    final id = const Uuid().v4();
    await add(FinanceCategory(id: id, name: 'Viejo', isIncome: false, isFixed: true));

    await update(FinanceCategory(id: id, name: 'Nuevo', isIncome: false, isFixed: false));

    final all = await repository.watchAll().first;
    expect(all, hasLength(1));
    expect(all.single.name, 'Nuevo');
    expect(all.single.isFixed, isFalse);
  });
}