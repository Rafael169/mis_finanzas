import 'package:uuid/uuid.dart';

import 'category_repository.dart';
import 'default_categories.dart';
import 'finance_category.dart';

/// Activa una categoría sugerida del catálogo extendido, creándola con
/// los mismos datos predefinidos (icono, color, grupo).
class AddSuggestedCategory {
  AddSuggestedCategory(this._repository, {Uuid? uuid})
      : _uuid = uuid ?? const Uuid();

  final CategoryRepository _repository;
  final Uuid _uuid;

  Future<void> call(CategorySeed seed) async {
    await _repository.add(
      FinanceCategory(
        id: _uuid.v4(),
        name: seed.name,
        isIncome: seed.isIncome,
        isFixed: seed.isFixed,
        isAntExpense: seed.isAntExpense,
        iconKey: seed.iconKey,
        colorHex: seed.colorHex,
        groupLabel: seed.groupLabel,
        isDefault: true,
      ),
    );
  }
}