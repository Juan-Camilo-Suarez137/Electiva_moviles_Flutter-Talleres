# taller3
Este proyecto es una aplicación móvil desarrollada en Flutter que consume la API pública de API Colombia. El objetivo es visualizar información relevante sobre el país mediante una arquitectura limpia y desacoplada.

# API Utilizada
Se seleccionó la API Colombia, una fuente de datos abiertos que proporciona información sobre geografía, historia y cultura.

Base URL: https://api-colombia.com/api/v1

Documentación: Swagger UI

Endpoints Seleccionados:
- President: Listado de presidentes de la historia de Colombia.
- Region: Información sobre las regiones geográficas del país.
- TouristicAttraction: Sitios de interés y monumentos nacionales.
- Department: Datos sobre los departamentos de Colombia.

# Arquitectura y Estructura del Proyecto

La aplicación sigue una **arquitectura por capas** para garantizar la separación de responsabilidades y facilitar el mantenimiento:

lib
  - config/    # Configuración de .env
  - models/    # Modelos de datos con mapeo fromJson y toJson
  - routes/    # Configuración centralizada de navegación con go_router
  - services/  # Capa de servicios para peticiones HTTP (http)
  - themes/    # Estilos y temas visuales globales
  - views/     # Pantallas principales (Dashboard, Listado y Detalle)
  - widgets/   # Componentes visuales reutilizables

<img width="1920" height="1020" alt="image" src="https://github.com/user-attachments/assets/507fd042-e397-4edf-8431-c1f1d028e61f" />
<img width="1920" height="1020" alt="image" src="https://github.com/user-attachments/assets/43a9c319-feec-4ac1-903a-aad739edf778" />
<img width="1920" height="1020" alt="image" src="https://github.com/user-attachments/assets/e7b9b4ee-2577-4b04-8227-9b2c68bfe60a" />

##  Rutas y Navegación (`go_router`)

Se implementó una navegación declarativa utilizando el paquete go_router, lo que permite una gestión eficiente del historial de navegación y el paso de parámetros dinámicos entre pantallas siguiendo el patrón Maestro-Detalle.

| Ruta | Descripción | Parámetros Enviados |
| :--- | :--- | :--- |
| `/` | **Dashboard (Home):** Pantalla principal con acceso a las 4 categorías. | Ninguno |
| `/list/:type` | **Listado:** Muestra todos los elementos de la categoría seleccionada (President, Region, etc.). | `type`: El nombre del endpoint a consumir. |
| `/detail/:type/:id` | **Detalle:** Renderiza la información completa de un registro específico. | `type`: Categoría. <br> `id`: Identificador único del recurso. |

### Ejemplo de navegación en código:
Para navegar al detalle de un presidente específico, se utiliza el siguiente comando:
```dart
context.push('/detail/President/${item.id}');


# Ejemplo de Respuesta JSON /President
{
  "id": 1,
  "name": "Rafael",
  "lastName": "Núñez Moledo",
  "image": "[https://api-colombia.com/images/presidents/1.jpg](https://api-colombia.com/images/presidents/1.jpg)",
  "description": "Político y escritor colombiano que ocupó en varias oportunidades el cargo de presidente de Colombia..."
}
