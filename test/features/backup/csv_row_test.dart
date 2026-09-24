import 'package:flutter_test/flutter_test.dart';
import 'package:mis_finanzas/core/domain/money.dart';
import 'package:mis_finanzas/features/backup/domain/csv_row.dart';

void main() {
  test('toCsvFields produce fecha AAAA-MM-DD y monto en unidades enteras', () {
    final row = BackupRow(
      date: DateTime(2026, 8, 5),
      isIncome: false,
      categoryName: 'Mecatos',
      amount: const Money.fromUnits(50000),
      cutNumber: 1,
      description: 'Empanadas',
    );

    expect(row.toCsvFields(), [
      '2026-08-05',
      'gasto',
      'Mecatos',
      '50000',
      '1',
      'Empanadas',
    ]);
  });

  test('fromCsvFields interpreta una fila válida', () {
    final row = BackupRow.fromCsvFields([
      '2026-08-05',
      'ingreso',
      'Salario',
      '2025041',
      '1',
      '',
    ]);

    expect(row, isNotNull);
    expect(row!.date, DateTime(2026, 8, 5));
    expect(row.isIncome, isTrue);
    expect(row.categoryName, 'Salario');
    expect(row.amount, const Money.fromUnits(2025041));
    expect(row.cutNumber, 1);
  });

  test('un viaje de ida y vuelta conserva los datos', () {
    final original = BackupRow(
      date: DateTime(2026, 12, 31),
      isIncome: true,
      categoryName: 'Ingresos adicionales',
      amount: const Money.fromUnits(300000),
      cutNumber: 2,
    );

    final roundTrip = BackupRow.fromCsvFields(original.toCsvFields());

    expect(roundTrip!.date, original.date);
    expect(roundTrip.isIncome, original.isIncome);
    expect(roundTrip.categoryName, original.categoryName);
    expect(roundTrip.amount, original.amount);
  });

  test('rechaza filas con datos inválidos', () {
    expect(
      BackupRow.fromCsvFields(['no-es-fecha', 'gasto', 'X', '100', '1']),
      isNull,
    );
    expect(
      BackupRow.fromCsvFields(['2026-08-05', 'raro', 'X', '100', '1']),
      isNull,
    );
    expect(
      BackupRow.fromCsvFields(['2026-08-05', 'gasto', '', '100', '1']),
      isNull,
    );
    expect(
      BackupRow.fromCsvFields(['2026-08-05', 'gasto', 'X', '0', '1']),
      isNull,
    );
    expect(
      BackupRow.fromCsvFields(['2026-08-05', 'gasto', 'X', '100', '3']),
      isNull,
    );
  });
}
