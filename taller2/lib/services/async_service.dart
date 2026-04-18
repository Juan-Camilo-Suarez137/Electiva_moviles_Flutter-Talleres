import 'dart:async';
import 'dart:isolate';

class AsyncService {
  // 1. Requisito: Future / async / await con logs en consola
  Future<String> simularConsulta() async {
    print("Consola: Iniciando ejecución (antes)"); 
    
    await Future.delayed(const Duration(seconds: 3));
    
    print("Consola: Procesando datos (durante)"); 
    
    // Simulación de éxito o error (50/50)
    if (DateTime.now().second % 2 == 0) {
      return "¡Carga Exitosa!";
    } else {
      throw Exception("Error de conexión");
    }
  }

  // 3. Requisito: Isolate para tarea pesada (CPU-bound)
  static void tareaPesada(SendPort port) {
    print("Consola: Isolate iniciado en hilo separado...");
    int iteraciones = 1000000000;
    int resultado = 0;
    
    for (int i = 0; i <= iteraciones; i++) {
      resultado += i;
    }
    
    port.send(resultado); // Enviamos el resultado de vuelta a la UI
  }
}