import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/domain/year_month.dart';
import '../domain/category_repository.dart';
import '../domain/finance_category.dart';

class DriftCategoryRepository implements CategoryRepository {
  DriftCategoryRepository(this._db);

  final AppDatabase _db;

  @override
  Stream<List<FinanceCategory>> watchActive() {
    final query = _db.select(_db.categories)
      ..where((c) => c.isArchived.equals(false))
      ..orderBy([
        (c) => OrderingTerm.asc(c.sortOrder),
        (c) => OrderingTerm.asc(c.name),
      ]);
    return query.watch().map((rows) => rows.map(_toEntity).toList());
  }

  @override
  Stream<List<FinanceCategory>> watchAll() {
    final query = _db.select(_db.categories)
      ..orderBy([
        (c) => OrderingTerm.asc(c.sortOrder),
        (c) => OrderingTerm.asc(c.name),
      ]);
    return query.watch().map((rows) => rows.map(_toEntity).toList());
  }

  @override
  Future<int> count() async {
    final total = _db.categories.id.count();
    final row =
        await (_db.selectOnly(_db.categories)..addColumns([total])).getSingle();
    return row.read(total) ?? 0;
  }

  @override
  Future<void> insertAll(List<FinanceCategory> categories) async {
    final now = DateTime.now();
    await _db.batch((batch) {
      batch.insertAll(_db.categories, [
        for (final c in categories)
          CategoriesCompanion.insert(
            id: c.id,
            name: c.name,
            isIncome: c.isIncome,
            isFixed: Value(c.isFixed),
            isAntExpense: Value(c.isAntExpense),
            iconKey: Value(c.iconKey),
            colorHex: Value(c.colorHex),
            sortOrder: Value(c.sortOrder),
            isArchived: Value(c.isArchived),
            isDefault: Value(c.isDefault),
            createdAt: now,
            updatedAt: now,
          ),
      ]);
    });
  }

  @override
  Future<void> add(FinanceCategory category) async {
    final now = DateTime.now();
    // Al final de la lista, para no desordenar las existentes.
    final maxOrder = await _maxSortOrder();

    await _db.into(_db.categories).insert(
          CategoriesCompanion.insert(
            id: category.id,
            name: category.name,
            isIncome: category.isIncome,
            isFixed: Value(category.isFixed),
            isAntExpense: Value(category.isAntExpense),
            iconKey: Value(category.iconKey),
            colorHex: Value(category.colorHex),
            sortOrder: Value(maxOrder + 1),
            createdAt: now,
            updatedAt: now,
          ),
        );
  }

  @override
  Future<void> update(FinanceCategory category) async {
    await (_db.update(_db.categories)..where((c) => c.id.equals(category.id)))
        .write(
      CategoriesCompanion(
        name: Value(category.name),
        isFixed: Value(category.isFixed),
        isAntExpense: Value(category.isAntExpense),
        iconKey: Value(category.iconKey),
        colorHex: Value(category.colorHex),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  @override
  Future<bool> isInUseThisMonth(String categoryId) async {
    final month = YearMonth.now();
    final period = await (_db.select(_db.financialPeriods)
          ..where(
            (p) => p.year.equals(month.year) & p.month.equals(month.month),
          ))
        .getSingleOrNull();
    if (period == null) return false;

    final hasBudget = await (_db.select(_db.budgetItems)
          ..where(
            (b) =>
                b.periodId.equals(period.id) & b.categoryId.equals(categoryId),
          ))
        .get();
    if (hasBudget.isNotEmpty) return true;

    final hasMovement = await (_db.select(_db.financialTransactions)
          ..where(
            (t) =>
                t.periodId.equals(period.id) &
                t.categoryId.equals(categoryId) &
                t.deletedAt.isNull(),
          ))
        .get();
    return hasMovement.isNotEmpty;
  }

  @override
  Future<void> setArchived(String categoryId, bool archived) async {
    await (_db.update(_db.categories)..where((c) => c.id.equals(categoryId)))
        .write(
      CategoriesCompanion(
        isArchived: Value(archived),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<int> _maxSortOrder() async {
    final maxColumn = _db.categories.sortOrder.max();
    final row =
        await (_db.selectOnly(_db.categories)..addColumns([maxColumn])).getSingle();
    return row.read(maxColumn) ?? 0;
  }

  FinanceCategory _toEntity(Category row) {
    return FinanceCategory(
      id: row.id,
      name: row.name,
      isIncome: row.isIncome,
      isFixed: row.isFixed,
      isAntExpense: row.isAntExpense,
      iconKey: row.iconKey,
      colorHex: row.colorHex,
      sortOrder: row.sortOrder,
      isArchived: row.isArchived,
      isDefault: row.isDefault,
    );
  }
}