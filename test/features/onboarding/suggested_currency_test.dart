import 'package:flutter_test/flutter_test.dart';
import 'package:mis_finanzas/features/onboarding/domain/suggested_currency.dart';

void main() {
  test('reconoce las regiones de las monedas soportadas', () {
    expect(suggestedCurrencyForRegion('CO').code, 'COP');
    expect(suggestedCurrencyForRegion('US').code, 'USD');
    expect(suggestedCurrencyForRegion('mx').code, 'MXN'); // en minúsculas
    expect(suggestedCurrencyForRegion('ES').code, 'EUR');
    expect(suggestedCurrencyForRegion('BR').code, 'BRL');
  });

  test('sin región o con una desconocida sugiere COP', () {
    expect(suggestedCurrencyForRegion(null).code, 'COP');
    expect(suggestedCurrencyForRegion('JP').code, 'COP');
  });
}