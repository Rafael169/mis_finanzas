import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mis_finanzas/core/database/app_database.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

void main() {
  late AppDatabase db;
  final now = DateTime(2026, 8, 20);

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  Future<String> insertPeriod({int year = 2026, int month = 8}) async {
    final id = _uuid.v4();
    await db.into(db.financialPeriods).insert(
          FinancialPeriodsCompanion.insert(
            id: id,
            year: year,
            month: month,
            startDate: DateTime(year, month, 1),
            endDate: DateTime(year, month + 1, 0),
            createdAt: now,
            updatedAt: now,
          ),
        );
    return id;
  }

  Future<String> insertCategory({bool isIncome = false}) async {
    final id = _uuid.v4();
    await db.into(db.categories).insert(
          CategoriesCompanion.insert(
            id: id,
            name: 'Mecatos',
            isIncome: isIncome,
            createdAt: now,
            updatedAt: now,
          ),
        );
    return id;
  }

  test('no permite dos períodos para el mismo año y mes', () async {
    await insertPeriod();
    await expectLater(insertPeriod(), throwsA(anything));
  });

  test('no permite un movimiento con categoría inexistente', () async {
    final periodId = await insertPeriod();

    await expectLater(
      db.into(db.financialTransactions).insert(
            FinancialTransactionsCompanion.insert(
              id: _uuid.v4(),
              periodId: periodId,
              categoryId: _uuid.v4(), // esta categoría no existe
              isIncome: false,
              amount: 5000000,
              date: now,
              cutNumber: 2,
              createdAt: now,
              updatedAt: now,
            ),
          ),
      throwsA(anything),
    );
  });

  test('no permite dos presupuestos mensuales de la misma categoría', () async {
    final periodId = await insertPeriod();
    final categoryId = await insertCategory();

    Future<void> insertBudget() {
      return db.into(db.budgetItems).insert(
            BudgetItemsCompanion.insert(
              id: _uuid.v4(),
              periodId: periodId,
              categoryId: categoryId,
              amountLimit: 5500000,
              createdAt: now,
              updatedAt: now,
            ),
          );
    }

    await insertBudget();
    await expectLater(insertBudget(), throwsA(anything));
  });

  test('guarda y lee un movimiento', () async {
    final periodId = await insertPeriod();
    final categoryId = await insertCategory();

    await db.into(db.financialTransactions).insert(
          FinancialTransactionsCompanion.insert(
            id: _uuid.v4(),
            periodId: periodId,
            categoryId: categoryId,
            isIncome: false,
            amount: 5000000, // $50.000 guardado en "centavos"
            date: now,
            cutNumber: 2,
            description: const Value('Mecatos de la semana'),
            createdAt: now,
            updatedAt: now,
          ),
        );

    final rows = await db.select(db.financialTransactions).get();
    expect(rows, hasLength(1));
    expect(rows.first.amount, 5000000);
    expect(rows.first.deletedAt, isNull);
  });
}