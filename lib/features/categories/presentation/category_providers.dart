import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_provider.dart';
import '../data/drift_category_repository.dart';
import '../domain/archive_category.dart';
import '../domain/category_repository.dart';
import '../domain/finance_category.dart';
import '../domain/seed_default_categories.dart';
import '../domain/update_category.dart';

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  return DriftCategoryRepository(ref.watch(appDatabaseProvider));
});

/// Categorías activas; se actualiza sola cuando cambian en la base de datos.
final categoriesProvider = StreamProvider<List<FinanceCategory>>((ref) {
  return ref.watch(categoryRepositoryProvider).watchActive();
});

/// Todas las categorías, incluidas las archivadas (para la pantalla de Perfil).
final allCategoriesProvider = StreamProvider<List<FinanceCategory>>((ref) {
  return ref.watch(categoryRepositoryProvider).watchAll();
});

final seedDefaultCategoriesProvider = Provider<SeedDefaultCategories>((ref) {
  return SeedDefaultCategories(ref.watch(categoryRepositoryProvider));
});

final addCategoryProvider = Provider<AddCategory>((ref) {
  return AddCategory(ref.watch(categoryRepositoryProvider));
});

final updateCategoryProvider = Provider<UpdateCategory>((ref) {
  return UpdateCategory(ref.watch(categoryRepositoryProvider));
});

final archiveCategoryProvider = Provider<ArchiveCategory>((ref) {
  return ArchiveCategory(ref.watch(categoryRepositoryProvider));
});
