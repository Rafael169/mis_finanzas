import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/domain/money.dart';
import '../../categories/presentation/category_visuals.dart';
import '../../periods/presentation/month_selector.dart';
import '../../periods/presentation/selected_period_provider.dart';
import '../../settings/presentation/settings_providers.dart';
import '../domain/budget_status.dart';
import '../domain/category_budget.dart';
import 'budget_edit_sheet.dart';
import 'budget_providers.dart';

/// Pestaña Presupuestos: Presupuesto vs Actual por categoría.
class BudgetsPage extends ConsumerStatefulWidget {
  const BudgetsPage({super.key});

  @override
  ConsumerState<BudgetsPage> createState() => _BudgetsPageState();
}

class _BudgetsPageState extends ConsumerState<BudgetsPage> {
  bool _isIncome = false;
  BudgetView _view = BudgetView.month;

  static String _viewLabel(BudgetView view) {
    switch (view) {
      case BudgetView.month:
        return 'Mes';
      case BudgetView.cut1:
        return 'Corte 1';
      case BudgetView.cut2:
        return 'Corte 2';
    }
  }

  Future<void> _copyFromPreviousMonth() async {
    final messenger = ScaffoldMessenger.of(context);
    final month = ref.read(selectedPeriodProvider);

    try {
      final copied =
          await ref.read(budgetRepositoryProvider).copyFromPreviousMonth(month);
      final text = switch (copied) {
        0 => 'No hay presupuestos nuevos para copiar del mes anterior.',
        1 => 'Se copió 1 presupuesto del mes anterior.',
        _ => 'Se copiaron $copied presupuestos del mes anterior.',
      };
      messenger.showSnackBar(SnackBar(content: Text(text)));
    } catch (_) {
      messenger.showSnackBar(
        const SnackBar(content: Text('No se pudo copiar. Intenta de nuevo.')),
      );
    }
  }

  void _edit(CategoryBudget budget) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => BudgetEditSheet(
        budget: budget,
        month: ref.read(selectedPeriodProvider),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final budgets = ref.watch(monthBudgetsProvider);
    final format = ref.watch(moneyFormatterProvider);
    final alertPercent =
        ref.watch(userSettingsProvider).value?.defaultAlertPercent ?? 80;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Presupuestos'),
        actions: [
          PopupMenuButton<String>(
            tooltip: 'Más opciones',
            onSelected: (_) => _copyFromPreviousMonth(),
            itemBuilder: (_) => const [
              PopupMenuItem(
                value: 'copy',
                child: Text('Copiar del mes anterior'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          const MonthSelector(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: SegmentedButton<bool>(
              segments: const [
                ButtonSegment(value: false, label: Text('Gastos')),
                ButtonSegment(value: true, label: Text('Ingresos')),
              ],
              selected: {_isIncome},
              onSelectionChanged: (selection) =>
                  setState(() => _isIncome = selection.first),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: SizedBox(
              width: double.infinity,
              child: Wrap(
                spacing: 8,
                children: [
                  for (final view in BudgetView.values)
                    ChoiceChip(
                      label: Text(_viewLabel(view)),
                      selected: _view == view,
                      onSelected: (_) => setState(() => _view = view),
                    ),
                ],
              ),
            ),
          ),
          Expanded(
            child: budgets.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text('Error: $error')),
              data: (all) {
                final lines = [
                  for (final b in all)
                    if (b.category.isIncome == _isIncome)
                      b.lineFor(_view, alertPercent: alertPercent),
                ];
                final totals = totalsOfLines(lines);
                final totalsStatus = budgetStatus(
                  isIncome: _isIncome,
                  actual: totals.actual,
                  limit: totals.hasBudget ? totals.limit : null,
                  alertPercent: alertPercent,
                );

                return ListView(
                  // Espacio abajo para que el botón "+" no tape la última fila.
                  padding: const EdgeInsets.only(bottom: 96),
                  children: [
                    _SummaryCard(
                      totals: totals,
                      status: totalsStatus,
                      isIncome: _isIncome,
                      view: _view,
                      format: format,
                    ),
                    for (final line in lines)
                      _BudgetTile(
                        line: line,
                        format: format,
                        onTap: () => _edit(line.budget),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Color de cada estado. El porcentaje y los textos de cada fila acompañan
/// al color, para no depender solo de él.
Color _statusColor(BuildContext context, BudgetStatus status) {
  final colors = context.appColors;
  final scheme = Theme.of(context).colorScheme;

  switch (status) {
    case BudgetStatus.ok:
    case BudgetStatus.reached:
      return colors.income;
    case BudgetStatus.warning:
      return colors.warning;
    case BudgetStatus.over:
      return colors.expense;
    case BudgetStatus.pending:
      return scheme.primary;
    case BudgetStatus.none:
      return scheme.outline;
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.totals,
    required this.status,
    required this.isIncome,
    required this.view,
    required this.format,
  });

  final BudgetTotals totals;
  final BudgetStatus status;
  final bool isIncome;
  final BudgetView view;
  final String Function(Money) format;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = _statusColor(context, status);

    final scope = switch (view) {
      BudgetView.month => 'del mes',
      BudgetView.cut1 => 'del Corte 1',
      BudgetView.cut2 => 'del Corte 2',
    };

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${isIncome ? 'Ingresos' : 'Gastos'} $scope',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            if (!totals.hasBudget)
              Text(
                'Aún no hay presupuesto en esta vista. Toca una categoría '
                'para asignarle un monto.',
                style: theme.textTheme.bodyMedium,
              )
            else ...[
              Text(
                '${format(totals.actual)} de ${format(totals.limit)}',
                style: theme.textTheme.headlineSmall,
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: (totals.ratio ?? 0).clamp(0.0, 1.0).toDouble(),
                  minHeight: 8,
                  color: color,
                  backgroundColor: color.withValues(alpha: 0.18),
                ),
              ),
            ],
            if (!totals.unbudgeted.isZero) ...[
              const SizedBox(height: 8),
              Text(
                'Sin presupuesto: ${format(totals.unbudgeted)}',
                style: theme.textTheme.bodySmall,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _BudgetTile extends StatelessWidget {
  const _BudgetTile({
    required this.line,
    required this.format,
    required this.onTap,
  });

  final BudgetLine line;
  final String Function(Money) format;
  final VoidCallback onTap;

  String _caption() {
    final ratio = line.ratio;
    final limit = line.limit;

    if (ratio == null || limit == null) {
      final monthly = line.budget.monthlyLimit;
      if (line.view != BudgetView.month && monthly != null) {
        return 'Límite del mes: ${format(monthly)} (sin límite por corte)';
      }
      return 'Sin presupuesto · Toca para asignar';
    }

    final percent = (ratio * 100).round();
    final remaining = line.remaining ?? Money.zero;

    switch (line.status) {
      case BudgetStatus.over:
        return 'Superado por ${format(-remaining)} · $percent %';
      case BudgetStatus.reached:
        return 'Alcanzado · $percent %';
      case BudgetStatus.pending:
        return 'Faltan ${format(remaining)} · $percent %';
      case BudgetStatus.ok:
      case BudgetStatus.warning:
      case BudgetStatus.none:
        return 'Disponible ${format(remaining)} · $percent %';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final category = line.category;
    final color = categoryColor(category.colorHex);
    final statusColor = _statusColor(context, line.status);
    final ratio = line.ratio;
    final limit = line.limit;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: color.withValues(alpha: 0.15),
                    child: Icon(categoryIcon(category.iconKey), color: color),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      category.name,
                      style: theme.textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    limit == null
                        ? format(line.actual)
                        : '${format(line.actual)} / ${format(limit)}',
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
              if (ratio != null) ...[
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: ratio.clamp(0.0, 1.0).toDouble(),
                    minHeight: 8,
                    color: statusColor,
                    backgroundColor: statusColor.withValues(alpha: 0.18),
                  ),
                ),
              ],
              const SizedBox(height: 8),
              Text(
                _caption(),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: line.status == BudgetStatus.over ? statusColor : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}