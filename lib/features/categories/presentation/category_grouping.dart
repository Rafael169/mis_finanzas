import '../domain/category_groups.dart';
import '../domain/finance_category.dart';

/// Agrupa categorías por su grupo, en el orden de [categoryGroups]. Un
/// grupo que no está en esa lista aparece al final.
Map<String, List<FinanceCategory>> groupCategoriesByLabel(
  List<FinanceCategory> categories,
) {
  final byGroup = <String, List<FinanceCategory>>{};
  for (final c in categories) {
    (byGroup[c.groupLabel] ??= []).add(c);
  }

  final ordered = <String, List<FinanceCategory>>{};
  for (final g in categoryGroups) {
    if (byGroup.containsKey(g)) ordered[g] = byGroup[g]!;
  }
  for (final entry in byGroup.entries) {
    ordered.putIfAbsent(entry.key, () => entry.value);
  }
  return ordered;
}