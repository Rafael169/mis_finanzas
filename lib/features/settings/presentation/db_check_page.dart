import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../app/theme/app_colors.dart';
import '../../periods/presentation/period_providers.dart';
import '../../periods/presentation/selected_period_provider.dart';
import 'settings_providers.dart';

/// Inicio TEMPORAL: muestra el resumen del mes para comprobar que los
/// movimientos se guardan. Se reemplaza por la pantalla real de Inicio.
class DbCheckPage extends ConsumerWidget {
  const DbCheckPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final month = ref.watch(selectedPeriodProvider);
    final notifier = ref.read(selectedPeriodProvider.notifier);
    final summary = ref.watch(periodSummaryProvider);
    final format = ref.watch(moneyFormatterProvider);
    final currency = ref.watch(currencyProvider);

    final rawLabel = DateFormat('MMMM yyyy', 'es_CO').format(month.firstDay);
    final label = toBeginningOfSentenceCase(rawLabel) ?? rawLabel;

    return Scaffold(
      appBar: AppBar(title: const Text('Inicio (temporal)')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              IconButton(
                onPressed: notifier.previous,
                icon: const Icon(Icons.chevron_left),
              ),
              Expanded(
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleLarge,
                ),
              ),
              IconButton(
                onPressed: notifier.next,
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
          const SizedBox(height: 16),
          summary.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Text('Error: $error'),
            data: (s) => Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text('Balance del mes', style: theme.textTheme.titleMedium),
                        const SizedBox(height: 8),
                        Text(
                          format(s.balance),
                          style: theme.textTheme.displaySmall,
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: _SummaryCard(
                        title: 'Ingresos',
                        value: format(s.income),
                        color: AppColors.income,
                      ),
                    ),
                    Expanded(
                      child: _SummaryCard(
                        title: 'Gastos',
                        value: format(s.expense),
                        color: AppColors.expense,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _SummaryCard(
                        title: 'Ingresos adicionales',
                        value: format(s.extraIncome),
                        color: AppColors.income,
                      ),
                    ),
                    Expanded(
                      child: _SummaryCard(
                        title: 'Gasto hormiga',
                        value: format(s.antExpense),
                        color: AppColors.warning,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Moneda: ${currency.code} · ${currency.name}',
            style: theme.textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.title,
    required this.value,
    required this.color,
  });

  final String title;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: theme.textTheme.bodySmall),
            const SizedBox(height: 4),
            Text(
              value,
              style: theme.textTheme.titleMedium?.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}