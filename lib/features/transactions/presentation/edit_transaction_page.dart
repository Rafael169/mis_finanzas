import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'movement_query_providers.dart';
import 'new_transaction_page.dart';

/// Carga un movimiento por id y abre el formulario en modo edición.
class EditTransactionPage extends ConsumerWidget {
  const EditTransactionPage({super.key, required this.movementId});

  final String movementId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movement = ref.watch(movementByIdProvider(movementId));

    return movement.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Scaffold(
        appBar: AppBar(title: const Text('Editar movimiento')),
        body: Center(child: Text('Error: $error')),
      ),
      data: (item) {
        if (item == null) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Editar movimiento'),
              leading: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => context.pop(),
              ),
            ),
            body: const Center(child: Text('Este movimiento ya no existe.')),
          );
        }
        return NewTransactionPage(editing: item);
      },
    );
  }
}