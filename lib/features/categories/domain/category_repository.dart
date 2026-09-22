import 'finance_category.dart';

abstract class CategoryRepository {
  /// Categorías no archivadas, ordenadas por `sortOrder` y luego por nombre.
  Stream<List<FinanceCategory>> watchActive();

  /// Todas las categorías (incluye archivadas), mismo orden que watchActive.
  Stream<List<FinanceCategory>> watchAll();

  /// Cantidad total de categorías (incluye archivadas).
  Future<int> count();

  Future<void> insertAll(List<FinanceCategory> categories);

  /// Crea una categoría nueva.
  Future<void> add(FinanceCategory category);

  /// Reemplaza los datos de una categoría existente.
  Future<void> update(FinanceCategory category);

  /// true si la categoría tiene presupuesto o movimientos en el mes actual.
  Future<bool> isInUseThisMonth(String categoryId);

  /// Marca o desmarca una categoría como archivada.
  Future<void> setArchived(String categoryId, bool archived);
}
