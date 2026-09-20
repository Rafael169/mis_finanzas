import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app/theme/app_theme.dart';
import 'core/domain/currency.dart';
import 'core/utils/money_formatter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es_CO');
  runApp(const ProviderScope(child: FinanzasApp()));
}

class FinanzasApp extends StatelessWidget {
  const FinanzasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mis Finanzas',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      locale: const Locale('es', 'CO'),
      supportedLocales: const [Locale('es', 'CO')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const _PlaceholderHome(),
    );
  }
}

/// Pantalla temporal: se reemplaza en el paso 6 por la navegación real.
class _PlaceholderHome extends StatelessWidget {
  const _PlaceholderHome();

  @override
  Widget build(BuildContext context) {
    final amount = formatMinorUnits(
      116984100, // $1.169.841 guardado en "centavos"
      currency: Currency.cop,
      locale: 'es_CO',
    );
    return Scaffold(
      appBar: AppBar(title: const Text('Mis Finanzas')),
      body: Center(
        child: Text(amount, style: Theme.of(context).textTheme.displaySmall),
      ),
    );
  }
}