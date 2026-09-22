import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../transactions/presentation/movement_query_providers.dart';

/// Los 5 movimientos más recientes del mes elegido.
final recentMovementsProvider = Provider((ref) {
  final movements = ref.watch(monthMovementsProvider).value ?? const [];
  return movements.take(5).toList();
});