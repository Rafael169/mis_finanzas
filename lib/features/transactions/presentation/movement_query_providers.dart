import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_provider.dart';
import '../../periods/presentation/selected_period_provider.dart';
import '../data/drift_movement_reader.dart';
import '../domain/movement_filter.dart';
import '../domain/movement_item.dart';
import '../domain/movement_reader.dart';

final movementReaderProvider = Provider<MovementReader>((ref) {
  return DriftMovementReader(ref.watch(appDatabaseProvider));
});

/// Movimientos del mes elegido en el selector; se actualiza solo.
final monthMovementsProvider = StreamProvider<List<MovementItem>>((ref) {
  final month = ref.watch(selectedPeriodProvider);
  return ref.watch(movementReaderProvider).watchMonth(month);
});

class MovementFilterNotifier extends Notifier<MovementFilter> {
  @override
  MovementFilter build() => const MovementFilter();

  void setType(MovementTypeFilter value) => state = state.withType(value);
  void setCut(int? value) => state = state.withCut(value);
  void setCategory(String? value) => state = state.withCategory(value);
  void clear() => state = const MovementFilter();
}

final movementFilterProvider =
    NotifierProvider<MovementFilterNotifier, MovementFilter>(
  MovementFilterNotifier.new,
);

/// Movimientos del mes con los filtros ya aplicados.
final filteredMovementsProvider =
    Provider<AsyncValue<List<MovementItem>>>((ref) {
  final filter = ref.watch(movementFilterProvider);
  return ref.watch(monthMovementsProvider).whenData(filter.apply);
});