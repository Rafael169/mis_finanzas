/// Un mes de un año (por ejemplo, agosto de 2026).
/// Se usa para elegir qué período se está viendo.
class YearMonth implements Comparable<YearMonth> {
  const YearMonth(this.year, this.month)
      : assert(month >= 1 && month <= 12, 'El mes debe estar entre 1 y 12');

  factory YearMonth.fromDate(DateTime date) =>
      YearMonth(date.year, date.month);

  factory YearMonth.now() => YearMonth.fromDate(DateTime.now());

  final int year;
  final int month;

  YearMonth get previous =>
      month == 1 ? YearMonth(year - 1, 12) : YearMonth(year, month - 1);

  YearMonth get next =>
      month == 12 ? YearMonth(year + 1, 1) : YearMonth(year, month + 1);

  DateTime get firstDay => DateTime(year, month, 1);
  DateTime get lastDay => DateTime(year, month + 1, 0);

  @override
  int compareTo(YearMonth other) =>
      (year * 12 + month).compareTo(other.year * 12 + other.month);

  @override
  bool operator ==(Object other) =>
      other is YearMonth && other.year == year && other.month == month;

  @override
  int get hashCode => Object.hash(year, month);

  @override
  String toString() => 'YearMonth($year-$month)';
}