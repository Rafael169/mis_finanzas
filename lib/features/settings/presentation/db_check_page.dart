import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/currency.dart';
import '../../../core/domain/money.dart';
import 'settings_providers.dart';

/// Pantalla TEMPORAL para verificar que la base de datos funciona en el
/// dispositivo. Se elimina cuando exista la pantalla real de Inicio.
class DbCheckPage extends ConsumerWidget {
  const DbCheckPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(userSettingsProvider);
    final format = ref.watch(moneyFormatterProvider);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Verificación de base de datos')),
      body: settings.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (data) => ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text(
              'Moneda guardada: ${data.currencyCode}',
              style: textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              format(const Money.fromUnits(1169841)),
              style: textTheme.displaySmall,
            ),
            const SizedBox(height: 24),
            const Text(
              'Cambia la moneda, cierra la app por completo y vuelve a '
              'abrirla. Debe recordar tu elección.',
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: [
                for (final currency in Currency.supported)
                  ChoiceChip(
                    label: Text(currency.code),
                    selected: data.currencyCode == currency.code,
                    onSelected: (_) => ref
                        .read(settingsRepositoryProvider)
                        .save(data.copyWith(currencyCode: currency.code)),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}