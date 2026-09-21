import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mis_finanzas/core/database/app_database.dart';
import 'package:mis_finanzas/core/domain/money.dart';
import 'package:mis_finanzas/core/domain/year_month.dart';
import 'package:mis_finanzas/features/categories/data/drift_category_repository.dart';
import 'package:mis_finanzas/features/categories/domain/finance_category.dart';
import 'package:mis_finanzas/features/categories/domain/seed_default_categories.dart';
import 'package:mis_finanzas/features/periods/data/drift_period_repository.dart';
import 'package:mis_finanzas/features/periods/domain/period_repository.dart';
import 'package:mis_finanzas/features/transactions/data/drift_movement_reader.dart';
import 'package:mis_finanzas/features/transactions/data/drift_movement_repository.dart';
import 'package:mis_finanzas/features/transactions/domain/register_movement.dart';
import 'package:mis_finanzas/features/transactions/domain/update_movement.dart';

void main() {
  late AppDatabase db;
  late DriftMovementRepository repository;
  late RegisterMovement register;
  late UpdateMovement update;
  late DriftMovementReader reader;
  late DriftPeriodRepository periods;
  late Map<String, FinanceCategory> byName;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());

    final categoryRepository = DriftCategoryRepository(db);
    await SeedDefaultCategories(categoryRepository)();
    final all = await categoryRepository.watchActive().first;
    byName = {for (final c in all) c.name: c};

    repository = DriftMovementRepository(db);
    register = RegisterMovement(repository);
    update = UpdateMovement(repository);
    reader = DriftMovementReader(db);
    periods = DriftPeriodRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  /// Registra un gasto y devuelve su id (los tests usan un solo movimiento
  /// por mes, así que es el primero de la lista).
  Future<String> addExpense(String category, int units, DateTime date) async {
    await register(
      category: byName[category]!,
      amount: Money.fromUnits(units),
      date: date,
    );
    final items = await reader.watchMonth(YearMonth.fromDate(date)).first;
    return items.first.id;
  }

  Future<PeriodSummary> summary(int year, int month) =>
      periods.watchSummary(YearMonth(year, month)).first;

  test('editar el monto actualiza los totales del mes', () async {
    final id = await addExpense('Mecatos', 50000, DateTime(2026, 8, 20));

    await update(
      id: id,
      category: byName['Mecatos']!,
      amount: const Money.fromUnits(30000),
      date: DateTime(2026, 8, 20),
    );

    final s = await summary(2026, 8);
    expect(s.expense, const Money.fromUnits(30000));
    expect(s.antExpense, const Money.fromUnits(30000));
  });

  test(
    'cambiar de categoría hormiga a otra la quita del gasto hormiga',
    () async {
      final id = await addExpense('Mecatos', 50000, DateTime(2026, 8, 20));

      await update(
        id: id,
        category: byName['Mercado']!,
        amount: const Money.fromUnits(50000),
        date: DateTime(2026, 8, 20),
      );

      final s = await summary(2026, 8);
      expect(s.expense, const Money.fromUnits(50000));
      expect(s.antExpense, Money.zero);
    },
  );

  test('cambiar de gasto a ingreso mueve el monto entre los totales', () async {
    final id = await addExpense('Mecatos', 50000, DateTime(2026, 8, 20));

    await update(
      id: id,
      category: byName['Salario']!,
      amount: const Money.fromUnits(50000),
      date: DateTime(2026, 8, 20),
    );

    final s = await summary(2026, 8);
    expect(s.income, const Money.fromUnits(50000));
    expect(s.extraIncome, Money.zero);
    expect(s.expense, Money.zero);
    expect(s.antExpense, Money.zero);
    expect(s.balance, const Money.fromUnits(50000));
  });

  test(
    'cambiar la fecha a otro mes mueve los totales entre los meses',
    () async {
      final id = await addExpense('Mecatos', 50000, DateTime(2026, 8, 20));

      await update(
        id: id,
        category: byName['Mecatos']!,
        amount: const Money.fromUnits(50000),
        date: DateTime(2026, 9, 3),
      );

      final august = await summary(2026, 8);
      final september = await summary(2026, 9);
      expect(august.expense, Money.zero);
      expect(august.antExpense, Money.zero);
      expect(september.expense, const Money.fromUnits(50000));
      expect(september.antExpense, const Money.fromUnits(50000));

      expect(await db.select(db.financialPeriods).get(), hasLength(2));
      // Solo queda el total del mes nuevo.
      expect(await db.select(db.categoryPeriodTotals).get(), hasLength(1));
    },
  );

  test(
    'cambiar la fecha de la primera a la segunda quincena cambia el corte',
    () async {
      final id = await addExpense('Mecatos', 50000, DateTime(2026, 8, 10));

      await update(
        id: id,
        category: byName['Mecatos']!,
        amount: const Money.fromUnits(50000),
        date: DateTime(2026, 8, 20),
      );

      final rows = await db.select(db.financialTransactions).get();
      expect(rows.single.cutNumber, 2);

      final totals = await db.select(db.categoryPeriodTotals).get();
      expect(totals, hasLength(1));
      expect(totals.single.cutNumber, 2);
      expect(totals.single.actualTotal, 5000000);
    },
  );

  test(
    'borrar oculta el movimiento, lo resta de los totales y lo conserva',
    () async {
      final id = await addExpense('Mecatos', 50000, DateTime(2026, 8, 20));

      await repository.softDelete(id);

      final s = await summary(2026, 8);
      expect(s.expense, Money.zero);
      expect(s.antExpense, Money.zero);

      expect(await reader.watchMonth(const YearMonth(2026, 8)).first, isEmpty);
      expect(await db.select(db.categoryPeriodTotals).get(), isEmpty);

      // Sigue en la base, solo marcado como eliminado.
      final rows = await db.select(db.financialTransactions).get();
      expect(rows, hasLength(1));
      expect(rows.single.deletedAt, isNotNull);
    },
  );

  test('deshacer un borrado devuelve el movimiento y los totales', () async {
    final id = await addExpense('Mecatos', 50000, DateTime(2026, 8, 20));
    await repository.softDelete(id);

    await repository.restore(id);

    final s = await summary(2026, 8);
    expect(s.expense, const Money.fromUnits(50000));
    expect(s.antExpense, const Money.fromUnits(50000));
    expect(
      await reader.watchMonth(const YearMonth(2026, 8)).first,
      hasLength(1),
    );

    final rows = await db.select(db.financialTransactions).get();
    expect(rows.single.deletedAt, isNull);
  });

  test('editar un movimiento que no existe lanza un error claro', () async {
    await expectLater(
      update(
        id: 'no-existe',
        category: byName['Mecatos']!,
        amount: const Money.fromUnits(1000),
        date: DateTime(2026, 8, 20),
      ),
      throwsA(isA<MovementException>()),
    );
  });

  test(
    'getById devuelve el movimiento, y null si no existe o se borró',
    () async {
      final id = await addExpense('Mecatos', 50000, DateTime(2026, 8, 20));

      final found = await reader.getById(id);
      expect(found, isNotNull);
      expect(found!.categoryName, 'Mecatos');
      expect(found.amount, const Money.fromUnits(50000));

      expect(await reader.getById('no-existe'), isNull);

      await repository.softDelete(id);
      expect(await reader.getById(id), isNull);
    },
  );

  test('editar con un monto en cero se rechaza y no cambia nada', () async {
    final id = await addExpense('Mecatos', 50000, DateTime(2026, 8, 20));

    await expectLater(
      update(
        id: id,
        category: byName['Mecatos']!,
        amount: Money.zero,
        date: DateTime(2026, 8, 20),
      ),
      throwsA(isA<MovementException>()),
    );

    final s = await summary(2026, 8);
    expect(s.expense, const Money.fromUnits(50000));
  });
}
