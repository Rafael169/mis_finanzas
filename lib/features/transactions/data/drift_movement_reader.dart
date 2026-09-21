import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/domain/money.dart';
import '../../../core/domain/year_month.dart';
import '../domain/movement_item.dart';
import '../domain/movement_reader.dart';

class DriftMovementReader implements MovementReader {
  DriftMovementReader(this._db);

  final AppDatabase _db;

  @override
  Stream<List<MovementItem>> watchMonth(YearMonth month) {
    final t = _db.financialTransactions;
    final c = _db.categories;

    final query = _db
        .select(t)
        .join([innerJoin(c, c.id.equalsExp(t.categoryId))])
      ..where(
        t.deletedAt.isNull() &
            t.date.isBiggerOrEqualValue(month.firstDay) &
            t.date.isSmallerThanValue(month.next.firstDay),
      )
      ..orderBy([
        OrderingTerm.desc(t.date),
        OrderingTerm.desc(t.createdAt),
      ]);

    return query.watch().map((rows) => rows.map(_toItem).toList());
  }

  @override
  Future<MovementItem?> getById(String id) async {
    final t = _db.financialTransactions;
    final c = _db.categories;

    final query = _db
        .select(t)
        .join([innerJoin(c, c.id.equalsExp(t.categoryId))])
      ..where(t.id.equals(id) & t.deletedAt.isNull());

    final row = await query.getSingleOrNull();
    return row == null ? null : _toItem(row);
  }

  MovementItem _toItem(TypedResult row) {
    final tx = row.readTable(_db.financialTransactions);
    final category = row.readTable(_db.categories);
    return MovementItem(
      id: tx.id,
      categoryId: tx.categoryId,
      categoryName: category.name,
      categoryIconKey: category.iconKey,
      categoryColorHex: category.colorHex,
      isIncome: tx.isIncome,
      isAntExpense: category.isAntExpense,
      amount: Money.fromMinor(tx.amount),
      date: tx.date,
      cutNumber: tx.cutNumber,
      description: tx.description,
    );
  }
}