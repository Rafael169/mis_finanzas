import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mis_finanzas/core/database/app_database.dart';
import 'package:mis_finanzas/core/domain/money.dart';
import 'package:mis_finanzas/core/domain/year_month.dart';
import 'package:mis_finanzas/features/budgets/data/drift_budget_repository.dart';
import 'package:mis_finanzas/features/budgets/domain/category_budget.dart';
import 'package:mis_finanzas/features/budgets/domain/save_budget.dart';
import 'package:mis_finanzas/features/categories/data/drift_category_repository.dart';
import 'package:mis_finanzas/features/categories/domain/finance_category.dart';
import 'package:mis_finanzas/features/categories/domain/seed_default_categories.dart';
import 'package:mis_finanzas/features/transactions/data/drift_movement_repository.dart';
import 'package:mis_finanzas/features/transactions/domain/register_movement.dart';

void main() {
  const july = YearMonth(2026, 7);
  const august = YearMonth(2026, 8);

  late AppDatabase db;
  late DriftBudgetRepository budgets;
  late SaveBudget saveBudget;
  late RegisterMovement register;
  late Map<String, FinanceCategory> byName;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());

    final categoryRepository = DriftCategoryRepository(db);
    await SeedDefaultCategories(categoryRepository)();
    final all = await categoryRepository.watchActive().first;
    byName = {for (final c in all) c.name: c};

    budgets = DriftBudgetRepository(db);
    saveBudget = SaveBudget(budgets);
    register = RegisterMovement(DriftMovementRepository(db));
  });

  tearDown(() async {
    await db.close();
  });

  Future<List<CategoryBudget>> load(YearMonth month) =>
      budgets.watchMonth(month).first;

  CategoryBudget find(List<CategoryBudget> list, String name) =>
      list.firstWhere((b) => b.category.name == name);

  test('un mes sin datos lista las categorías sin presupuesto ni real',
      () async {
    final list = await load(august);

    expect(list, hasLength(49));
    expect(list.every((b) => b.mode == BudgetMode.none), isTrue);
    expect(list.every((b) => b.actualMonth == Money.zero), isTrue);
    // Solo mirar no crea el mes.
    expect(await db.select(db.financialPeriods).get(), isEmpty);
  });

  test('un presupuesto mensual se guarda y actualiza el total en caché',
      () async {
    await saveBudget(
      month: august,
      category: byName['Arriendo']!,
      monthly: const Money.fromUnits(500000),
    );

    final rent = find(await load(august), 'Arriendo');
    expect(rent.mode, BudgetMode.monthly);
    expect(rent.monthlyLimit, const Money.fromUnits(500000));

    final period = await db.select(db.financialPeriods).getSingle();
    expect(period.expenseBudgetTotal, 500000 * 100);
    expect(period.incomeBudgetTotal, 0);
  });

  test('los presupuestos por corte de un ingreso suman al total de ingresos',
      () async {
    await saveBudget(
      month: august,
      category: byName['Salario']!,
      cut1: const Money.fromUnits(1000000),
      cut2: const Money.fromUnits(1025041),
    );

    final salary = find(await load(august), 'Salario');
    expect(salary.mode, BudgetMode.perCut);
    expect(salary.monthLimit, const Money.fromUnits(2025041));

    final period = await db.select(db.financialPeriods).getSingle();
    expect(period.incomeBudgetTotal, 2025041 * 100);
    expect(period.expenseBudgetTotal, 0);
  });

  test('cambiar de mensual a por corte reemplaza el límite anterior',
      () async {
    final rent = byName['Arriendo']!;
    await saveBudget(
      month: august,
      category: rent,
      monthly: const Money.fromUnits(500000),
    );

    await saveBudget(
      month: august,
      category: rent,
      cut1: const Money.fromUnits(200000),
      cut2: const Money.fromUnits(300000),
    );

    final result = find(await load(august), 'Arriendo');
    expect(result.mode, BudgetMode.perCut);
    expect(result.monthlyLimit, isNull);
    expect(await db.select(db.budgetItems).get(), hasLength(2));
  });

  test('quitar el presupuesto elimina los límites y deja el total en cero',
      () async {
    final rent = byName['Arriendo']!;
    await saveBudget(
      month: august,
      category: rent,
      monthly: const Money.fromUnits(500000),
    );

    await saveBudget(month: august, category: rent);

    expect(find(await load(august), 'Arriendo').mode, BudgetMode.none);
    expect(await db.select(db.budgetItems).get(), isEmpty);

    final period = await db.select(db.financialPeriods).getSingle();
    expect(period.expenseBudgetTotal, 0);
  });

  test('el real sale de los movimientos registrados', () async {
    final snacks = byName['Mecatos']!;
    await register(
      category: snacks,
      amount: const Money.fromUnits(30000),
      date: DateTime(2026, 8, 10),
    );
    await register(
      category: snacks,
      amount: const Money.fromUnits(20000),
      date: DateTime(2026, 8, 20),
    );

    final result = find(await load(august), 'Mecatos');

    expect(result.actualCut1, const Money.fromUnits(30000));
    expect(result.actualCut2, const Money.fromUnits(20000));
    expect(result.actualMonth, const Money.fromUnits(50000));
  });

  test('copiar del mes anterior solo copia las categorías sin presupuesto',
      () async {
    await saveBudget(
      month: july,
      category: byName['Arriendo']!,
      monthly: const Money.fromUnits(500000),
    );
    await saveBudget(
      month: july,
      category: byName['Mercado']!,
      monthly: const Money.fromUnits(300000),
    );
    await saveBudget(
      month: august,
      category: byName['Mercado']!,
      monthly: const Money.fromUnits(350000),
    );

    final copied = await budgets.copyFromPreviousMonth(august);

    expect(copied, 1);
    final list = await load(august);
    expect(
      find(list, 'Arriendo').monthlyLimit,
      const Money.fromUnits(500000),
    );
    // Lo que ya estaba definido no se toca.
    expect(
      find(list, 'Mercado').monthlyLimit,
      const Money.fromUnits(350000),
    );

    final periods = await db.select(db.financialPeriods).get();
    final augustPeriod = periods.firstWhere((p) => p.month == 8);
    expect(augustPeriod.expenseBudgetTotal, 850000 * 100);
  });

  test('copiar sin presupuestos en el mes anterior devuelve cero', () async {
    final copied = await budgets.copyFromPreviousMonth(august);

    expect(copied, 0);
    expect(await db.select(db.financialPeriods).get(), isEmpty);
  });

  test('el caso de uso rechaza negativos y ambos modos, y el cero es "sin"',
      () async {
    final rent = byName['Arriendo']!;

    await expectLater(
      saveBudget(month: august, category: rent, monthly: const Money.fromMinor(-5)),
      throwsA(isA<BudgetException>()),
    );
    await expectLater(
      saveBudget(
        month: august,
        category: rent,
        monthly: const Money.fromUnits(100),
        cut1: const Money.fromUnits(100),
      ),
      throwsA(isA<BudgetException>()),
    );

    // Un monto en cero se toma como quitar: no guarda nada ni crea el mes.
    await saveBudget(month: august, category: rent, monthly: Money.zero);
    expect(await db.select(db.budgetItems).get(), isEmpty);
    expect(await db.select(db.financialPeriods).get(), isEmpty);
  });
}