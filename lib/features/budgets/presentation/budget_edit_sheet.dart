import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/domain/money.dart';
import '../../../core/domain/year_month.dart';
import '../../../core/utils/money_input.dart';
import '../../../core/utils/money_parser.dart';
import '../../settings/presentation/settings_providers.dart';
import '../domain/category_budget.dart';
import '../domain/save_budget.dart';
import 'budget_providers.dart';

/// Hoja para asignar, cambiar o quitar el presupuesto de una categoría.
class BudgetEditSheet extends ConsumerStatefulWidget {
  const BudgetEditSheet({super.key, required this.budget, required this.month});

  final CategoryBudget budget;
  final YearMonth month;

  @override
  ConsumerState<BudgetEditSheet> createState() => _BudgetEditSheetState();
}

class _BudgetEditSheetState extends ConsumerState<BudgetEditSheet> {
  final _monthly = TextEditingController();
  final _cut1 = TextEditingController();
  final _cut2 = TextEditingController();

  late bool _perCut;
  String? _error;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final budget = widget.budget;
    final currency = ref.read(currencyProvider);

    _perCut = budget.mode == BudgetMode.perCut;

    String? text(Money? value) =>
        value == null ? null : formatMoneyForInput(value, currency);

    _monthly.text = text(budget.monthlyLimit) ?? '';
    _cut1.text = text(budget.cut1Limit) ?? '';
    _cut2.text = text(budget.cut2Limit) ?? '';
  }

  @override
  void dispose() {
    _monthly.dispose();
    _cut1.dispose();
    _cut2.dispose();
    super.dispose();
  }

  /// null si el campo está vacío; lanza si el texto no es un monto válido.
  Money? _read(TextEditingController controller) {
    final text = controller.text.trim();
    if (text.isEmpty) return null;

    final parsed = parseMoneyInput(text, ref.read(currencyProvider));
    if (parsed == null) throw const BudgetException('Escribe un monto válido.');
    return parsed;
  }

  Future<void> _submit({required bool remove}) async {
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    setState(() {
      _saving = true;
      _error = null;
    });

    try {
      await ref.read(saveBudgetProvider)(
        month: widget.month,
        category: widget.budget.category,
        monthly: remove || _perCut ? null : _read(_monthly),
        cut1: remove || !_perCut ? null : _read(_cut1),
        cut2: remove || !_perCut ? null : _read(_cut2),
      );
      navigator.pop();
      messenger.showSnackBar(
        SnackBar(
          content: Text(remove ? 'Presupuesto quitado' : 'Presupuesto guardado'),
        ),
      );
    } on BudgetException catch (e) {
      if (mounted) setState(() => _error = e.message);
    } catch (_) {
      if (mounted) {
        setState(() => _error = 'No se pudo guardar. Intenta de nuevo.');
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Widget _field(
    TextEditingController controller,
    String label, {
    bool autofocus = false,
  }) {
    final currency = ref.watch(currencyProvider);
    return TextField(
      controller: controller,
      autofocus: autofocus,
      keyboardType: TextInputType.numberWithOptions(
        decimal: currency.displayDecimals > 0,
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          currency.displayDecimals > 0
              ? RegExp(r'[0-9.,]')
              : RegExp(r'[0-9]'),
        ),
      ],
      decoration: InputDecoration(
        labelText: label,
        prefixText: '${currency.symbol} ',
        hintText: '0',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final rawMonth =
        DateFormat('MMMM yyyy', 'es_CO').format(widget.month.firstDay);
    final monthLabel = toBeginningOfSentenceCase(rawMonth);
    final hasBudget = widget.budget.mode != BudgetMode.none;

    return Padding(
      // El espacio del teclado empuja la hoja hacia arriba.
      padding: EdgeInsets.fromLTRB(
        20,
        0,
        20,
        20 + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Presupuesto de ${widget.budget.category.name}',
              style: theme.textTheme.titleLarge,
            ),
            Text(monthLabel, style: theme.textTheme.bodyMedium),
            const SizedBox(height: 16),
            SegmentedButton<bool>(
              segments: const [
                ButtonSegment(value: false, label: Text('Todo el mes')),
                ButtonSegment(value: true, label: Text('Por corte')),
              ],
              selected: {_perCut},
              onSelectionChanged: _saving
                  ? null
                  : (selection) => setState(() {
                        _perCut = selection.first;
                        _error = null;
                      }),
            ),
            const SizedBox(height: 16),
            if (!_perCut)
              _field(_monthly, 'Monto del mes', autofocus: true)
            else ...[
              _field(_cut1, 'Corte 1 (del 1 al 15)', autofocus: true),
              const SizedBox(height: 12),
              _field(_cut2, 'Corte 2 (del 16 al fin de mes)'),
            ],
            if (_error != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  _error!,
                  style: TextStyle(color: theme.colorScheme.error),
                ),
              ),
            const SizedBox(height: 20),
            Row(
              children: [
                if (hasBudget)
                  TextButton(
                    onPressed: _saving ? null : () => _submit(remove: true),
                    child: const Text('Quitar presupuesto'),
                  ),
                const Spacer(),
                FilledButton(
                  onPressed: _saving ? null : () => _submit(remove: false),
                  child: const Text('Guardar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}