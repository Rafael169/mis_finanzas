import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
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