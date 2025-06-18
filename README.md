# Historial de Prescripciones (Flutter Web) – Documentación

## Tabla de Contenidos

1. [Requisitos](#requisitos)
2. [Instalación y Configuración](#instalación-y-configuración)
3. [Estructura del Proyecto](#estructura-del-proyecto)
4. [Funcionalidad](#funcionalidad)
5. [Variables de Entorno](#variables-de-entorno)
6. [Ejecución y Pruebas Locales](#ejecución-y-pruebas-locales)
7. [Compilación y Despliegue](#compilación-y-despliegue)
8. [Resumen de Versiones](#resumen-de-versiones)

---

## Requisitos

* **Flutter SDK** v3.13 o superior con soporte web habilitado
* **Dart SDK** (incluido con Flutter)
* Navegador **Chrome**
* **VS Code** o **Android Studio** con extensión de Flutter

---

## Instalación y Configuración

1. **Clona el repositorio**

   ```bash
   git clone https://github.com/elitecoderdev/frontflutter.git
   cd frontflutter
   ```

2. **Agrega tu archivo `.env`** en la raíz del proyecto:

   ```
   API_URL=http://localhost:8000
   ```

3. **Instala las dependencias**

   ```bash
   flutter pub get
   ```

4. **Habilita el soporte para web** (si aún no está activado)

   ```bash
   flutter config --enable-web
   ```

5. **Sirve la app localmente**

   ```bash
   flutter run -d chrome
   ```

---

## Estructura del Proyecto

```
prescription_web/
├── .env
├── pubspec.yaml
├── lib/
│   ├── main.dart
│   └── src/
│       ├── api/
│       │   └── api_service.dart
│       ├── models/
│       │   └── prescription.dart
│       ├── providers/
│       │   └── prescription_provider.dart
│       ├── screens/
│       │   ├── login_screen.dart
│       │   └── prescriptions_page.dart
│       ├── widgets/
│       │   ├── search_form.dart
│       │   └── prescription_tile.dart
│       └── utils/
│           └── validators.dart
└── web/
    └── index.html
```

---

## Funcionalidad

### 1. **Pantalla de Inicio de Sesión** (simulada)

* **Campos**: Correo electrónico y contraseña

* **Validaciones**:

  * Correo requerido + formato válido
  * Contraseña de mínimo 6 caracteres, con mayúsculas, minúsculas y caracter especial

* **Al hacer clic en “Iniciar sesión”**: Navega a la pantalla de prescripciones

### 2. **Pantalla de Prescripciones**

* **Datos**: Consume la API `/recipes`

* **Muestra por cada registro**:

  * Nombre del medicamento
  * Fecha de emisión
  * Nombre del doctor
  * Notas u observaciones

* **Estados y funcionalidades**:

  * Spinner de **carga**
  * Estado de **error** con SnackBar y botón de reintento
  * Mensaje de **lista vacía** + pull-to-refresh
  * **Pull-to-refresh** para recargar la primera página
  * **Scroll infinito** para cargar más páginas automáticamente
  * **Paginación manual** (botones Anterior / Siguiente)
  * **Búsqueda en vivo**: filtra mientras escribes, al presionar Enter o hacer clic en buscar
  * **Conteo total de resultados** mostrado arriba de la lista

### Detalles Técnicos

* **Gestión de estado**: Riverpod
* **Estructura modular** que separa API, modelos, proveedores y UI
* **Interfaz desacoplada de la lógica**, siguiendo buenas prácticas

---

## Variables de Entorno

Usamos [`flutter_dotenv`](https://pub.dev/packages/flutter_dotenv) para cargar `API_URL`:

* **Archivo `.env`** (en la raíz del proyecto):

  ```
  API_URL=http://localhost:8000
  ```

* **Acceso** en el código:

  ```dart
  import 'package:flutter_dotenv/flutter_dotenv.dart';
  final baseUrl = dotenv.env['API_URL']!;
  ```

---

## Ejecución y Pruebas Locales

1. **Asegúrate que el backend** esté corriendo en la URL indicada en tu `.env` (por ejemplo, ejecuta `npm run dev` para la API Node).

2. **Ejecuta la app Flutter Web**:

   ```bash
   flutter run -d chrome
   ```

3. **Prueba de login**:

   * Campos vacíos → muestra errores de validación
   * Ingresar un email y contraseña válidos → avanza a siguiente pantalla

     * Puedes usar:

       * Email: `johndoe@gmail.com`
       * Contraseña: `Password@123`

4. **Prueba de pantalla de prescripciones**:

   * Se muestra el spinner de carga, luego la lista
   * **Desliza hacia abajo** para refrescar → la lista se recarga
   * Desliza hasta el final → scroll infinito carga más
   * Botones Anterior/Siguiente → cambian de página y reinician la lista
   * Escribir en el buscador → se filtra en vivo
   * Borrar búsqueda → se muestra la lista completa

5. **Prueba del Pull-to-Refresh en Web**
   Por defecto, `RefreshIndicator` responde solo a eventos táctiles. Para simularlo en Chrome:

   * Abre las DevTools (F12) → haz clic en el icono **Toggle device toolbar** (o `Ctrl`+`Shift`+`M`)
   * Selecciona un dispositivo móvil (por ejemplo: **Pixel 2**)
   * Recarga la app
   * Desliza la lista hacia arriba, luego **haz clic y arrastra hacia abajo** → aparecerá el spinner y se recargan los datos

---

## Compilación y Despliegue

Para generar una versión lista para producción:

```bash
flutter build web
```

Esto genera archivos estáticos en `build/web/`, listos para ser desplegados en cualquier hosting estático.

---

## Resumen de Versiones

* **Flutter**: 3.13 o superior

* **Dart**: SDK incluido con Flutter

* **Dependencias**:

  * flutter\_riverpod
  * http
  * flutter\_dotenv

* **Herramientas de desarrollo**:

  * VS Code / Android Studio
  * Chrome (como destino para Web)
