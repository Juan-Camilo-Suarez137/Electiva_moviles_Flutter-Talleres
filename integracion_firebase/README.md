# Integración de Flutter con Google Firebase: Módulo Universidades

Este repositorio contiene la implementación del módulo de gestión de universidades desarrollado en **Flutter**, completamente integrado en tiempo real con **Google Firebase Firestore**. El proyecto sigue el flujo de trabajo estructurado de **GitFlow** y aplica patrones de arquitectura desacoplados para la manipulación y persistencia de datos.



---

## 🛠️ Tecnologías y Paquetes Utilizados

* **Framework:** [Flutter](https://flutter.dev/) (Dart SDK)
* **Base de Datos:** [Cloud Firestore](https://firebase.google.com/docs/firestore) (Firebase Ecosystem)
* **Dependencias Principales (`pubspec.yaml`):**
  * `firebase_core`: Para la inicialización del ecosistema de Firebase en la aplicación móvil.
  * `cloud_firestore`: Para la conexión, escucha y operaciones CRUD sobre colecciones de la base de datos NoSQL.

---

## 🌿 Flujo de Trabajo (GitFlow)

El desarrollo del módulo se estructuró de manera estricta bajo las buenas prácticas del flujo de ramas definido para la asignatura:

1. **Rama Base (`dev`):** Actualizada como punto de partida estable del repositorio de talleres.
2. **Rama de Trabajo de la Feature (`feature/taller_firebase_universidades`):** Creada de manera local y remota para aislar el desarrollo del CRUD de Firebase.
3. **Fusión (`Pull Request`):** Apertura del flujo controlado de entrega desde la rama de la *feature* con destino hacia `dev` para su revisión técnica y merge final.

```bash
# Secuencia de comandos Git ejecutados
git checkout dev
git pull origin dev
git checkout -b feature/taller_firebase_universidades
# ... (Proceso de codificación e instalación) ...
git add .
git commit -m "feat: integración CRUD Firestore colección universidades"
git push origin feature/taller_firebase_universidades
