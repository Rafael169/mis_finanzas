import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';

/// 12 barras (balance mensual): verde si es positivo, rojo si es negativo.
/// Sin dependencias externas.
class MonthlyBalanceChart extends StatelessWidget {
  const MonthlyBalanceChart({super.key, required this.values, this.height = 140});

  /// 12 valores, índice 0 = enero.
  final List<double> values;
  final double height;

  static const _labels = [
    'E', 'F', 'M', 'A', 'M', 'J', 'J', 'A', 'S', 'O', 'N', 'D',
  ];

  @override
  Widget build(BuildContext context) {
    final maxAbs = values.fold<double>(1, (m, v) => v.abs() > m ? v.abs() : m);
    final colors = context.appColors;
    final barArea = height - 20;

    return SizedBox(
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (var i = 0; i < 12; i++)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: barArea,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: (values[i].abs() / maxAbs) * barArea,
                          decoration: BoxDecoration(
                            color:
                                values[i] < 0 ? colors.expense : colors.income,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(_labels[i], style: Theme.of(context).textTheme.labelSmall),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}