# Taller: Asincronía y Procesamiento en Segundo Plano

Este proyecto, desarrollado en el marco de la asignatura de Electiva de Móviles, demuestra la implementación de concurrencia y manejo de procesos en segundo plano utilizando el framework Flutter.

## Requisitos del Taller
- **Asincronía (Future/Async/Await):** Simulación de consulta a servidor con manejo de estados (Cargando, Éxito y Error).
- **Timer:** Implementación de un cronómetro con controles de Iniciar, Pausar, Reanudar y Reiniciar.
- **Isolates:** Ejecución de una tarea pesada (suma masiva) en un hilo separado para evitar el bloqueo del hilo principal (UI Thread).

## Estructura del Código
- `lib/main.dart`: Contiene la interfaz de usuario (UI) y la lógica de los estados.
- `lib/services/async_service.dart`: Contiene la lógica de negocio, la simulación de red y la función estática para el Isolate.