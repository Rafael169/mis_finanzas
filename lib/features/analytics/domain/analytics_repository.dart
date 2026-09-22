import 'category_year_total.dart';
import 'yearly_summary.dart';

abstract class AnalyticsRepository {
  /// Totales del año; se actualiza solo cuando cambian los datos.
  Stream<YearlySummary> watchYear(int year);

  /// Gasto total del año por categoría, de mayor a menor.
  Stream<List<CategoryYearTotal>> watchExpenseBreakdown(int year);
}