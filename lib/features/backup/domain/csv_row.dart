import '../../../core/domain/money.dart';

/// Un movimiento tal como se escribe o se lee en el CSV.
class BackupRow {
  const BackupRow({
    required this.date,
    required this.isIncome,
    required this.categoryName,
    required this.amount,
    required this.cutNumber,
    this.description = '',
  });

  /// Solo la fecha (a las 00:00).
  final DateTime date;
  final bool isIncome;
  final String categoryName;
  final Money amount;
  final int cutNumber;
  final String description;

  static const header = [
    'fecha',
    'tipo',
    'categoria',
    'monto',
    'corte',
    'descripcion',
  ];

  List<String> toCsvFields() {
    final y = date.year.toString().padLeft(4, '0');
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return [
      '$y-$m-$d',
      isIncome ? 'ingreso' : 'gasto',
      categoryName,
      (amount.minorUnits ~/ Money.scale).toString(),
      cutNumber.toString(),
      description,
    ];
  }

  /// Interpreta una fila leída del CSV. Devuelve null si algo no es válido.
  static BackupRow? fromCsvFields(List<dynamic> fields) {
    if (fields.length < 5) return null;

    final dateText = fields[0].toString().trim();
    final dateParts = dateText.split('-');
    if (dateParts.length != 3) return null;
    final year = int.tryParse(dateParts[0]);
    final month = int.tryParse(dateParts[1]);
    final day = int.tryParse(dateParts[2]);
    if (year == null || month == null || day == null) return null;
    if (month < 1 || month > 12 || day < 1 || day > 31) return null;

    final typeText = fields[1].toString().trim().toLowerCase();
    if (typeText != 'gasto' && typeText != 'ingreso') return null;

    final categoryName = fields[2].toString().trim();
    if (categoryName.isEmpty) return null;

    final units = int.tryParse(fields[3].toString().trim());
    if (units == null || units <= 0) return null;

    final cutParsed = int.tryParse(fields[4].toString().trim());
    if (cutParsed != 1 && cutParsed != 2) return null;
    final cut = cutParsed!;

    final description = fields.length > 5 ? fields[5].toString() : '';

    return BackupRow(
      date: DateTime(year, month, day),
      isIncome: typeText == 'ingreso',
      categoryName: categoryName,
      amount: Money.fromUnits(units),
      cutNumber: cut,
      description: description,
    );
  }
}
