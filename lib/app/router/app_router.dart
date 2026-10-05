import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/analytics/presentation/analytics_page.dart';
import '../../features/budgets/presentation/budgets_page.dart';
import '../../features/categories/presentation/categories_page.dart';
import '../../features/categories/presentation/suggested_categories_page.dart';
import '../../features/dashboard/presentation/home_page.dart';
import '../../features/onboarding/presentation/onboarding_page.dart';
import '../../features/onboarding/presentation/splash_page.dart';
import '../../features/settings/presentation/profile_page.dart';
import '../../features/settings/presentation/settings_providers.dart';
import '../../features/transactions/presentation/edit_transaction_page.dart';
import '../../features/transactions/presentation/movements_page.dart';
import '../../features/transactions/presentation/new_transaction_page.dart';
import 'app_shell.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final refresh = ValueNotifier<int>(0);
  ref.listen(userSettingsProvider, (previous, next) => refresh.value++);
  ref.onDispose(refresh.dispose);

  return GoRouter(
    initialLocation: '/cargando',
    refreshListenable: refresh,
    redirect: (context, state) {
      final settings = ref.read(userSettingsProvider);
      final location = state.matchedLocation;

      if (!settings.hasValue) {
        return location == '/cargando' ? null : '/cargando';
      }

      if (!settings.requireValue.onboardingCompleted) {
        return location == '/bienvenida' ? null : '/bienvenida';
      }

      if (location == '/cargando' || location == '/bienvenida') {
        return '/inicio';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/cargando',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/bienvenida',
        builder: (context, state) => const OnboardingPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/inicio',
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/movimientos',
                builder: (context, state) => const MovementsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/presupuestos',
                builder: (context, state) => const BudgetsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/analisis',
                builder: (context, state) => const AnalyticsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/perfil',
                builder: (context, state) => const ProfilePage(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/nuevo-movimiento',
        builder: (context, state) => const NewTransactionPage(),
      ),
      GoRoute(
        path: '/editar-movimiento/:id',
        builder: (context, state) => EditTransactionPage(
          movementId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: '/categorias',
        builder: (context, state) => const CategoriesPage(),
      ),
      GoRoute(
        path: '/categorias-sugeridas',
        builder: (context, state) => const SuggestedCategoriesPage(),
      ),
    ],
  );
});