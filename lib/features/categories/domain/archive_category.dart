import 'category_repository.dart';
import 'update_category.dart';

/// Archiva o restaura una categoría. No se puede archivar una categoría
/// que sigue en uso en el mes actual (presupuesto o movimientos).
class ArchiveCategory {
  ArchiveCategory(this._repository);

  final CategoryRepository _repository;

  Future<void> call(String categoryId, {required bool archive}) async {
    if (archive && await _repository.isInUseThisMonth(categoryId)) {
      throw const CategoryException(
        'Esta categoría tiene presupuesto o movimientos este mes. '
        'Quítalos antes de archivarla.',
      );
    }
    await _repository.setArchived(categoryId, archive);
  }
}
