import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/domain/money.dart';
import '../../../core/widgets/simple_pie_chart.dart';
import '../../budgets/domain/budget_status.dart';
import '../../budgets/presentation/budget_providers.dart';
import '../../categories/presentation/category_visuals.dart';
import '../../periods/presentation/month_selector.dart';
import '../../periods/presentation/period_providers.dart';
import '../../settings/presentation/settings_providers.dart';
import '../../transactions/domain/movement_item.dart';
import 'home_providers.dart';

/// Pestaña Inicio: balance del mes, donas, progreso del gasto y hormiga.
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(periodSummaryProvider);
    final budgets = ref.watch(monthBudgetsProvider);
    final format = ref.watch(moneyFormatterProvider);
    final alertPercent =
        ref.watch(userSettingsProvider).value?.defaultAlertPercent ?? 80;
    final recent = ref.watch(recentMovementsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Inicio')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
        children: [
          const MonthSelector(),
          const SizedBox(height: 8),
          summary.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Text('Error: $error'),
            data: (s) => Column(
              children: [
                _BalanceCard(balance: s.balance, format: format),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _MetricCard(
                        label: 'Ingresos',
                        value: format(s.income),
                        color: context.appColors.income,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _MetricCard(
                        label: 'Gastos',
                        value: format(s.expense),
                        color: context.appColors.expense,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _IncomeBreakdownCard(
                  income: s.income,
                  extraIncome: s.extraIncome,
                  format: format,
                ),
                const SizedBox(height: 12),
                budgets.when(
                  loading: () => const SizedBox.shrink(),
                  error: (_, _) => const SizedBox.shrink(),
                  data: (all) => _ExpenseBreakdownCard(budgets: all, format: format),
                ),
                const SizedBox(height: 12),
                budgets.when(
                  loading: () => const SizedBox.shrink(),
                  error: (_, _) => const SizedBox.shrink(),
                  data: (all) => _ExpenseProgressCard(
                    budgets: all,
                    expense: s.expense,
                    alertPercent: alertPercent,
                    format: format,
                  ),
                ),
                const SizedBox(height: 12),
                _AntExpenseCard(
                  antExpense: s.antExpense,
                  expense: s.expense,
                  format: format,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text('Últimos movimientos', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          if (recent.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Center(child: Text('Aún no hay movimientos este mes.')),
            )
          else
            Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  for (final item in recent)
                    _RecentTile(item: item, format: format),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _BalanceCard extends StatelessWidget {
  const _BalanceCard({required this.balance, required this.format});

  final Money balance;
  final String Function(Money) format;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = balance.isNegative
        ? context.appColors.expense
        : context.appColors.income;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text('Balance del mes', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              format(balance),
              style: theme.textTheme.displaySmall?.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.label, required this.value, required this.color});

  final String label;
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
            Text(label, style: theme.textTheme.bodySmall),
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

class _IncomeBreakdownCard extends StatelessWidget {
  const _IncomeBreakdownCard({
    required this.income,
    required this.extraIncome,
    required this.format,
  });

  final Money income;
  final Money extraIncome;
  final String Function(Money) format;

  @override
  Widget build(BuildContext context) {
    final fixed = income - extraIncome;
    final colors = context.appColors;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ingresos del mes', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            SimplePieChart(
              slices: [
                PieSlice(
                  value: fixed.minorUnits.toDouble(),
                  color: colors.income,
                  label: 'Fijos · ${format(fixed)}',
                ),
                PieSlice(
                  value: extraIncome.minorUnits.toDouble(),
                  color: colors.warning,
                  label: 'Adicionales · ${format(extraIncome)}',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ExpenseBreakdownCard extends StatelessWidget {
  const _ExpenseBreakdownCard({required this.budgets, required this.format});

  final List<dynamic> budgets; // List<CategoryBudget>
  final String Function(Money) format;

  static const _palette = [
    Color(0xFF1E6FD9),
    Color(0xFFD64545),
    Color(0xFFF2A900),
    Color(0xFF2E9E5B),
    Color(0xFF8E5CF7),
    Color(0xFF00A6A6),
  ];

  @override
  Widget build(BuildContext context) {
    final expenses = budgets
        .where((b) => !b.category.isIncome && b.actualMonth.minorUnits > 0)
        .toList()
      ..sort(
        (a, b) => b.actualMonth.minorUnits.compareTo(a.actualMonth.minorUnits),
      );

    final top = expenses.take(5).toList();
    final restTotal = expenses
        .skip(5)
        .fold<Money>(Money.zero, (sum, b) => sum + b.actualMonth);

    final slices = [
      for (var i = 0; i < top.length; i++)
        PieSlice(
          value: top[i].actualMonth.minorUnits.toDouble(),
          color: _palette[i % _palette.length],
          label: '${top[i].category.name} · ${format(top[i].actualMonth)}',
        ),
      if (!restTotal.isZero)
        PieSlice(
          value: restTotal.minorUnits.toDouble(),
          color: Theme.of(context).colorScheme.outline,
          label: 'Otros · ${format(restTotal)}',
        ),
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Gastos por categoría', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            SimplePieChart(slices: slices),
          ],
        ),
      ),
    );
  }
}

class _ExpenseProgressCard extends StatelessWidget {
  const _ExpenseProgressCard({
    required this.budgets,
    required this.expense,
    required this.alertPercent,
    required this.format,
  });

  final List<dynamic> budgets; // List<CategoryBudget>
  final Money expense;
  final int alertPercent;
  final String Function(Money) format;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final totalLimit = budgets
        .where((b) => !b.category.isIncome)
        .fold<Money>(Money.zero, (sum, b) => sum + (b.monthLimit ?? Money.zero));

    final status = budgetStatus(
      isIncome: false,
      actual: expense,
      limit: totalLimit.isZero ? null : totalLimit,
      alertPercent: alertPercent,
    );

    final color = switch (status) {
      BudgetStatus.over => context.appColors.expense,
      BudgetStatus.warning => context.appColors.warning,
      _ => context.appColors.income,
    };

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Progreso del gasto', style: theme.textTheme.titleMedium),
            const SizedBox(height: 12),
            if (totalLimit.isZero)
              const Text('Aún no has asignado presupuestos este mes.')
            else ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: (expense.ratioTo(totalLimit) ?? 0)
                      .clamp(0.0, 1.0)
                      .toDouble(),
                  minHeight: 10,
                  color: color,
                  backgroundColor: color.withValues(alpha: 0.18),
                ),
              ),
              const SizedBox(height: 8),
              Text('${format(expense)} de ${format(totalLimit)}'),
            ],
          ],
        ),
      ),
    );
  }
}

class _AntExpenseCard extends StatelessWidget {
  const _AntExpenseCard({
    required this.antExpense,
    required this.expense,
    required this.format,
  });

  final Money antExpense;
  final Money expense;
  final String Function(Money) format;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final percent = expense.ratioTo(antExpense.isZero ? expense : expense);
    final ratio = expense.isZero ? null : antExpense.ratioTo(expense);

    return Card(
      color: context.appColors.warning.withValues(alpha: 0.12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: context.appColors.warning),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Gasto hormiga del mes', style: theme.textTheme.titleSmall),
                  Text(
                    ratio == null
                        ? format(antExpense)
                        : '${format(antExpense)} · ${(ratio * 100).round()} % del gasto',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecentTile extends StatelessWidget {
  const _RecentTile({required this.item, required this.format});

  final MovementItem item;
  final String Function(Money) format;

  @override
  Widget build(BuildContext context) {
    final color = categoryColor(item.categoryColorHex);
    final amountColor =
        item.isIncome ? context.appColors.income : context.appColors.expense;
    final sign = item.isIncome ? '+' : '-';

    return ListTile(
      onTap: () => context.push('/editar-movimiento/${item.id}'),
      leading: CircleAvatar(
        backgroundColor: color.withValues(alpha: 0.15),
        child: Icon(categoryIcon(item.categoryIconKey), color: color),
      ),
      title: Text(
        item.description.isEmpty ? item.categoryName : item.description,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(
        '$sign${format(item.amount)}',
        style: TextStyle(color: amountColor, fontWeight: FontWeight.w600),
      ),
    );
  }
}