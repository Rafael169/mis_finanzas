/// Regla de cortes (quincenas):
/// - Corte 1: del día 1 al 15. Se paga el 15.
/// - Corte 2: del 16 al último día del mes. Se paga el 30 (o el último
///   día del mes, si el mes es más corto, como febrero).
///
/// Las fechas se manejan a nivel de día (a las 00:00).
class CutRule {
  CutRule._();

  static const int firstCutLastDay = 15;
  static const int secondCutPayDay = 30;

  /// Corte (1 o 2) al que pertenece una fecha.
  static int cutFor(DateTime date) => date.day <= firstCutLastDay ? 1 : 2;

  static int lastDayOfMonth(int year, int month) =>
      DateTime(year, month + 1, 0).day;

  /// Fecha de pago sugerida del corte, para prellenar el formulario.
  static DateTime paymentDate(int year, int month, int cut) {
    _checkCut(cut);
    if (cut == 1) return DateTime(year, month, firstCutLastDay);

    final last = lastDayOfMonth(year, month);
    return DateTime(year, month, last < secondCutPayDay ? last : secondCutPayDay);
  }

  /// Primer y último día del corte, ambos incluidos.
  static ({DateTime start, DateTime end}) rangeFor(
    int year,
    int month,
    int cut,
  ) {
    _checkCut(cut);
    if (cut == 1) {
      return (
        start: DateTime(year, month, 1),
        end: DateTime(year, month, firstCutLastDay),
      );
    }
    return (
      start: DateTime(year, month, firstCutLastDay + 1),
      end: DateTime(year, month, lastDayOfMonth(year, month)),
    );
  }

  static void _checkCut(int cut) {
    if (cut != 1 && cut != 2) {
      throw ArgumentError.value(cut, 'cut', 'Debe ser 1 o 2');
    }
  }
}