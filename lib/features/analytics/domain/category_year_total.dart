import '../../../core/domain/money.dart';
import '../../categories/domain/finance_category.dart';

/// Gasto total del año de una categoría.
class CategoryYearTotal {
  const CategoryYearTotal({required this.category, required this.actual});

  final FinanceCategory category;
  final Money actual;
}