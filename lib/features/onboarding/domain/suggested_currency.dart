import '../../../core/domain/currency.dart';

/// Países cuya moneda es el euro (los más comunes).
const _euroRegions = {
  'ES', 'DE', 'FR', 'IT', 'PT', 'NL', 'BE', 'AT', 'IE', 'FI', 'GR', 'LU',
};

/// Moneda sugerida según la región del dispositivo (código de país de dos
/// letras). Si no se reconoce, se sugiere COP.
Currency suggestedCurrencyForRegion(String? countryCode) {
  final code = countryCode?.toUpperCase();
  if (code == null) return Currency.cop;
  if (_euroRegions.contains(code)) return Currency.eur;

  return switch (code) {
    'CO' => Currency.cop,
    'US' => Currency.usd,
    'MX' => Currency.mxn,
    'AR' => Currency.ars,
    'PE' => Currency.pen,
    'CL' => Currency.clp,
    'BR' => Currency.brl,
    _ => Currency.cop,
  };
}