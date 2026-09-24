import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../backup/domain/import_backup.dart';
import '../../backup/presentation/backup_providers.dart';
import '../domain/app_theme_mode.dart';
import '../domain/user_settings.dart';
import 'settings_providers.dart';

/// Pestaña Perfil.
class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  bool _working = false;

  Future<void> _export() async {
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _working = true);

    try {
      final csv = await ref.read(exportBackupProvider)();
      final dir = await getTemporaryDirectory();
      final now = DateTime.now();
      final fileName =
          'mis_finanzas_${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}.csv';
      final file = File('${dir.path}/$fileName');
      await file.writeAsString(csv);

      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path)],
          text: 'Respaldo de Mis Finanzas',
        ),
      );
    } catch (_) {
      messenger.showSnackBar(
        const SnackBar(content: Text('No se pudo exportar. Intenta de nuevo.')),
      );
    } finally {
      if (mounted) setState(() => _working = false);
    }
  }

  Future<void> _import() async {
    final messenger = ScaffoldMessenger.of(context);

    final picked = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );
    if (picked.isEmpty) return;
    final path = picked.single.path;
    if (path == null) return;

    setState(() => _working = true);
    try {
      final content = await File(path).readAsString();
      final result = await ref.read(importBackupProvider)(content);

      messenger.showSnackBar(
        SnackBar(
          content: Text(
            'Importados: ${result.imported}'
            '${result.skipped > 0 ? ' · Omitidos: ${result.skipped}' : ''}',
          ),
        ),
      );
    } on BackupFormatException {
      messenger.showSnackBar(
        const SnackBar(
          content: Text('El archivo no tiene el formato esperado.'),
        ),
      );
    } catch (_) {
      messenger.showSnackBar(
        const SnackBar(content: Text('No se pudo importar. Intenta de nuevo.')),
      );
    } finally {
      if (mounted) setState(() => _working = false);
    }
  }

  @override
  Widget build(BuildContext context) {
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
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.category_outlined),
                  title: const Text('Categorías'),
                  subtitle: const Text('Crear, editar y archivar'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push('/categorias'),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.upload_outlined),
                  title: const Text('Exportar respaldo'),
                  subtitle: const Text('Guarda tus movimientos como CSV'),
                  trailing: _working
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.chevron_right),
                  onTap: _working ? null : _export,
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.download_outlined),
                  title: const Text('Importar respaldo'),
                  subtitle: const Text('Desde un archivo CSV'),
                  trailing: _working
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.chevron_right),
                  onTap: _working ? null : _import,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
