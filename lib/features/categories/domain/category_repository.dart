import 'finance_category.dart';

abstract class CategoryRepository {
  /// Categorías no archivadas, ordenadas por `sortOrder` y luego por nombre.
  Stream<List<FinanceCategory>> watchActive();

  /// Cantidad total de categorías (incluye archivadas).
  Future<int> count();

  Future<void> insertAll(List<FinanceCategory> categories);
}