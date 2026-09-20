import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/widgets/placeholder_page.dart';
import '../../features/transactions/presentation/new_transaction_page.dart';
import 'app_shell.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/inicio',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/inicio',
              builder: (context, state) => const PlaceholderPage(
                title: 'Inicio',
                icon: Icons.home_outlined,
              ),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/movimientos',
              builder: (context, state) => const PlaceholderPage(
                title: 'Movimientos',
                icon: Icons.receipt_long_outlined,
              ),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/presupuestos',
              builder: (context, state) => const PlaceholderPage(
                title: 'Presupuestos',
                icon: Icons.account_balance_wallet_outlined,
              ),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/analisis',
              builder: (context, state) => const PlaceholderPage(
                title: 'Análisis',
                icon: Icons.insights_outlined,
              ),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/perfil',
              builder: (context, state) => const PlaceholderPage(
                title: 'Perfil',
                icon: Icons.person_outline,
              ),
            ),
          ]),
        ],
      ),
      // Fuera de la barra de navegación: se abre a pantalla completa.
      GoRoute(
        path: '/nuevo-movimiento',
        builder: (context, state) => const NewTransactionPage(),
      ),
    ],
  );
});