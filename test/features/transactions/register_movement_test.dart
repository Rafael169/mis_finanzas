import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mis_finanzas/core/database/app_database.dart';
import 'package:mis_finanzas/core/domain/money.dart';
import 'package:mis_finanzas/core/domain/year_month.dart';
import 'package:mis_finanzas/features/categories/data/drift_category_repository.dart';
import 'package:mis_finanzas/features/categories/domain/finance_category.dart';
import 'package:mis_finanzas/features/categories/domain/seed_default_categories.dart';
import 'package:mis_finanzas/features/periods/data/drift_period_repository.dart';
import 'package:mis_finanzas/features/transactions/data/drift_movement_repository.dart';
import 'package:mis_finanzas/features/transactions/domain/register_movement.dart';

void main() {
  late AppDatabase db;
  late RegisterMovement register;
  late DriftPeriodRepository periods;
  late Map<String, FinanceCategory> byName;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());

    final categoryRepository = DriftCategoryRepository(db);
    await SeedDefaultCategories(categoryRepository)();
    final all = await categoryRepository.watchActive().first;
    byName = {for (final c in all) c.name: c};

    register = RegisterMovement(DriftMovementRepository(db));
    periods = DriftPeriodRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('un gasto crea el mes y actualiza los totales', () async {
    await register(
      category: byName['Mecatos']!,
      amount: const Money.fromUnits(50000),
      date: DateTime(2026, 8, 20, 23, 59),
    );

    final summary = await periods.watchSummary(const YearMonth(2026, 8)).first;
    expect(summary.expense, const Money.fromUnits(50000));
    expect(summary.antExpense, const Money.fromUnits(50000));
    expect(summary.income, Money.zero);
    expect(summary.balance, -const Money.fromUnits(50000));

    final rows = await db.select(db.financialTransactions).get();
    expect(rows, hasLength(1));
    expect(rows.single.amount, 5000000);
    expect(rows.single.cutNumber, 2);
    expect(rows.single.date, DateTime(2026, 8, 20)); // se ignora la hora
    expect(await db.select(db.financialPeriods).get(), hasLength(1));
  });

  test('el salario y los ingresos adicionales suman al ingreso', () async {
    await register(
      category: byName['Salario']!,
      amount: const Money.fromUnits(2025041),
      date: DateTime(2026, 8, 15),
    );
    await register(
      category: byName['Ingresos adicionales']!,
      amount: const Money.fromUnits(100000),
      date: DateTime(2026, 8, 18),
    );
    await register(
      category: byName['Arriendo']!,
      amount: const Money.fromUnits(855200),
      date: DateTime(2026, 8, 20),
    );

    final summary = await periods.watchSummary(const YearMonth(2026, 8)).first;
    expect(summary.income, const Money.fromUnits(2125041));
    expect(summary.extraIncome, const Money.fromUnits(100000));
    expect(summary.expense, const Money.fromUnits(855200));
    expect(summary.antExpense, Money.zero);
    expect(summary.balance, const Money.fromUnits(1269841));
  });

  test('el corte se decide por el día: el 15 es Corte 1 y el 16 Corte 2',
      () async {
    await register(
      category: byName['Mecatos']!,
      amount: const Money.fromUnits(1000),
      date: DateTime(2026, 8, 15),
    );
    await register(
      category: byName['Mecatos']!,
      amount: const Money.fromUnits(2000),
      date: DateTime(2026, 8, 16),
    );

    final rows = await db.select(db.financialTransactions).get();
    final cutByAmount = {for (final r in rows) r.amount: r.cutNumber};
    expect(cutByAmount, {100000: 1, 200000: 2});
  });

  test('los totales por categoría y corte se acumulan', () async {
    final snacks = byName['Mecatos']!;
    await register(
      category: snacks,
      amount: const Money.fromUnits(1000),
      date: DateTime(2026, 8, 2),
    );
    await register(
      category: snacks,
      amount: const Money.fromUnits(2500),
      date: DateTime(2026, 8, 10),
    );
    await register(
      category: snacks,
      amount: const Money.fromUnits(4000),
      date: DateTime(2026, 8, 20),
    );

    final totals = await db.select(db.categoryPeriodTotals).get();
    expect(totals, hasLength(2));

    final cut1 = totals.firstWhere((t) => t.cutNumber == 1);
    expect(cut1.actualTotal, 350000);
    expect(cut1.txCount, 2);

    final cut2 = totals.firstWhere((t) => t.cutNumber == 2);
    expect(cut2.actualTotal, 400000);
    expect(cut2.txCount, 1);
  });

  test('movimientos de meses distintos crean períodos distintos', () async {
    await register(
      category: byName['Mercado']!,
      amount: const Money.fromUnits(100000),
      date: DateTime(2026, 8, 5),
    );
    await register(
      category: byName['Mercado']!,
      amount: const Money.fromUnits(50000),
      date: DateTime(2026, 9, 5),
    );

    expect(await db.select(db.financialPeriods).get(), hasLength(2));

    final august = await periods.watchSummary(const YearMonth(2026, 8)).first;
    final september =
        await periods.watchSummary(const YearMonth(2026, 9)).first;
    expect(august.expense, const Money.fromUnits(100000));
    expect(september.expense, const Money.fromUnits(50000));
  });

  test('un monto en cero o negativo se rechaza y no guarda nada', () async {
    await expectLater(
      register(
        category: byName['Mecatos']!,
        amount: Money.zero,
        date: DateTime(2026, 8, 20),
      ),
      throwsA(isA<MovementException>()),
    );
    await expectLater(
      register(
        category: byName['Mecatos']!,
        amount: -const Money.fromUnits(5),
        date: DateTime(2026, 8, 20),
      ),
      throwsA(isA<MovementException>()),
    );

    expect(await db.select(db.financialTransactions).get(), isEmpty);
    expect(await db.select(db.financialPeriods).get(), isEmpty);
  });

  test('una categoría archivada se rechaza', () async {
    const archived = FinanceCategory(
      id: 'archivada',
      name: 'Vieja',
      isIncome: false,
      isFixed: false,
      isArchived: true,
    );

    await expectLater(
      register(
        category: archived,
        amount: const Money.fromUnits(1000),
        date: DateTime(2026, 8, 20),
      ),
      throwsA(isA<MovementException>()),
    );
  });

  test('si algo falla no queda nada a medias, ni siquiera el mes', () async {
    // Esta categoría no existe en la base: la clave foránea falla al guardar.
    const ghost = FinanceCategory(
      id: 'no-existe',
      name: 'Fantasma',
      isIncome: false,
      isFixed: false,
    );

    await expectLater(
      register(
        category: ghost,
        amount: const Money.fromUnits(1000),
        date: DateTime(2026, 8, 20),
      ),
      throwsA(anything),
    );

    expect(await db.select(db.financialTransactions).get(), isEmpty);
    expect(await db.select(db.financialPeriods).get(), isEmpty);
    expect(await db.select(db.categoryPeriodTotals).get(), isEmpty);
  });
}