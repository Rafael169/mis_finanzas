/// Moneda soportada por la app. Una sola moneda para todos los datos.
class Currency {
  const Currency({
    required this.code,
    required this.name,
    required this.symbol,
    required this.displayDecimals,
  });

  final String code;
  final String name;
  final String symbol;

  /// Decimales que se muestran y se digitan (no afecta cómo se guarda).
  final int displayDecimals;

  static const cop = Currency(code: 'COP', name: 'Peso colombiano', symbol: r'$', displayDecimals: 0);
  static const usd = Currency(code: 'USD', name: 'Dólar estadounidense', symbol: r'US$', displayDecimals: 2);
  static const eur = Currency(code: 'EUR', name: 'Euro', symbol: '€', displayDecimals: 2);
  static const mxn = Currency(code: 'MXN', name: 'Peso mexicano', symbol: r'MX$', displayDecimals: 2);
  static const ars = Currency(code: 'ARS', name: 'Peso argentino', symbol: r'AR$', displayDecimals: 2);
  static const pen = Currency(code: 'PEN', name: 'Sol peruano', symbol: 'S/', displayDecimals: 2);
  static const clp = Currency(code: 'CLP', name: 'Peso chileno', symbol: r'CLP$', displayDecimals: 0);
  static const brl = Currency(code: 'BRL', name: 'Real brasileño', symbol: r'R$', displayDecimals: 2);

  static const List<Currency> supported = [cop, usd, eur, mxn, ars, pen, clp, brl];

  static Currency fromCode(String code) {
    return supported.firstWhere((c) => c.code == code, orElse: () => cop);
  }
}