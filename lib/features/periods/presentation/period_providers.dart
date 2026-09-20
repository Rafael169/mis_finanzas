import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_provider.dart';
import '../data/drift_period_repository.dart';
import '../domain/period_repository.dart';
import 'selected_period_provider.dart';

final periodRepositoryProvider = Provider<PeriodRepository>((ref) {
  return DriftPeriodRepository(ref.watch(appDatabaseProvider));
});

/// Resumen del mes elegido en el selector; se actualiza solo.
final periodSummaryProvider = StreamProvider<PeriodSummary>((ref) {
  final month = ref.watch(selectedPeriodProvider);
  return ref.watch(periodRepositoryProvider).watchSummary(month);
});