import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'selected_period_provider.dart';

/// Selector de mes con flechas. Tocar el nombre vuelve al mes actual.
/// El mes elegido se comparte entre las pestañas.
class MonthSelector extends ConsumerWidget {
  const MonthSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final month = ref.watch(selectedPeriodProvider);
    final notifier = ref.read(selectedPeriodProvider.notifier);

    final raw = DateFormat('MMMM yyyy', 'es_CO').format(month.firstDay);
    final label = toBeginningOfSentenceCase(raw) ?? raw;

    return Row(
      children: [
        IconButton(
          tooltip: 'Mes anterior',
          onPressed: notifier.previous,
          icon: const Icon(Icons.chevron_left),
        ),
        Expanded(
          child: InkWell(
            onTap: notifier.reset,
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
        ),
        IconButton(
          tooltip: 'Mes siguiente',
          onPressed: notifier.next,
          icon: const Icon(Icons.chevron_right),
        ),
      ],
    );
  }
}