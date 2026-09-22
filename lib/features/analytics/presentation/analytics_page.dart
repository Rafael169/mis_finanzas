import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/money.dart';
import '../../../core/widgets/simple_bar_chart.dart';
import '../../categories/presentation/category_visuals.dart';
import '../../periods/presentation/year_selector.dart';
import '../../settings/presentation/settings_providers.dart';
import '../domain/category_year_total.dart';
import 'analytics_providers.dart';

/// Pestaña Análisis: totales del año, balance mes a mes y gasto por
/// categoría.
class AnalyticsPage extends ConsumerStatefulWidget {
  const AnalyticsPage({super.key});

  @override
  ConsumerState<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends ConsumerState<AnalyticsPage> {
  bool _showAllCategories = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final summary = ref.watch(yearlySummaryProvider);
    final breakdown = ref.watch(expenseBreakdownProvider);
    final format = ref.watch(moneyFormatterProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Análisis')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
        children: [
          const YearSelector(),
          const SizedBox(height: 8),
          summary.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Text('Error: $error'),
            data: (s) {
              if (s.totalIncome.isZero && s.totalExpense.isZero) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Center(
                    child: Text(
                      'Aún no hay datos para ${s.year}.',
                      style: theme.textTheme.bodyLarge,
                    ),
                  ),
                );
              }
              return Column(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Total año', style: theme.textTheme.titleMedium),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Ingresos', style: theme.textTheme.bodySmall),
                                    Text(
                                      format(s.totalIncome),
                                      style: theme.textTheme.titleMedium,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Gastos', style: theme.textTheme.bodySmall),
                                    Text(
                                      format(s.totalExpense),
                                      style: theme.textTheme.titleMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 24),
                          Text('Balance', style: theme.textTheme.bodySmall),
                          Text(format(s.balance), style: theme.textTheme.headlineSmall),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Balance mes a mes', style: theme.textTheme.titleMedium),
                          const SizedBox(height: 16),
                          MonthlyBalanceChart(
                            values: [
                              for (final m in s.monthlyBalances) m.minorUnits.toDouble(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 12),
          breakdown.when(
            loading: () => const SizedBox.shrink(),
            error: (_, _) => const SizedBox.shrink(),
            data: (all) {
              if (all.isEmpty) return const SizedBox.shrink();
              final visible = _showAllCategories ? all : all.take(8).toList();
              final maxAmount = all.first.actual.minorUnits.toDouble();

              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Gastos por categoría', style: theme.textTheme.titleMedium),
                      const SizedBox(height: 12),
                      for (final item in visible)
                        _CategoryBar(item: item, maxAmount: maxAmount, format: format),
                      if (all.length > 8)
                        TextButton(
                          onPressed: () => setState(
                            () => _showAllCategories = !_showAllCategories,
                          ),
                          child: Text(_showAllCategories ? 'Ver menos' : 'Ver todas'),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CategoryBar extends StatelessWidget {
  const _CategoryBar({
    required this.item,
    required this.maxAmount,
    required this.format,
  });

  final CategoryYearTotal item;
  final double maxAmount;
  final String Function(Money) format;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = categoryColor(item.category.colorHex);
    final ratio = maxAmount == 0 ? 0.0 : item.actual.minorUnits / maxAmount;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(categoryIcon(item.category.iconKey), size: 16, color: color),
              const SizedBox(width: 8),
              Expanded(
                child: Text(item.category.name, style: theme.textTheme.bodyMedium),
              ),
              Text(format(item.actual), style: theme.textTheme.bodyMedium),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: LinearProgressIndicator(
              value: ratio.clamp(0.0, 1.0),
              minHeight: 6,
              color: color,
              backgroundColor: color.withValues(alpha: 0.15),
            ),
          ),
        ],
      ),
    );
  }
}