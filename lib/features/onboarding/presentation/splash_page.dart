import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../settings/presentation/settings_providers.dart';

/// Pantalla breve mientras se leen los ajustes al abrir la app.
class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(userSettingsProvider);

    return Scaffold(
      body: Center(
        child: settings.hasError
            ? Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'No se pudo abrir la base de datos.\n${settings.error}',
                  textAlign: TextAlign.center,
                ),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}