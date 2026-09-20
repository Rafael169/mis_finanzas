import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/currency.dart';
import '../domain/suggested_currency.dart';
import 'onboarding_providers.dart';

/// Pantalla de bienvenida: se muestra solo la primera vez.
class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  late Currency _selected;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _selected = suggestedCurrencyForRegion(
      ui.PlatformDispatcher.instance.locale.countryCode,
    );
  }

  Future<void> _start() async {
    setState(() => _saving = true);
    try {
      await ref.read(completeOnboardingProvider)(_selected);
      // No hay que navegar: el router detecta el cambio en los ajustes
      // y abre Inicio solo.
    } catch (_) {
      if (!mounted) return;
      setState(() => _saving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo guardar. Intenta de nuevo.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
                    children: [
                      Icon(
                        Icons.account_balance_wallet,
                        size: 48,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(height: 16),
                      Text('Bienvenido', style: theme.textTheme.headlineMedium),
                      const SizedBox(height: 8),
                      Text(
                        '¿Qué moneda vas a usar? Se aplicará a todos tus '
                        'movimientos.',
                        style: theme.textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 24),
                      for (final currency in Currency.supported)
                        Card(
                          child: ListTile(
                            selected: currency.code == _selected.code,
                            leading: SizedBox(
                              width: 48,
                              child: FittedBox(
                                child: Text(
                                  currency.symbol,
                                  style: theme.textTheme.titleMedium,
                                ),
                              ),
                            ),
                            title: Text(currency.name),
                            subtitle: Text(currency.code),
                            trailing: currency.code == _selected.code
                                ? const Icon(Icons.check_circle)
                                : null,
                            onTap: _saving
                                ? null
                                : () => setState(() => _selected = currency),
                          ),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: Column(
                    children: [
                      Text(
                        'Crearemos tus categorías básicas (Arriendo, Mercado, '
                        'Mecatos y más). Podrás editarlas después.',
                        style: theme.textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: FilledButton(
                          onPressed: _saving ? null : _start,
                          child: _saving
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text('Comenzar'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}