import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/domain/cut_rule.dart';
import '../../../core/domain/money.dart';
import '../../categories/domain/finance_category.dart';
import '../../categories/presentation/category_providers.dart';
import '../../categories/presentation/category_visuals.dart';
import '../../periods/presentation/month_selector.dart';
import '../../settings/presentation/settings_providers.dart';
import '../domain/movement_filter.dart';
import '../domain/movement_grouping.dart';
import '../domain/movement_item.dart';
import 'movement_providers.dart';
import 'movement_query_providers.dart';

/// Pestaña Movimientos: historial del mes con filtros.
class MovementsPage extends ConsumerWidget {
  const MovementsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movements = ref.watch(filteredMovementsProvider);
    final monthHasData =
        ref.watch(monthMovementsProvider).value?.isNotEmpty ?? false;
    final filter = ref.watch(movementFilterProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Movimientos')),
      body: Column(
        children: [
          const MonthSelector(),
          const _Filters(),
          Expanded(
            child: movements.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text('Error: $error')),
              data: (items) {
                if (items.isEmpty) {
                  return _EmptyState(filtered: monthHasData && filter.isActive);
                }
                return _MovementList(items: items);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Filters extends ConsumerWidget {
  const _Filters();

  Future<void> _pickCategory(BuildContext context, WidgetRef ref) async {
    final filter = ref.read(movementFilterProvider);
    final all = ref.read(categoriesProvider).value ?? const <FinanceCategory>[];
    final options = all.where((c) {
      switch (filter.type) {
        case MovementTypeFilter.all:
          return true;
        case MovementTypeFilter.income:
          return c.isIncome;
        case MovementTypeFilter.expense:
          return !c.isIncome;
      }
    }).toList();

    final chosen = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (sheetContext) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            for (final c in options)
              ListTile(
                leading: Icon(
                  categoryIcon(c.iconKey),
                  color: categoryColor(c.colorHex),
                ),
                title: Text(c.name),
                selected: c.id == filter.categoryId,
                onTap: () => Navigator.of(sheetContext).pop(c.id),
              ),
          ],
        ),
      ),
    );

    if (chosen != null) {
      ref.read(movementFilterProvider.notifier).setCategory(chosen);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(movementFilterProvider);
    final notifier = ref.read(movementFilterProvider.notifier);
    final categories = ref.watch(categoriesProvider).value ?? const [];
    final selectedCategory = categories
        .where((c) => c.id == filter.categoryId)
        .firstOrNull;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SegmentedButton<MovementTypeFilter>(
            segments: const [
              ButtonSegment(
                value: MovementTypeFilter.all,
                label: Text('Todos'),
              ),
              ButtonSegment(
                value: MovementTypeFilter.expense,
                label: Text('Gastos'),
              ),
              ButtonSegment(
                value: MovementTypeFilter.income,
                label: Text('Ingresos'),
              ),
            ],
            selected: {filter.type},
            onSelectionChanged: (selection) =>
                notifier.setType(selection.first),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              ChoiceChip(
                label: const Text('Ambos cortes'),
                selected: filter.cut == null,
                onSelected: (_) => notifier.setCut(null),
              ),
              ChoiceChip(
                label: const Text('Corte 1'),
                selected: filter.cut == 1,
                onSelected: (_) => notifier.setCut(1),
              ),
              ChoiceChip(
                label: const Text('Corte 2'),
                selected: filter.cut == 2,
                onSelected: (_) => notifier.setCut(2),
              ),
              if (selectedCategory != null)
                InputChip(
                  avatar: Icon(
                    categoryIcon(selectedCategory.iconKey),
                    size: 18,
                  ),
                  label: Text(selectedCategory.name),
                  onPressed: () => _pickCategory(context, ref),
                  onDeleted: () => notifier.setCategory(null),
                )
              else
                ActionChip(
                  avatar: const Icon(Icons.filter_list, size: 18),
                  label: const Text('Categoría'),
                  onPressed: () => _pickCategory(context, ref),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MovementList extends ConsumerWidget {
  const _MovementList({required this.items});

  final List<MovementItem> items;

  /// Elimina el movimiento (borrado lógico) y ofrece deshacer.
  Future<void> _delete(
    BuildContext context,
    WidgetRef ref,
    MovementItem item,
  ) async {
    // Se guardan antes del await: esta lista puede desaparecer al borrar
    // el último movimiento.
    final messenger = ScaffoldMessenger.of(context);
    final repository = ref.read(movementRepositoryProvider);

    try {
      await repository.softDelete(item.id);
    } catch (_) {
      messenger.showSnackBar(
        const SnackBar(content: Text('No se pudo eliminar. Intenta de nuevo.')),
      );
      return;
    }

    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: const Text('Movimiento eliminado'),
          action: SnackBarAction(
            label: 'Deshacer',
            onPressed: () => repository.restore(item.id),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final format = ref.watch(moneyFormatterProvider);
    final totals = totalsOf(items);
    final groups = groupByDay(items);

    return ListView(
      // Espacio abajo para que el botón "+" no tape el último movimiento.
      padding: const EdgeInsets.only(bottom: 96),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
          child: Row(
            children: [
              Expanded(
                child: _TotalCell(
                  label: 'Ingresos',
                  value: format(totals.income),
                  color: context.appColors.income,
                ),
              ),
              Expanded(
                child: _TotalCell(
                  label: 'Gastos',
                  value: format(totals.expense),
                  color: context.appColors.expense,
                ),
              ),
            ],
          ),
        ),
        for (final group in groups) ...[
          _DayHeader(group.date),
          for (final item in group.items)
            Dismissible(
              key: ValueKey(item.id),
              direction: DismissDirection.endToStart,
              background: const _DeleteBackground(),
              onDismissed: (_) => _delete(context, ref, item),
              child: _MovementTile(
                item: item,
                format: format,
                onTap: () => context.push('/editar-movimiento/${item.id}'),
              ),
            ),
        ],
      ],
    );
  }
}

class _DeleteBackground extends StatelessWidget {
  const _DeleteBackground();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      color: scheme.error,
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 24),
      child: Icon(Icons.delete_outline, color: scheme.onError),
    );
  }
}

class _TotalCell extends StatelessWidget {
  const _TotalCell({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.bodySmall),
        Text(value, style: theme.textTheme.titleMedium?.copyWith(color: color)),
      ],
    );
  }
}

class _DayHeader extends StatelessWidget {
  const _DayHeader(this.date);

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final raw = DateFormat("EEEE d 'de' MMMM", 'es_CO').format(date);
    final label = toBeginningOfSentenceCase(raw) ?? raw;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(
        '$label · Corte ${CutRule.cutFor(date)}',
        style: theme.textTheme.labelLarge?.copyWith(
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }
}

class _MovementTile extends StatelessWidget {
  const _MovementTile({
    required this.item,
    required this.format,
    required this.onTap,
  });

  final MovementItem item;
  final String Function(Money) format;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = categoryColor(item.categoryColorHex);
    final hasDescription = item.description.isNotEmpty;

    String? subtitle;
    if (hasDescription) {
      subtitle = item.isAntExpense
          ? '${item.categoryName} · Gasto hormiga'
          : item.categoryName;
    } else if (item.isAntExpense) {
      subtitle = 'Gasto hormiga';
    }

    final amountColor = item.isIncome ? context.appColors.income : context.appColors.expense;
    final sign = item.isIncome ? '+' : '-';

    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor: color.withValues(alpha: 0.15),
        child: Icon(categoryIcon(item.categoryIconKey), color: color),
      ),
      title: Text(
        hasDescription ? item.description : item.categoryName,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: subtitle == null ? null : Text(subtitle),
      trailing: Text(
        '$sign${format(item.amount)}',
        style: theme.textTheme.titleMedium?.copyWith(
          color: amountColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _EmptyState extends ConsumerWidget {
  const _EmptyState({required this.filtered});

  /// true si hay movimientos en el mes pero los filtros los ocultan todos.
  final bool filtered;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              filtered
                  ? Icons.filter_alt_off_outlined
                  : Icons.receipt_long_outlined,
              size: 56,
              color: theme.colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              filtered
                  ? 'Ningún movimiento coincide con los filtros.'
                  : 'Aún no hay movimientos en este mes.\n'
                        'Toca + para registrar el primero.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge,
            ),
            if (filtered)
              TextButton(
                onPressed: ref.read(movementFilterProvider.notifier).clear,
                child: const Text('Quitar filtros'),
              ),
          ],
        ),
      ),
    );
  }
}
