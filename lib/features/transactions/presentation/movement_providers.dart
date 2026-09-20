import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_provider.dart';
import '../data/drift_movement_repository.dart';
import '../domain/movement_repository.dart';
import '../domain/register_movement.dart';

final movementRepositoryProvider = Provider<MovementRepository>((ref) {
  return DriftMovementRepository(ref.watch(appDatabaseProvider));
});

final registerMovementProvider = Provider<RegisterMovement>((ref) {
  return RegisterMovement(ref.watch(movementRepositoryProvider));
});