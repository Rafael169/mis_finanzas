import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/domain/cut_rule.dart';
import '../../../core/domain/money.dart';
import '../../../core/utils/money_input.dart';
import '../../../core/utils/money_parser.dart';
import '../../budgets/domain/budget_alert.dart';
import '../../categories/domain/finance_category.dart';
import '../../categories/presentation/category_providers.dart';
import '../../categories/presentation/category_visuals.dart';
import '../../settings/presentation/settings_providers.dart';
import '../data/drift_movement_repository.dart';
import '../domain/movement_item.dart';
import '../domain/register_movement.dart';
import 'movement_providers.dart';

/// Formulario para registrar un ingreso o un gasto, o para editar uno.
///
/// Orden: Tipo -> Categoría (grilla de iconos) -> Monto -> Fecha ->
/// Descripción. Elegir la categoría primero evita tener que subir y bajar
/// la pantalla, porque el monto aparece justo debajo, ya con el teclado
/// enfocado.
class NewTransactionPage extends ConsumerStatefulWidget {
  const NewTransactionPage({super.key, this.editing});

  final MovementItem? editing;

  @override
  ConsumerState<NewTransactionPage> createState() => _NewTransactionPageState();
}

class _NewTransactionPageState extends ConsumerState<NewTransactionPage> {
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _amountFocus = FocusNode();

  bool _isIncome = false;
  String? _categoryId;
  late DateTime _date;
  bool _saving = false;
  String? _amountError;
  String? _categoryError;

  bool get _isEditing => widget.editing != null;

  static DateTime _dayOf(DateTime value) =>
      DateTime(value.year, value.month, value.day);

  @override
  void initState() {
    super.initState();
    final editing = widget.editing;
    if (editing == null) {
      _date = _dayOf(DateTime.now());
    } else {
      _isIncome = editing.isIncome;
      _categoryId = editing.categoryId;
      _date = _dayOf(editing.date);
      _descriptionController.text = editing.description;
      _amountController.text = formatMoneyForInput(
        editing.amount,
        ref.read(currencyProvider),
      );
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    _amountFocus.dispose();
    super.dispose();
  }

  void _selectCategory(String id) {
    setState(() {
      _categoryId = id;
      _categoryError = null;
    });
    // Tras elegir la categoría, el siguiente paso natural es el monto.
    _amountFocus.requestFocus();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime(now.year + 1, 12, 31),
    );
    if (picked != null && mounted) {
      setState(() => _date = _dayOf(picked));
    }
  }

  Future<bool> _save() async {
    final messenger = ScaffoldMessenger.of(context);
    final currency = ref.read(currencyProvider);
    final amount = parseMoneyInput(_amountController.text, currency);
    final categories =
        ref.read(categoriesProvider).value ?? const <FinanceCategory>[];
    final category = categories.where((c) => c.id == _categoryId).firstOrNull;

    if (amount == null || amount <= Money.zero || category == null) {
      setState(() {
        _amountError = (amount == null || amount <= Money.zero)
            ? 'Escribe un monto mayor a cero'
            : null;
        _categoryError = category == null ? 'Elige una categoría' : null;
      });
      return false;
    }

    setState(() => _saving = true);
    try {
      final editing = widget.editing;
      if (editing == null) {
        await ref.read(registerMovementProvider)(
          category: category,
          amount: amount,
          date: _date,
          description: _descriptionController.text,
        );
      } else {
        await ref.read(updateMovementProvider)(
          id: editing.id,
          category: category,
          amount: amount,
          date: _date,
          description: _descriptionController.text,
        );
      }
      _showAlertsIfAny();
      return true;
    } on MovementException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.message)));
      return false;
    } catch (_) {
      messenger.showSnackBar(
        const SnackBar(content: Text('No se pudo guardar. Intenta de nuevo.')),
      );
      return false;
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _showAlertsIfAny() {
    final repository = ref.read(movementRepositoryProvider);
    if (repository is! DriftMovementRepository) return;

    final alerts = repository.lastAlerts;
    if (alerts.isEmpty || !mounted) return;

    final messenger = ScaffoldMessenger.of(context);
    for (final alert in alerts) {
      final text = alert.level == AlertLevel.over
          ? '${alert.category.name}: superaste el presupuesto'
          : '${alert.category.name}: llegando al límite del presupuesto';
      messenger.showSnackBar(SnackBar(content: Text(text)));
    }
  }

  Future<void> _saveAndClose() async {
    final messenger = ScaffoldMessenger.of(context);
    if (!await _save()) return;
    messenger.showSnackBar(
      SnackBar(
        content: Text(_isEditing ? 'Cambios guardados' : 'Movimiento guardado'),
      ),
    );
    if (mounted) context.pop();
  }

  Future<void> _saveAndAddAnother() async {
    final messenger = ScaffoldMessenger.of(context);
    if (!await _save()) return;
    messenger.showSnackBar(const SnackBar(content: Text('Movimiento guardado')));
    if (!mounted) return;
    setState(() {
      _amountController.clear();
      _descriptionController.clear();
      _categoryId = null;
    });
  }

  Future<void> _delete() async {
    final editing = widget.editing;
    if (editing == null) return;

    final messenger = ScaffoldMessenger.of(context);
    final repository = ref.read(movementRepositoryProvider);

    try {
      await repository.softDelete(editing.id);
    } catch (_) {
      messenger.showSnackBar(
        const SnackBar(content: Text('No se pudo eliminar. Intenta de nuevo.')),
      );
      return;
    }

    if (mounted) context.pop();
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: const Text('Movimiento eliminado'),
          action: SnackBarAction(
            label: 'Deshacer',
            onPressed: () => repository.restore(editing.id),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currency = ref.watch(currencyProvider);
    final format = ref.watch(moneyFormatterProvider);
    final categories = ref.watch(categoriesProvider);

    final parsed = parseMoneyInput(_amountController.text, currency);
    final preview =
        (parsed != null && parsed > Money.zero) ? format(parsed) : null;

    final today = _dayOf(DateTime.now());
    final yesterday = DateTime(today.year, today.month, today.day - 1);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar movimiento' : 'Nuevo movimiento'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
        actions: [
          if (_isEditing)
            IconButton(
              tooltip: 'Eliminar',
              icon: const Icon(Icons.delete_outline),
              onPressed: _saving ? null : _delete,
            ),
          _SaveAppBarAction(saving: _saving, onSave: _saveAndClose),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(20),
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    children: [
                      SegmentedButton<bool>(
                        segments: const [
                          ButtonSegment(
                            value: false,
                            label: Text('Gasto'),
                            icon: Icon(Icons.arrow_upward),
                          ),
                          ButtonSegment(
                            value: true,
                            label: Text('Ingreso'),
                            icon: Icon(Icons.arrow_downward),
                          ),
                        ],
                        selected: {_isIncome},
                        onSelectionChanged: (selection) => setState(() {
                          _isIncome = selection.first;
                          _categoryId = null;
                          _categoryError = null;
                        }),
                      ),
                      const SizedBox(height: 20),
                      Text('Categoría', style: theme.textTheme.titleMedium),
                      const SizedBox(height: 8),
                      categories.when(
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (_, _) => const Text(
                          'No se pudieron cargar las categorías.',
                        ),
                        data: (all) {
                          final options = all
                              .where((c) => c.isIncome == _isIncome)
                              .toList();
                          return Wrap(
                            spacing: 12,
                            runSpacing: 16,
                            children: [
                              for (final c in options)
                                _CategoryIconButton(
                                  category: c,
                                  selected: _categoryId == c.id,
                                  onTap: _saving
                                      ? null
                                      : () => _selectCategory(c.id),
                                ),
                            ],
                          );
                        },
                      ),
                      if (_categoryError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            _categoryError!,
                            style: TextStyle(color: theme.colorScheme.error),
                          ),
                        ),
                      const SizedBox(height: 24),
                      TextField(
                        controller: _amountController,
                        focusNode: _amountFocus,
                        textInputAction: TextInputAction.done,
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
                        style: theme.textTheme.headlineMedium,
                        decoration: InputDecoration(
                          labelText: 'Monto',
                          prefixText: '${currency.symbol} ',
                          hintText: '0',
                          errorText: _amountError,
                          helperText: preview == null
                              ? null
                              : 'Se registrará como $preview',
                        ),
                        onChanged: (_) => setState(() => _amountError = null),
                      ),
                      const SizedBox(height: 20),
                      Text('Fecha', style: theme.textTheme.titleMedium),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: [
                          ChoiceChip(
                            label: const Text('Hoy'),
                            selected: _date == today,
                            onSelected: (_) => setState(() => _date = today),
                          ),
                          ChoiceChip(
                            label: const Text('Ayer'),
                            selected: _date == yesterday,
                            onSelected: (_) =>
                                setState(() => _date = yesterday),
                          ),
                          ActionChip(
                            avatar: const Icon(Icons.calendar_today, size: 16),
                            label: const Text('Otra fecha'),
                            onPressed: _pickDate,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${DateFormat.yMMMd('es_CO').format(_date)} · '
                        'Corte ${CutRule.cutFor(_date)}',
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _descriptionController,
                        textCapitalization: TextCapitalization.sentences,
                        maxLength: RegisterMovement.maxDescriptionLength,
                        decoration: const InputDecoration(
                          labelText: 'Descripción (opcional)',
                        ),
                      ),
                    ],
                  ),
                ),
                _BottomActions(
                  saving: _saving,
                  isEditing: _isEditing,
                  onSave: _saveAndClose,
                  onSaveAndAddAnother: _saveAndAddAnother,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Icono circular con el nombre debajo, como una categoría de billetera.
/// Al tocarla se resalta con el color de la categoría.
class _CategoryIconButton extends StatelessWidget {
  const _CategoryIconButton({
    required this.category,
    required this.selected,
    required this.onTap,
  });

  final FinanceCategory category;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = categoryColor(category.colorHex);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        width: 76,
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? color : color.withValues(alpha: 0.15),
                border: selected
                    ? Border.all(color: color, width: 2)
                    : null,
              ),
              child: Icon(
                categoryIcon(category.iconKey),
                color: selected ? Colors.white : color,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              category.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: selected ? FontWeight.w600 : null,
                color: selected ? theme.colorScheme.primary : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Botón "Guardar" de la barra superior, visible solo con el teclado
/// abierto. Es su propio widget para que solo él (y no todo el
/// formulario) se reconstruya en cada fotograma de la animación del
/// teclado.
class _SaveAppBarAction extends StatelessWidget {
  const _SaveAppBarAction({required this.saving, required this.onSave});

  final bool saving;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    final keyboardOpen = MediaQuery.viewInsetsOf(context).bottom > 0;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 150),
      transitionBuilder: (child, animation) =>
          FadeTransition(opacity: animation, child: child),
      child: keyboardOpen
          ? Padding(
              key: const ValueKey('save'),
              padding: const EdgeInsets.only(right: 8),
              child: FilledButton(
                onPressed: saving ? null : onSave,
                child: const Text('Guardar'),
              ),
            )
          : const SizedBox(key: ValueKey('empty')),
    );
  }
}

/// Botones "Guardar" y "Guardar y agregar otro" de abajo, ocultos con el
/// teclado abierto. Aislado en su propio widget por la misma razón que
/// [_SaveAppBarAction].
class _BottomActions extends StatelessWidget {
  const _BottomActions({
    required this.saving,
    required this.isEditing,
    required this.onSave,
    required this.onSaveAndAddAnother,
  });

  final bool saving;
  final bool isEditing;
  final VoidCallback onSave;
  final VoidCallback onSaveAndAddAnother;

  @override
  Widget build(BuildContext context) {
    final keyboardOpen = MediaQuery.viewInsetsOf(context).bottom > 0;

    return AnimatedSize(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOut,
      child: keyboardOpen
          ? const SizedBox.shrink()
          : Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: FilledButton(
                      onPressed: saving ? null : onSave,
                      child: saving
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(isEditing ? 'Guardar cambios' : 'Guardar'),
                    ),
                  ),
                  if (!isEditing) ...[
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: OutlinedButton(
                        onPressed: saving ? null : onSaveAndAddAnother,
                        child: const Text('Guardar y agregar otro'),
                      ),
                    ),
                  ],
                ],
              ),
            ),
    );
  }
}