import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_provider.dart';
import '../data/drift_category_repository.dart';
import '../domain/category_repository.dart';
import '../domain/finance_category.dart';
import '../domain/seed_default_categories.dart';

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  return DriftCategoryRepository(ref.watch(appDatabaseProvider));
});

/// Categorías activas; se actualiza sola cuando cambian en la base de datos.
final categoriesProvider = StreamProvider<List<FinanceCategory>>((ref) {
  return ref.watch(categoryRepositoryProvider).watchActive();
});

final seedDefaultCategoriesProvider = Provider<SeedDefaultCategories>((ref) {
  return SeedDefaultCategories(ref.watch(categoryRepositoryProvider));
});