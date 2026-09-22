import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Año elegido en la pestaña Análisis.
class SelectedYearNotifier extends Notifier<int> {
  @override
  int build() => DateTime.now().year;

  void previous() => state = state - 1;
  void next() => state = state + 1;
  void reset() => state = DateTime.now().year;
}

final selectedYearProvider = NotifierProvider<SelectedYearNotifier, int>(
  SelectedYearNotifier.new,
);