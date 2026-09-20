import 'dart:async';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mis_finanzas/core/database/app_database.dart';
import 'package:mis_finanzas/features/settings/data/drift_settings_repository.dart';
import 'package:mis_finanzas/features/settings/domain/user_settings.dart';

void main() {
  late AppDatabase db;
  late DriftSettingsRepository repository;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repository = DriftSettingsRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('sin nada guardado devuelve los valores por defecto', () async {
    final settings = await repository.get();

    expect(settings.currencyCode, 'COP');
    expect(settings.locale, 'es_CO');
    expect(settings.onboardingCompleted, isFalse);
  });

  test('guardar crea una sola fila y se puede leer de nuevo', () async {
    await repository.save(UserSettings.defaults.copyWith(currencyCode: 'USD'));
    await repository.save(
      UserSettings.defaults.copyWith(
        currencyCode: 'EUR',
        onboardingCompleted: true,
      ),
    );

    final settings = await repository.get();
    expect(settings.currencyCode, 'EUR');
    expect(settings.currency.code, 'EUR');
    expect(settings.onboardingCompleted, isTrue);
    expect(await db.select(db.appSettings).get(), hasLength(1));
  });

  test('watch emite cada vez que cambian los ajustes', () async {
    final values = <String>[];
    final first = Completer<void>();
    final second = Completer<void>();

    final subscription = repository.watch().listen((settings) {
      values.add(settings.currencyCode);
      if (values.length == 1) first.complete();
      if (values.length == 2) second.complete();
    });

    // Se espera el valor inicial antes de guardar, para que el orden sea fijo.
    await first.future.timeout(const Duration(seconds: 2));
    await repository.save(UserSettings.defaults.copyWith(currencyCode: 'USD'));
    await second.future.timeout(const Duration(seconds: 2));
    await subscription.cancel();

    expect(values, ['COP', 'USD']);
  });
}