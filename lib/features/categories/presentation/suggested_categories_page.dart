import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/default_categories.dart';
import '../domain/category_groups.dart';
import 'category_providers.dart';
import 'category_visuals.dart';

/// Pantalla de categorías sugeridas: el resto del catálogo extendido,
/// disponibles para activar con un toque, sin tener que crearlas a mano.
class SuggestedCategoriesPage extends ConsumerStatefulWidget {
  const SuggestedCategoriesPage({super.key});

  @override
  ConsumerState<SuggestedCategoriesPage> createState() =>
      _SuggestedCategoriesPageState();
}

class _SuggestedCategoriesPageState
    extends ConsumerState<SuggestedCategoriesPage> {
  final Set<String> _justAdded = {};

  Future<void> _add(CategorySeed seed) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref.read(addSuggestedCategoryProvider)(seed);
      if (mounted) setState(() => _justAdded.add(seed.name));
      messenger.showSnackBar(SnackBar(content: Text('${seed.name} agregada')));
    } catch (_) {
      messenger.showSnackBar(
        const SnackBar(content: Text('No se pudo agregar. Intenta de nuevo.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final existingNamesAsync = ref.watch(allCategoriesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Categorías sugeridas')),
      body: existingNamesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (existing) {
          final existingNames = existing.map((c) => c.name).toSet();
          final available = suggestedCategorySeeds
              .where(
                (s) =>
                    !existingNames.contains(s.name) &&
                    !_justAdded.contains(s.name),
              )
              .toList();

          if (available.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: Text(
                  'Ya agregaste todas las categorías sugeridas.\n'
                  'Puedes crear las que falten desde Categorías.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge,
                ),
              ),
            );
          }

          final grouped = _groupSeeds(available);

          return ListView(
            padding: const EdgeInsets.only(bottom: 24),
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Activa las que necesites. Lo que no esté aquí lo puedes '
                  'crear a tu manera desde Categorías.',
                  style: theme.textTheme.bodySmall,
                ),
              ),
              for (final entry in grouped.entries) ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                  child: Text(
                    entry.key,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
                for (final seed in entry.value)
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: categoryColor(seed.colorHex)
                          .withValues(alpha: 0.15),
                      child: Icon(
                        categoryIcon(seed.iconKey),
                        color: categoryColor(seed.colorHex),
                      ),
                    ),
                    title: Text(seed.name),
                    trailing: IconButton(
                      icon: const Icon(Icons.add_circle_outline),
                      tooltip: 'Agregar',
                      onPressed: () => _add(seed),
                    ),
                    onTap: () => _add(seed),
                  ),
              ],
            ],
          );
        },
      ),
    );
  }

  Map<String, List<CategorySeed>> _groupSeeds(List<CategorySeed> seeds) {
    final byGroup = <String, List<CategorySeed>>{};
    for (final s in seeds) {
      (byGroup[s.groupLabel] ??= []).add(s);
    }
    final ordered = <String, List<CategorySeed>>{};
    for (final g in categoryGroups) {
      if (byGroup.containsKey(g)) ordered[g] = byGroup[g]!;
    }
    for (final entry in byGroup.entries) {
      ordered.putIfAbsent(entry.key, () => entry.value);
    }
    return ordered;
  }
}