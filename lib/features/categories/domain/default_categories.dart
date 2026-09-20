/// Categoría del catálogo inicial (todavía sin id).
class CategorySeed {
  const CategorySeed(
    this.name, {
    required this.isIncome,
    required this.isFixed,
    this.isAntExpense = false,
    required this.iconKey,
    required this.colorHex,
  });

  final String name;
  final bool isIncome;
  final bool isFixed;
  final bool isAntExpense;
  final String iconKey;
  final String colorHex;
}

/// Catálogo inicial. Se crea una sola vez, al terminar la bienvenida.
/// El orden de la lista es el orden en que se muestran.
const List<CategorySeed> defaultCategorySeeds = [
  // Ingresos
  CategorySeed('Salario',
      isIncome: true, isFixed: true, iconKey: 'work', colorHex: '#2E9E5B'),
  CategorySeed('Ingresos adicionales',
      isIncome: true, isFixed: false, iconKey: 'add_card', colorHex: '#5BBF85'),

  // Gastos fijos
  CategorySeed('Arriendo',
      isIncome: false, isFixed: true, iconKey: 'home', colorHex: '#1E6FD9'),
  CategorySeed('EPM',
      isIncome: false, isFixed: true, iconKey: 'bolt', colorHex: '#F2A900'),
  CategorySeed('FNA',
      isIncome: false,
      isFixed: true,
      iconKey: 'account_balance',
      colorHex: '#6C5CE7'),
  CategorySeed('JFK',
      isIncome: false, isFixed: true, iconKey: 'payments', colorHex: '#00A6A6'),
  CategorySeed('Internet',
      isIncome: false, isFixed: true, iconKey: 'wifi', colorHex: '#3D8BFD'),
  CategorySeed('TV',
      isIncome: false, isFixed: true, iconKey: 'tv', colorHex: '#8E5CF7'),
  CategorySeed('GYM',
      isIncome: false,
      isFixed: true,
      iconKey: 'fitness_center',
      colorHex: '#E8590C'),

  // Gastos variables
  CategorySeed('Mercado',
      isIncome: false,
      isFixed: false,
      iconKey: 'shopping_cart',
      colorHex: '#2F9E44'),
  CategorySeed('Transporte',
      isIncome: false,
      isFixed: false,
      iconKey: 'directions_bus',
      colorHex: '#1C7ED6'),
  CategorySeed('Ropa',
      isIncome: false,
      isFixed: false,
      iconKey: 'checkroom',
      colorHex: '#D6336C'),

  // Gastos hormiga (variables y pequeños)
  CategorySeed('Mecatos',
      isIncome: false,
      isFixed: false,
      isAntExpense: true,
      iconKey: 'fastfood',
      colorHex: '#F76707'),
  CategorySeed('Otras D',
      isIncome: false,
      isFixed: false,
      isAntExpense: true,
      iconKey: 'more_horiz',
      colorHex: '#868E96'),
];