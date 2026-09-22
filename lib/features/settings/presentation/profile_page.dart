import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../domain/app_theme_mode.dart';
import '../domain/user_settings.dart';
import 'settings_providers.dart';

/// Pestaña Perfil.
class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final settings =
        ref.watch(userSettingsProvider).value ?? UserSettings.defaults;
    final currency = settings.currency;

    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Apariencia', style: theme.textTheme.titleMedium),
          const SizedBox(height: 12),
          SegmentedButton<AppThemeMode>(
            segments: [
              for (final mode in AppThemeMode.values)
                ButtonSegment(value: mode, label: Text(mode.label)),
            ],
            selected: {settings.themeMode},
            onSelectionChanged: (selection) => ref
                .read(settingsRepositoryProvider)
                .save(settings.copyWith(themeMode: selection.first)),
          ),
          const SizedBox(height: 8),
          Text(
            'Sistema (por defecto) sigue el modo claro u oscuro de tu teléfono.',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: 32),
          Text('Moneda', style: theme.textTheme.titleMedium),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.payments_outlined),
            title: Text(currency.name),
            subtitle: Text(currency.code),
          ),
          const SizedBox(height: 24),
          Text('Datos', style: theme.textTheme.titleMedium),
          Card(
            child: ListTile(
              leading: const Icon(Icons.category_outlined),
              title: const Text('Categorías'),
              subtitle: const Text('Crear, editar y archivar'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/categorias'),
            ),
          ),
        ],
      ),
    );
  }
}
