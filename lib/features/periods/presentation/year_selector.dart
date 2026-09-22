import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'selected_year_provider.dart';

/// Selector de año con flechas. Tocar el número vuelve al año actual.
class YearSelector extends ConsumerWidget {
  const YearSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final year = ref.watch(selectedYearProvider);
    final notifier = ref.read(selectedYearProvider.notifier);

    return Row(
      children: [
        IconButton(
          tooltip: 'Año anterior',
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
                '$year',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
        ),
        IconButton(
          tooltip: 'Año siguiente',
          onPressed: notifier.next,
          icon: const Icon(Icons.chevron_right),
        ),
      ],
    );
  }
}