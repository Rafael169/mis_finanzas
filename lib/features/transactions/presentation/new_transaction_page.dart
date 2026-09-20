import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Formulario de nuevo movimiento (se construye en la Fase 2).
class NewTransactionPage extends StatelessWidget {
  const NewTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo movimiento'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: const Center(child: Text('Formulario en construcción')),
    );
  }
}