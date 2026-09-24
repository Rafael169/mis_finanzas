import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/finance_category.dart';
import 'category_edit_sheet.dart';
import 'category_providers.dart';
import 'category_visuals.dart';

/// Pantalla de gestión de categorías, accesible desde Perfil.
class CategoriesPage extends ConsumerStatefulWidget {
  const CategoriesPage({super.key});

  @override
  ConsumerState<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends ConsumerState<CategoriesPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _openEditor({FinanceCategory? editing}) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => CategoryEditSheet(
        editing: editing,
        isIncome: editing?.isIncome ?? _tabController.index == 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final all = ref.watch(allCategoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorías'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Gastos'),
            Tab(text: 'Ingresos'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openEditor(),
        child: const Icon(Icons.add),
      ),
      body: all.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (categories) {
          return TabBarView(
            controller: _tabController,
            children: [
              _CategoryList(
                categories: categories.where((c) => !c.isIncome).toList(),
                onTap: (c) => _openEditor(editing: c),
              ),
              _CategoryList(
                categories: categories.where((c) => c.isIncome).toList(),
                onTap: (c) => _openEditor(editing: c),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CategoryList extends ConsumerWidget {
  const _CategoryList({required this.categories, required this.onTap});

  final List<FinanceCategory> categories;
  final void Function(FinanceCategory) onTap;

  Future<void> _restore(
    BuildContext context,
    WidgetRef ref,
    FinanceCategory c,
  ) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref.read(archiveCategoryProvider)(c.id, archive: false);
    } catch (_) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text('No se pudo restaurar. Intenta de nuevo.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (categories.isEmpty) {
      return const Center(child: Text('Aún no hay categorías aquí.'));
    }

    final active = categories.where((c) => !c.isArchived).toList();
    final archived = categories.where((c) => c.isArchived).toList();

    return ListView(
      padding: const EdgeInsets.only(bottom: 96),
      children: [
        for (final c in active)
          ListTile(
            leading: CircleAvatar(
              backgroundColor: categoryColor(c.colorHex)
                  .withValues(alpha: 0.15),
              child: Icon(
                categoryIcon(c.iconKey),
                color: categoryColor(c.colorHex),
              ),
            ),
            title: Text(c.name),
            subtitle: Text(
              c.isIncome
                  ? (c.isFixed ? 'Ingreso fijo' : 'Ingreso esporádico')
                  : [
                      c.isFixed ? 'Gasto fijo' : 'Gasto variable',
                      if (c.isAntExpense) 'hormiga',
                    ].join(' · '),
            ),
            onTap: () => onTap(c),
          ),
        if (archived.isNotEmpty) ...[
          const Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Text(
              'Archivadas',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          for (final c in archived)
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context)
                    .colorScheme
                    .surfaceContainerHighest,
                child: Icon(
                  categoryIcon(c.iconKey),
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
              title: Text(
                c.name,
                style: TextStyle(color: Theme.of(context).colorScheme.outline),
              ),
              trailing: TextButton(
                onPressed: () => _restore(context, ref, c),
                child: const Text('Restaurar'),
              ),
            ),
        ],
      ],
    );
  }
}
