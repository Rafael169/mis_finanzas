import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/widgets/placeholder_page.dart';
import '../../features/onboarding/presentation/onboarding_page.dart';
import '../../features/onboarding/presentation/splash_page.dart';
import '../../features/settings/presentation/db_check_page.dart';
import '../../features/settings/presentation/settings_providers.dart';
import '../../features/transactions/presentation/edit_transaction_page.dart';
import '../../features/transactions/presentation/movements_page.dart';
import '../../features/transactions/presentation/new_transaction_page.dart';
import 'app_shell.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  // Avisa al router cuando cambian los ajustes, para que reevalúe el redirect.
  final refresh = ValueNotifier<int>(0);
  ref.listen(userSettingsProvider, (previous, next) => refresh.value++);
  ref.onDispose(refresh.dispose);

  return GoRouter(
    initialLocation: '/cargando',
    refreshListenable: refresh,
    redirect: (context, state) {
      final settings = ref.read(userSettingsProvider);
      final location = state.matchedLocation;

      // 1. Ajustes aún cargando: pantalla de carga.
      if (!settings.hasValue) {
        return location == '/cargando' ? null : '/cargando';
      }

      // 2. Bienvenida sin completar: siempre a la bienvenida.
      if (!settings.requireValue.onboardingCompleted) {
        return location == '/bienvenida' ? null : '/bienvenida';
      }

      // 3. Ya completada: no se vuelve a las pantallas de arranque.
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
                builder: (context, state) => const DbCheckPage(), // TEMPORAL
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
                builder: (context, state) => const PlaceholderPage(
                  title: 'Presupuestos',
                  icon: Icons.account_balance_wallet_outlined,
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/analisis',
                builder: (context, state) => const PlaceholderPage(
                  title: 'Análisis',
                  icon: Icons.insights_outlined,
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/perfil',
                builder: (context, state) => const PlaceholderPage(
                  title: 'Perfil',
                  icon: Icons.person_outline,
                ),
              ),
            ],
          ),
        ],
      ),
      // Fuera de la barra de navegación: se abren a pantalla completa.
      GoRoute(
        path: '/nuevo-movimiento',
        builder: (context, state) => const NewTransactionPage(),
      ),
      GoRoute(
        path: '/editar-movimiento/:id',
        builder: (context, state) =>
            EditTransactionPage(movementId: state.pathParameters['id']!),
      ),
    ],
  );
});
