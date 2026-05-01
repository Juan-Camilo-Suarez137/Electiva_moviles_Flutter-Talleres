# app_distribution_taller

# 📱 App Distribution - Flutter + Firebase

## 🚀 Flujo de trabajo

El proceso seguido para la distribución de la aplicación móvil utilizando Flutter y Firebase App Distribution fue el siguiente:

### 1. 📦 Generar APK

Se construyó la aplicación en modo **release** para obtener un archivo instalable optimizado:

```bash
flutter build apk --release
```

Esto genera el archivo `.apk` dentro de la ruta:

```
build/app/outputs/flutter-apk/app-release.apk
```

---

### 2. 🔥 App Distribution (Firebase)

* Se creó un proyecto en Firebase.
* Se registró la aplicación Android dentro del proyecto.
* Se habilitó el servicio **App Distribution**.
* Se subió el archivo APK generado desde Flutter.

---

### 3. 👥 Testers

* Se creó un grupo de testers (por ejemplo: `QA_Clase`).
* Se agregaron los correos electrónicos de los evaluadores o usuarios de prueba.
* Firebase gestionó automáticamente el envío de invitaciones.

---

### 4. 📲 Instalación

* Los testers recibieron un correo electrónico con un enlace de descarga.
* Accedieron al enlace desde su dispositivo móvil.
* Descargaron e instalaron la aplicación siguiendo las instrucciones.

---

### 5. 🔄 Actualización

Para publicar nuevas versiones de la app:

* Se actualizó la versión en el archivo `pubspec.yaml`, por ejemplo:

```yaml
version: 1.0.1+2
```

* Se generó nuevamente el APK:

```bash
flutter build apk --release
```

* Se subió la nueva versión a Firebase App Distribution.
* Los testers recibieron una notificación de actualización.




