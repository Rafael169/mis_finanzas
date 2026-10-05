# Mis Finanzas

Aplicación móvil de finanzas personales hecha en Flutter, pensada como reemplazo del Excel de control mensual de ingresos y gastos. Funciona completamente **local** (sin servidor ni cuenta de usuario): todos los datos se guardan en SQLite en el propio dispositivo.

## Características

- **Registro de movimientos**: ingresos y gastos, con categoría, fecha, corte (quincena) y descripción opcional.
- **Categorías**: catálogo básico al iniciar + categorías sugeridas que se activan con un toque + creación 100% libre (nombre, icono, color, grupo).
- **Presupuestos**: Presupuesto vs. Actual por categoría, con alertas automáticas al llegar al 80 % y al superar el 100 %.
- **Inicio**: balance del mes, ingresos/gastos, gráficas de distribución, progreso del gasto y gasto hormiga.
- **Análisis**: totales del año, balance mes a mes, gasto por categoría.
- **Respaldo**: exportar e importar movimientos en CSV.
- **Modo oscuro**: Sistema / Claro / Oscuro.
- **Moneda configurable**: se elige una vez en la bienvenida (COP, USD, EUR, MXN, ARS, PEN, CLP, BRL).

## Stack técnico

| Capa | Herramienta |
|---|---|
| Framework | Flutter (Dart) |
| Estado | Riverpod |
| Navegación | go_router |
| Base de datos local | Drift (sobre SQLite) |
| Formato/fechas | intl |
| Identificadores | uuid |
| CSV | csv |
| Compartir / elegir archivos | share_plus, file_picker, path_provider |

Arquitectura por *feature* con capas `domain` / `data` / `presentation` dentro de cada una (Clean Architecture simplificada). Ver `lib/features/`.

## Requisitos previos

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (canal estable). Verifica tu instalación con:
  ```
  flutter doctor
  ```
  Todo lo relacionado con **Flutter** y **Android toolchain** debe aparecer en verde.
- Android Studio (para el SDK de Android y, opcionalmente, un emulador) o un teléfono físico con depuración USB activada.
- Git.

Plataformas soportadas hoy: **Android** y **Web** (para desarrollo rápido de la interfaz; la base de datos solo funciona en Android, no en Web todavía). iOS está planificado pero no configurado.

## Instalación en un equipo nuevo

1. Clona el repositorio:
   ```
   git clone <URL_DEL_REPOSITORIO>
   cd mis_finanzas
   ```

2. Instala las dependencias:
   ```
   flutter pub get
   ```

3. Genera el código de la base de datos (Drift) y demás código generado:
   ```
   dart run build_runner build --delete-conflicting-outputs
   ```

4. Conecta un dispositivo Android (teléfono con depuración USB, o un emulador) y verifica que Flutter lo detecte:
   ```
   flutter devices
   ```

5. Ejecuta la app:
   ```
   flutter run
   ```

   Para desarrollar más rápido la interfaz sin tocar la base de datos, también puedes correr en el navegador (las pantallas que leen datos no funcionarán ahí):
   ```
   flutter run -d chrome
   ```

## Comandos útiles durante el desarrollo

| Comando | Qué hace |
|---|---|
| `flutter analyze` | Revisa el código en busca de errores y avisos |
| `flutter test` | Corre toda la suite de pruebas |
| `flutter test --reporter expanded <ruta>` | Corre y lista las pruebas de un archivo o carpeta puntual |
| `dart run build_runner build --delete-conflicting-outputs` | Regenera el código de Drift tras cambiar las tablas |
| `flutter clean && flutter pub get` | Limpia cachés si algo no compila sin razón aparente |

## Estructura del proyecto

```
lib/
├── main.dart
├── app/                  # Tema, router, shell de navegación
├── core/                 # Código compartido: base de datos, Money, reglas de cortes, widgets genéricos
└── features/
    ├── analytics/        # Pestaña Análisis
    ├── backup/           # Exportar / importar CSV
    ├── budgets/          # Presupuestos y alertas
    ├── categories/       # Categorías (catálogo, sugeridas, gestión)
    ├── dashboard/        # Pestaña Inicio
    ├── onboarding/       # Bienvenida (elegir moneda, sembrar categorías)
    ├── periods/          # Selección de mes/año compartida entre pestañas
    ├── settings/         # Perfil, tema, ajustes
    └── transactions/     # Registro, edición e historial de movimientos
test/                     # Pruebas, con la misma estructura de carpetas que lib/
```

## Migraciones de base de datos

El esquema vive en `lib/core/database/tables.dart` y se versiona en `lib/core/database/app_database.dart`. Cada cambio de esquema sube `schemaVersion` en 1 y agrega su paso correspondiente dentro de `onUpgrade`, documentado con un comentario junto al número de versión. **Nunca se borra ni se reordena una migración ya publicada**, para no perder datos de usuarios que actualicen desde una versión anterior.

## Convención de versionado

`pubspec.yaml` usa el formato `version: X.Y.Z+N`:

- `X.Y.Z` es la versión visible para el usuario (semver): mayor.menor.parche.
- `N` (después del `+`) es el código de compilación interno que usa Play Store para identificar cada build. **Debe subir en cada build que se publique, sin excepción, nunca se repite ni baja.**

## Notas de desarrollo

- Las pruebas de cada archivo de dominio/datos van en la misma ruta relativa dentro de `test/` (por ejemplo, `lib/features/budgets/domain/save_budget.dart` ↔ `test/features/budgets/save_budget_test.dart`).
- Los montos se manejan siempre como enteros ("centavos") a través del tipo `Money`, nunca con `double`, para evitar errores de redondeo.
- El corte (quincena) se calcula siempre a partir del día del mes: 1–15 es Corte 1, 16 en adelante es Corte 2.

## Roadmap

- [ ] Presupuestos recurrentes (indefinidos o con número fijo de cuotas, para deudas y suscripciones)
- [ ] Soporte Web completo (base de datos) e iOS
- [ ] Bloqueo de la app con PIN/huella
- [ ] Publicación en Google Play Store
- [ ] Sincronización en la nube (fase posterior al MVP)
