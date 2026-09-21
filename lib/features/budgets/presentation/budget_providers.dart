import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_provider.dart';
import '../../periods/presentation/selected_period_provider.dart';
import '../data/drift_budget_repository.dart';
import '../domain/budget_repository.dart';
import '../domain/category_budget.dart';
import '../domain/save_budget.dart';

final budgetRepositoryProvider = Provider<BudgetRepository>((ref) {
  return DriftBudgetRepository(ref.watch(appDatabaseProvider));
});

final saveBudgetProvider = Provider<SaveBudget>((ref) {
  return SaveBudget(ref.watch(budgetRepositoryProvider));
});

/// Presupuesto y real del mes elegido en el selector; se actualiza solo.
final monthBudgetsProvider = StreamProvider<List<CategoryBudget>>((ref) {
  final month = ref.watch(selectedPeriodProvider);
  return ref.watch(budgetRepositoryProvider).watchMonth(month);
});