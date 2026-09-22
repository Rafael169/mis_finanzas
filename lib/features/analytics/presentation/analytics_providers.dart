import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_provider.dart';
import '../../periods/presentation/selected_year_provider.dart';
import '../data/drift_analytics_repository.dart';
import '../domain/analytics_repository.dart';
import '../domain/category_year_total.dart';
import '../domain/yearly_summary.dart';

final analyticsRepositoryProvider = Provider<AnalyticsRepository>((ref) {
  return DriftAnalyticsRepository(ref.watch(appDatabaseProvider));
});

final yearlySummaryProvider = StreamProvider<YearlySummary>((ref) {
  final year = ref.watch(selectedYearProvider);
  return ref.watch(analyticsRepositoryProvider).watchYear(year);
});

final expenseBreakdownProvider =
    StreamProvider<List<CategoryYearTotal>>((ref) {
  final year = ref.watch(selectedYearProvider);
  return ref.watch(analyticsRepositoryProvider).watchExpenseBreakdown(year);
});