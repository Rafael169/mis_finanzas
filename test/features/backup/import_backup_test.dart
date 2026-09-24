import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mis_finanzas/core/database/app_database.dart';
import 'package:mis_finanzas/features/backup/data/drift_backup_repository.dart';
import 'package:mis_finanzas/features/backup/domain/export_backup.dart';
import 'package:mis_finanzas/features/backup/domain/import_backup.dart';
import 'package:mis_finanzas/features/categories/data/drift_category_repository.dart';
import 'package:mis_finanzas/features/categories/domain/seed_default_categories.dart';

void main() {
  late AppDatabase db;
  late DriftBackupRepository backup;
  late ImportBackup import;
  late ExportBackup export;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    await SeedDefaultCategories(DriftCategoryRepository(db))();
    backup = DriftBackupRepository(db);
    import = ImportBackup(backup);
    export = ExportBackup(backup);
  });

  tearDown(() async {
    await db.close();
  });

  test('importa filas válidas con categorías existentes', () async {
    const csv =
        'fecha,tipo,categoria,monto,corte,descripcion\n'
        '2026-08-05,gasto,Mecatos,50000,1,Empanadas\n'
        '2026-08-15,ingreso,Salario,2025041,1,\n';

    final result = await import(csv);

    expect(result.imported, 2);
    expect(result.skipped, 0);
    expect(await db.select(db.financialTransactions).get(), hasLength(2));
  });

  test('omite filas con categoría inexistente', () async {
    const csv =
        'fecha,tipo,categoria,monto,corte,descripcion\n'
        '2026-08-05,gasto,CategoriaQueNoExiste,50000,1,\n'
        '2026-08-06,gasto,Mecatos,20000,1,\n';

    final result = await import(csv);

    expect(result.imported, 1);
    expect(result.skipped, 1);
  });

  test('omite filas mal formadas sin romper la importación', () async {
    const csv =
        'fecha,tipo,categoria,monto,corte,descripcion\n'
        'fecha-invalida,gasto,Mecatos,50000,1,\n'
        '2026-08-06,gasto,Mecatos,20000,1,\n';

    final result = await import(csv);

    expect(result.imported, 1);
    expect(result.skipped, 1);
  });

  test(
    'un archivo sin el encabezado esperado lanza BackupFormatException',
    () async {
      const csv = 'algo,distinto\n1,2\n';

      await expectLater(import(csv), throwsA(isA<BackupFormatException>()));
    },
  );

  test(
    'exportar e importar de vuelta reproduce los mismos movimientos',
    () async {
      const original =
          'fecha,tipo,categoria,monto,corte,descripcion\n'
          '2026-08-05,gasto,Mecatos,50000,1,Empanadas\n'
          '2026-08-20,ingreso,Salario,2025041,2,\n';

      await import(original);
      final exported = await export();

      // Vaciamos la base y volvemos a importar lo exportado.
      // Vaciamos la base y volvemos a importar lo exportado.
      await db.delete(db.categoryPeriodTotals).go();
      await db.delete(db.budgetItems).go();
      await db.delete(db.financialTransactions).go();
      await db.delete(db.financialPeriods).go();

      final result = await import(exported);

      expect(result.imported, 2);
      expect(result.skipped, 0);
    },
  );
}
