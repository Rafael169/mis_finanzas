/// Monto de dinero.
///
/// Se guarda como entero con 2 decimales implícitos ("centavos"), sin
/// importar la moneda. Nunca se usa `double` para sumar o restar dinero.
class Money implements Comparable<Money> {
  /// Desde un valor ya en "centavos" (por ejemplo, el que viene de la base).
  const Money.fromMinor(this.minorUnits);

  /// Desde unidades enteras: 50000 pesos pasan a 5.000.000 "centavos".
  const Money.fromUnits(int units) : minorUnits = units * scale;

  static const int scale = 100;
  static const Money zero = Money.fromMinor(0);

  final int minorUnits;

  bool get isZero => minorUnits == 0;
  bool get isNegative => minorUnits < 0;

  Money operator +(Money other) =>
      Money.fromMinor(minorUnits + other.minorUnits);

  Money operator -(Money other) =>
      Money.fromMinor(minorUnits - other.minorUnits);

  Money operator -() => Money.fromMinor(-minorUnits);

  bool operator >(Money other) => minorUnits > other.minorUnits;
  bool operator <(Money other) => minorUnits < other.minorUnits;
  bool operator >=(Money other) => minorUnits >= other.minorUnits;
  bool operator <=(Money other) => minorUnits <= other.minorUnits;

  /// Proporción de este monto respecto a [limit] (0.5 = 50 %).
  /// Devuelve null si [limit] es cero, para no dividir por cero: la
  /// pantalla lo muestra como "Sin presupuesto".
  double? ratioTo(Money limit) {
    if (limit.isZero) return null;
    return minorUnits / limit.minorUnits;
  }

  static Money sum(Iterable<Money> values) =>
      values.fold(zero, (total, value) => total + value);

  @override
  int compareTo(Money other) => minorUnits.compareTo(other.minorUnits);

  @override
  bool operator ==(Object other) =>
      other is Money && other.minorUnits == minorUnits;

  @override
  int get hashCode => minorUnits.hashCode;

  @override
  String toString() => 'Money($minorUnits)';
}