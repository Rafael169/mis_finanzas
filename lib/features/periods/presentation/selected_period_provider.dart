import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/year_month.dart';

/// Mes elegido en el selector. Lo comparten Inicio, Movimientos y
/// Presupuestos: cambiarlo en una pestaña lo cambia en todas.
class SelectedPeriodNotifier extends Notifier<YearMonth> {
  @override
  YearMonth build() => YearMonth.now();

  void previous() => state = state.previous;
  void next() => state = state.next;
  void select(YearMonth value) => state = value;
  void reset() => state = YearMonth.now();
}

final selectedPeriodProvider =
    NotifierProvider<SelectedPeriodNotifier, YearMonth>(
  SelectedPeriodNotifier.new,
);