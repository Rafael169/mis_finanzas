import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mis_finanzas/core/database/app_database.dart';
import 'package:mis_finanzas/core/domain/currency.dart';
import 'package:mis_finanzas/features/categories/data/drift_category_repository.dart';
import 'package:mis_finanzas/features/categories/domain/seed_default_categories.dart';
import 'package:mis_finanzas/features/onboarding/domain/complete_onboarding.dart';
import 'package:mis_finanzas/features/settings/data/drift_settings_repository.dart';
import 'package:mis_finanzas/features/settings/domain/user_settings.dart';

void main() {
  late AppDatabase db;
  late DriftSettingsRepository settings;
  late DriftCategoryRepository categories;
  late CompleteOnboarding completeOnboarding;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    settings = DriftSettingsRepository(db);
    categories = DriftCategoryRepository(db);
    completeOnboarding = CompleteOnboarding(
      settings,
      SeedDefaultCategories(categories),
    );
  });

  tearDown(() async {
    await db.close();
  });

  test('guarda la moneda, marca la bienvenida y crea las categorías',
      () async {
    await completeOnboarding(Currency.usd);

    final saved = await settings.get();
    expect(saved.currencyCode, 'USD');
    expect(saved.onboardingCompleted, isTrue);
    expect(await categories.count(), 14);
  });

  test('repetirlo no duplica las categorías', () async {
    await completeOnboarding(Currency.usd);
    await completeOnboarding(Currency.usd);

    expect(await categories.count(), 14);
  });

  test('conserva los demás ajustes', () async {
    await settings.save(
      UserSettings.defaults.copyWith(defaultAlertPercent: 70),
    );

    await completeOnboarding(Currency.eur);

    final saved = await settings.get();
    expect(saved.currencyCode, 'EUR');
    expect(saved.defaultAlertPercent, 70);
  });
}