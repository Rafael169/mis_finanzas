import '../../../core/domain/money.dart';
import '../../../core/domain/year_month.dart';
import 'category_budget.dart';

abstract class BudgetRepository {
  /// Presupuesto y real de cada categoría activa en un mes. Emite de nuevo
  /// cada vez que cambian los datos.
  Stream<List<CategoryBudget>> watchMonth(YearMonth month);

  /// Reemplaza los límites de una categoría en un mes. La clave de [limits]
  /// es el número de corte: 0 = todo el mes, 1 y 2 = cada corte.
  /// Un mapa vacío quita el presupuesto.
  Future<void> replaceLimits({
    required YearMonth month,
    required String categoryId,
    required Map<int, Money> limits,
  });

  /// Copia los presupuestos del mes anterior a las categorías que aún no
  /// tienen presupuesto en [month]. Devuelve cuántas categorías se copiaron.
  Future<int> copyFromPreviousMonth(YearMonth month);
}