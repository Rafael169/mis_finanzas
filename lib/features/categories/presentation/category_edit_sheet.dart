import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../domain/archive_category.dart';
import '../domain/finance_category.dart';
import '../domain/update_category.dart';
import 'category_icons.dart';
import 'category_providers.dart';
import 'category_visuals.dart';

/// Hoja para crear o editar una categoría.
class CategoryEditSheet extends ConsumerStatefulWidget {
  const CategoryEditSheet({super.key, this.editing, required this.isIncome});

  /// Si no es null, edita esta categoría en lugar de crear una nueva.
  final FinanceCategory? editing;
  final bool isIncome;

  @override
  ConsumerState<CategoryEditSheet> createState() => _CategoryEditSheetState();
}

class _CategoryEditSheetState extends ConsumerState<CategoryEditSheet> {
  final _nameController = TextEditingController();
  late bool _isFixed;
  late bool _isAnt;
  late String _iconKey;
  late String _colorHex;
  bool _saving = false;
  String? _error;

  bool get _isEditing => widget.editing != null;

  @override
  void initState() {
    super.initState();
    final editing = widget.editing;
    _nameController.text = editing?.name ?? '';
    _isFixed = editing?.isFixed ?? true;
    _isAnt = editing?.isAntExpense ?? false;
    _iconKey = editing?.iconKey ?? 'category';
    _colorHex = editing?.colorHex ?? selectableCategoryColors.first;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);

    setState(() {
      _saving = true;
      _error = null;
    });

    final category = FinanceCategory(
      id: widget.editing?.id ?? const Uuid().v4(),
      name: _nameController.text,
      isIncome: widget.isIncome,
      isFixed: _isFixed,
      isAntExpense: !widget.isIncome && !_isFixed && _isAnt,
      iconKey: _iconKey,
      colorHex: _colorHex,
      sortOrder: widget.editing?.sortOrder ?? 0,
      isDefault: widget.editing?.isDefault ?? false,
    );

    try {
      if (_isEditing) {
        await ref.read(updateCategoryProvider)(category);
      } else {
        await ref.read(addCategoryProvider)(category);
      }
      navigator.pop();
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            _isEditing ? 'Categoría actualizada' : 'Categoría creada',
          ),
        ),
      );
    } on CategoryException catch (e) {
      setState(() => _error = e.message);
    } catch (_) {
      setState(() => _error = 'No se pudo guardar. Intenta de nuevo.');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _archive() async {
    final editing = widget.editing;
    if (editing == null) return;

    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _saving = true);

    try {
      await ref.read(archiveCategoryProvider)(editing.id, archive: true);
      navigator.pop();
      messenger.showSnackBar(
        const SnackBar(content: Text('Categoría archivada')),
      );
    } on CategoryException catch (e) {
      setState(() {
        _saving = false;
        _error = e.message;
      });
    } catch (_) {
      setState(() {
        _saving = false;
        _error = 'No se pudo archivar. Intenta de nuevo.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
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
              _isEditing ? 'Editar categoría' : 'Nueva categoría',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              autofocus: !_isEditing,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            if (!widget.isIncome) ...[
              const SizedBox(height: 16),
              Text('Tipo', style: theme.textTheme.titleSmall),
              const SizedBox(height: 8),
              SegmentedButton<bool>(
                segments: const [
                  ButtonSegment(value: true, label: Text('Fijo')),
                  ButtonSegment(value: false, label: Text('Variable')),
                ],
                selected: {_isFixed},
                onSelectionChanged: (s) => setState(() => _isFixed = s.first),
              ),
              if (!_isFixed) ...[
                const SizedBox(height: 8),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Gasto hormiga'),
                  subtitle: const Text(
                    'Pequeño y frecuente (café, antojos, etc.)',
                  ),
                  value: _isAnt,
                  onChanged: (v) => setState(() => _isAnt = v ?? false),
                ),
              ],
            ],
            const SizedBox(height: 16),
            Text('Icono', style: theme.textTheme.titleSmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final entry in selectableCategoryIcons.entries)
                  InkWell(
                    borderRadius: BorderRadius.circular(24),
                    onTap: () => setState(() => _iconKey = entry.key),
                    child: CircleAvatar(
                      radius: 22,
                      backgroundColor: _iconKey == entry.key
                          ? categoryColor(_colorHex).withValues(alpha: 0.3)
                          : theme.colorScheme.surfaceContainerHighest,
                      child: Icon(entry.value),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Color', style: theme.textTheme.titleSmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final hex in selectableCategoryColors)
                  InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () => setState(() => _colorHex = hex),
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: categoryColor(hex),
                      child: _colorHex == hex
                          ? const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 18,
                            )
                          : null,
                    ),
                  ),
              ],
            ),
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
                if (_isEditing)
                  TextButton(
                    onPressed: _saving ? null : _archive,
                    child: const Text('Archivar'),
                  ),
                const Spacer(),
                FilledButton(
                  onPressed: _saving ? null : _submit,
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
