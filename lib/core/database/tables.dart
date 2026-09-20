import 'package:drift/drift.dart';

// Convenciones:
// - Los ids son UUID en texto.
// - Los montos son enteros en "centavos" (2 decimales implícitos).
// - Las fechas se guardan como DateTime.

/// Ajustes del usuario (una sola fila en el MVP).
@DataClassName('AppSettingsData')
class AppSettings extends Table {
  TextColumn get id => text().withLength(min: 1, max: 36)();
  TextColumn get displayName => text().nullable()();
  TextColumn get currencyCode => text().withDefault(const Constant('COP'))();
  TextColumn get locale => text().withDefault(const Constant('es_CO'))();
  IntColumn get defaultAlertPercent =>
      integer().withDefault(const Constant(80))();
  BoolColumn get notificationsEnabled =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get onboardingCompleted =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Mes de control (p. ej. agosto de 2026), con totales en caché.
@DataClassName('FinancialPeriod')
class FinancialPeriods extends Table {
  TextColumn get id => text().withLength(min: 36, max: 36)();
  IntColumn get year => integer()();
  IntColumn get month => integer()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime()();
  BoolColumn get isClosed => boolean().withDefault(const Constant(false))();
  DateTimeColumn get closedAt => dateTime().nullable()();

  // Totales en caché (se actualizan al registrar movimientos).
  IntColumn get incomeBudgetTotal =>
      integer().withDefault(const Constant(0))();
  IntColumn get incomeActualTotal =>
      integer().withDefault(const Constant(0))();
  IntColumn get extraIncomeActualTotal =>
      integer().withDefault(const Constant(0))();
  IntColumn get expenseBudgetTotal =>
      integer().withDefault(const Constant(0))();
  IntColumn get expenseActualTotal =>
      integer().withDefault(const Constant(0))();
  IntColumn get antExpenseActualTotal =>
      integer().withDefault(const Constant(0))();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
        {year, month},
      ];
}

/// Categorías de ingreso y de gasto.
@DataClassName('Category')
class Categories extends Table {
  TextColumn get id => text().withLength(min: 36, max: 36)();
  TextColumn get name => text().withLength(min: 1, max: 60)();
  BoolColumn get isIncome => boolean()();

  /// Gasto fijo/recurrente (true) o variable (false). En ingresos:
  /// recurrente (true) o esporádico (false).
  BoolColumn get isFixed => boolean().withDefault(const Constant(false))();

  /// Marca de gasto hormiga (solo gastos variables).
  BoolColumn get isAntExpense =>
      boolean().withDefault(const Constant(false))();

  TextColumn get iconKey => text().withDefault(const Constant('category'))();
  TextColumn get colorHex => text().withDefault(const Constant('#1E6FD9'))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Movimientos diarios (ingresos y gastos).
@DataClassName('FinancialTransaction')
@TableIndex(name: 'idx_transactions_period_date', columns: {#periodId, #date})
@TableIndex(
  name: 'idx_transactions_period_category',
  columns: {#periodId, #categoryId},
)
class FinancialTransactions extends Table {
  TextColumn get id => text().withLength(min: 36, max: 36)();
  TextColumn get periodId => text().references(FinancialPeriods, #id)();
  TextColumn get categoryId => text().references(Categories, #id)();

  /// Copia del tipo de la categoría, para consultas rápidas.
  BoolColumn get isIncome => boolean()();

  /// Monto positivo en "centavos".
  IntColumn get amount => integer()();
  DateTimeColumn get date => dateTime()();

  /// 1 = primera quincena (día 1 al 15), 2 = resto del mes.
  IntColumn get cutNumber => integer()();
  TextColumn get description => text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  /// Borrado lógico: si tiene fecha, el movimiento está eliminado.
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Presupuesto (límite en gastos, proyectado en ingresos) por categoría.
@DataClassName('BudgetItem')
class BudgetItems extends Table {
  TextColumn get id => text().withLength(min: 36, max: 36)();
  TextColumn get periodId => text().references(FinancialPeriods, #id)();
  TextColumn get categoryId => text().references(Categories, #id)();

  /// 0 = todo el mes, 1 = primera quincena, 2 = segunda.
  IntColumn get cutNumber => integer().withDefault(const Constant(0))();
  IntColumn get amountLimit => integer()();
  IntColumn get alertPercent => integer().nullable()();

  /// 0 = sin alerta, 1 = advertencia, 2 = superado.
  IntColumn get lastAlertLevel => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
        {periodId, categoryId, cutNumber},
      ];
}

/// Totales precalculados por categoría, corte y mes (caché para gráficos).
@DataClassName('CategoryPeriodTotal')
class CategoryPeriodTotals extends Table {
  TextColumn get periodId => text().references(FinancialPeriods, #id)();
  TextColumn get categoryId => text().references(Categories, #id)();
  IntColumn get cutNumber => integer()();
  IntColumn get actualTotal => integer().withDefault(const Constant(0))();
  IntColumn get txCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {periodId, categoryId, cutNumber};
}