# hospital_app
# Sistema Hospitalario Flutter

## Guía de Instalación y Ejecución

### Paso 1: Instalar herramientas necesarias

Instalar los siguientes programas:

* Flutter SDK

* Git

Verificar instalación:

```bash
flutter doctor
```

Todos los elementos deben aparecer sin errores.

---

### Paso 2: Clonar el repositorio

Abrir una terminal y ejecutar:

```bash
git clone https://github.com/Dylannasd312/hospital_app.git

cd hospital_app
```

---

### Paso 3: Instalar dependencias

Ejecutar:

```bash
flutter pub get
```

Esperar a que finalice la descarga de paquetes.

---

### Paso 4: Activar modo desarrollador en Android

En el teléfono:

1. Abrir Configuración.
2. Acerca del teléfono.
3. Pulsar 7 veces sobre "Número de compilación".
4. Volver al menú principal.
5. Abrir "Opciones de desarrollador".
6. Activar:

   * Depuración USB
   * Instalar mediante USB (si existe)

---

### Paso 5: Conectar el teléfono

Conectar el dispositivo mediante cable USB.

Aceptar el mensaje:

```text
¿Permitir depuración USB?
```

Seleccionar:

```text
Permitir siempre
```

y luego:

```text
Aceptar
```

---

### Paso 6: Verificar conexión

Ejecutar:

```bash
flutter devices
```

Debe aparecer algo similar a:

```text
1 connected device:

SM-A546E • Android • Android 14
```

---

### Paso 7: Ejecutar el proyecto

Desde la carpeta del proyecto:

```bash
flutter run
```

Flutter compilará la aplicación e instalará automáticamente el APK en el teléfono.

---


### Error de dependencias

Ejecutar:

```bash
flutter clean

flutter pub get
```

---

### El teléfono no aparece

Ejecutar:

```bash
flutter devices
```

Verificar:

* Cable USB funcionando.
* Depuración USB activada.
* Permiso de depuración aceptado.

---

### Verificar estado de Flutter

```bash
flutter doctor
```

Corregir cualquier error reportado.

---

## Comandos más utilizados

Instalar dependencias:

```bash
flutter pub get
```

Ejecutar proyecto:

```bash
flutter run
```

Actualizar proyecto:

```bash
git pull origin main
```


