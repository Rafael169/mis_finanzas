import 'category_repository.dart';
import 'finance_category.dart';

/// Error de validación con un mensaje que se puede mostrar al usuario.
class CategoryException implements Exception {
  const CategoryException(this.message);

  final String message;

  @override
  String toString() => message;
}

FinanceCategory _validated(FinanceCategory category) {
  final name = category.name.trim();
  if (name.isEmpty) {
    throw const CategoryException('El nombre no puede estar vacío.');
  }
  if (name.length > 40) {
    throw const CategoryException('El nombre es demasiado largo.');
  }
  // Solo un gasto variable puede ser hormiga (misma regla del modelo).
  if (category.isAntExpense && (category.isIncome || category.isFixed)) {
    throw const CategoryException(
      'Solo un gasto variable puede marcarse como hormiga.',
    );
  }
  return FinanceCategory(
    id: category.id,
    name: name,
    isIncome: category.isIncome,
    isFixed: category.isFixed,
    isAntExpense: category.isAntExpense,
    iconKey: category.iconKey,
    colorHex: category.colorHex,
    sortOrder: category.sortOrder,
    isArchived: category.isArchived,
    isDefault: category.isDefault,
  );
}

/// Crea una categoría nueva.
class AddCategory {
  AddCategory(this._repository);

  final CategoryRepository _repository;

  Future<void> call(FinanceCategory category) async {
    await _repository.add(_validated(category));
  }
}

/// Edita una categoría existente.
class UpdateCategory {
  UpdateCategory(this._repository);

  final CategoryRepository _repository;

  Future<void> call(FinanceCategory category) async {
    await _repository.update(_validated(category));
  }
}
