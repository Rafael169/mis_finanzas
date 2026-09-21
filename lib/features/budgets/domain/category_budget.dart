import '../../../core/domain/money.dart';
import '../../categories/domain/finance_category.dart';
import 'budget_status.dart';

/// Cómo está definido el presupuesto de una categoría en un mes.
enum BudgetMode { none, monthly, perCut }

/// Vista de la pantalla: todo el mes o un corte.
enum BudgetView {
  month(0),
  cut1(1),
  cut2(2);

  const BudgetView(this.cutNumber);

  /// Número de corte tal como se guarda en la base (0 = todo el mes).
  final int cutNumber;
}

/// Presupuesto y real de una categoría en un mes.
class CategoryBudget {
  const CategoryBudget({
    required this.category,
    this.monthlyLimit,
    this.cut1Limit,
    this.cut2Limit,
    this.actualCut1 = Money.zero,
    this.actualCut2 = Money.zero,
  });

  final FinanceCategory category;

  /// Límite para todo el mes. Excluye a los límites por corte.
  final Money? monthlyLimit;
  final Money? cut1Limit;
  final Money? cut2Limit;
  final Money actualCut1;
  final Money actualCut2;

  BudgetMode get mode {
    if (monthlyLimit != null) return BudgetMode.monthly;
    if (cut1Limit != null || cut2Limit != null) return BudgetMode.perCut;
    return BudgetMode.none;
  }

  Money get actualMonth => actualCut1 + actualCut2;

  /// Límite del mes completo: el mensual, o la suma de los cortes.
  Money? get monthLimit {
    switch (mode) {
      case BudgetMode.none:
        return null;
      case BudgetMode.monthly:
        return monthlyLimit;
      case BudgetMode.perCut:
        return (cut1Limit ?? Money.zero) + (cut2Limit ?? Money.zero);
    }
  }

  /// Límite que aplica a una vista. Un presupuesto mensual no tiene límite
  /// por corte, y un corte sin límite queda sin presupuesto.
  Money? limitFor(BudgetView view) {
    switch (view) {
      case BudgetView.month:
        return monthLimit;
      case BudgetView.cut1:
        return mode == BudgetMode.perCut ? cut1Limit : null;
      case BudgetView.cut2:
        return mode == BudgetMode.perCut ? cut2Limit : null;
    }
  }

  Money actualFor(BudgetView view) {
    switch (view) {
      case BudgetView.month:
        return actualMonth;
      case BudgetView.cut1:
        return actualCut1;
      case BudgetView.cut2:
        return actualCut2;
    }
  }

  BudgetLine lineFor(BudgetView view, {int alertPercent = 80}) {
    final limit = limitFor(view);
    final actual = actualFor(view);
    return BudgetLine(
      budget: this,
      view: view,
      limit: limit,
      actual: actual,
      status: budgetStatus(
        isIncome: category.isIncome,
        actual: actual,
        limit: limit,
        alertPercent: alertPercent,
      ),
    );
  }
}

/// Una fila de la pantalla: una categoría en una vista concreta.
class BudgetLine {
  const BudgetLine({
    required this.budget,
    required this.view,
    required this.limit,
    required this.actual,
    required this.status,
  });

  final CategoryBudget budget;
  final BudgetView view;
  final Money? limit;
  final Money actual;
  final BudgetStatus status;

  FinanceCategory get category => budget.category;
  bool get hasLimit => limit != null;

  /// Proporción usada (1.0 = 100 %); null si no hay límite.
  double? get ratio {
    final limit = this.limit;
    return limit == null ? null : actual.ratioTo(limit);
  }

  /// Lo que queda (negativo si se superó); null si no hay límite.
  Money? get remaining {
    final limit = this.limit;
    return limit == null ? null : limit - actual;
  }
}

/// Totales de una lista de filas.
class BudgetTotals {
  const BudgetTotals({
    required this.limit,
    required this.actual,
    required this.unbudgeted,
  });

  /// Suma de los límites.
  final Money limit;

  /// Real de las categorías que sí tienen límite.
  final Money actual;

  /// Real de las categorías sin límite.
  final Money unbudgeted;

  bool get hasBudget => !limit.isZero;
  double? get ratio => actual.ratioTo(limit);
}

BudgetTotals totalsOfLines(List<BudgetLine> lines) {
  var limit = Money.zero;
  var actual = Money.zero;
  var unbudgeted = Money.zero;

  for (final line in lines) {
    final lineLimit = line.limit;
    if (lineLimit == null) {
      unbudgeted += line.actual;
    } else {
      limit += lineLimit;
      actual += line.actual;
    }
  }
  return BudgetTotals(limit: limit, actual: actual, unbudgeted: unbudgeted);
}