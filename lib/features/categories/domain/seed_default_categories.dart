import 'package:uuid/uuid.dart';

import 'category_repository.dart';
import 'default_categories.dart';
import 'finance_category.dart';

/// Crea las categorías por defecto. Es seguro llamarlo más de una vez:
/// si ya hay categorías, no hace nada.
class SeedDefaultCategories {
  SeedDefaultCategories(this._repository, {Uuid? uuid})
      : _uuid = uuid ?? const Uuid();

  final CategoryRepository _repository;
  final Uuid _uuid;

  /// Devuelve true si creó las categorías, false si ya existían.
  Future<bool> call() async {
    if (await _repository.count() > 0) return false;

    final categories = <FinanceCategory>[];
    for (var i = 0; i < defaultCategorySeeds.length; i++) {
      final seed = defaultCategorySeeds[i];
      categories.add(
        FinanceCategory(
          id: _uuid.v4(),
          name: seed.name,
          isIncome: seed.isIncome,
          isFixed: seed.isFixed,
          isAntExpense: seed.isAntExpense,
          iconKey: seed.iconKey,
          colorHex: seed.colorHex,
          groupLabel: seed.groupLabel,
          sortOrder: i,
          isDefault: true,
        ),
      );
    }

    await _repository.insertAll(categories);
    return true;
  }
}