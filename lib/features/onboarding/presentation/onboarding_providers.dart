import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../categories/presentation/category_providers.dart';
import '../../settings/presentation/settings_providers.dart';
import '../domain/complete_onboarding.dart';

final completeOnboardingProvider = Provider<CompleteOnboarding>((ref) {
  return CompleteOnboarding(
    ref.watch(settingsRepositoryProvider),
    ref.watch(seedDefaultCategoriesProvider),
  );
});