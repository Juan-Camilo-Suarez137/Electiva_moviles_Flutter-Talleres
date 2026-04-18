import 'dart:async';
import 'dart:isolate';
import 'package:flutter/material.dart';
import 'services/async_service.dart';

void main() => runApp(MaterialApp(
      home: TallerScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
    ));

class TallerScreen extends StatefulWidget {
  @override
  _TallerScreenState createState() => _TallerScreenState();
}

class _TallerScreenState extends State<TallerScreen> {
  final AsyncService _service = AsyncService();
  
  // Estados para Future
  String _statusFuture = "Listo para iniciar";
  bool _isFutureLoading = false;
  Color _futureColor = Colors.grey;

  // Estados para Timer (Cronómetro)
  Timer? _timer;
  int _milisegundos = 0;
  bool _isTimerRunning = false;

  // Estados para Isolate
  String _isolateResult = "Esperando cálculo...";
  bool _isIsolateLoading = false;

  // --- Lógica del Timer (Requisito 2) ---
  void _iniciarTimer() {
    if (_isTimerRunning) return;
    setState(() => _isTimerRunning = true);
    _timer = Timer.periodic(const Duration(milliseconds: 100), (t) {
      setState(() => _milisegundos += 100);
    });
  }

  void _pausarTimer() {
    _timer?.cancel();
    setState(() => _isTimerRunning = false);
  }

  void _reiniciarTimer() {
    _pausarTimer();
    setState(() => _milisegundos = 0);
  }

  @override
  void dispose() {
    _timer?.cancel(); // Limpieza obligatoria de recursos
    super.dispose();
  }

  // --- Lógica del Isolate (Requisito 3) ---
  Future<void> _ejecutarIsolate() async {
    setState(() {
      _isIsolateLoading = true;
      _isolateResult = "Calculando en segundo plano...";
    });
    final rp = ReceivePort();
    await Isolate.spawn(AsyncService.tareaPesada, rp.sendPort);
    
    rp.listen((mensaje) {
      setState(() {
        _isolateResult = "Suma total: $mensaje";
        _isIsolateLoading = false;
      });
      print("Consola: Isolate finalizado con éxito.");
      rp.close();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("Taller de Asincronía UCEVA", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            // SECCIÓN 1: FUTURE
            _buildCard(
              title: "1. Future / Async / Await",
              icon: Icons.cloud_download_rounded,
              color: Colors.blueAccent,
              content: Column(
                children: [
                  Text(_statusFuture, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: _futureColor)),
                  const SizedBox(height: 15),
                  if (_isFutureLoading) 
                    const Padding(padding: EdgeInsets.only(bottom: 15), child: LinearProgressIndicator()),
                  ElevatedButton.icon(
                    style: _btnStyle(Colors.blueAccent),
                    onPressed: _isFutureLoading ? null : () async {
                      setState(() { 
                        _isFutureLoading = true; 
                        _statusFuture = "Consultando..."; 
                        _futureColor = Colors.orange; 
                      });
                      try {
                        String res = await _service.simularConsulta();
                        setState(() { _statusFuture = res; _futureColor = Colors.green; });
                      } catch (e) {
                        setState(() { _statusFuture = "Error de red"; _futureColor = Colors.red; });
                      } finally { 
                        setState(() => _isFutureLoading = false);
                        print("Consola: Ejecución finalizada (después)");
                      }
                    },
                    icon: const Icon(Icons.bolt),
                    label: const Text("EJECUTAR CONSULTA"),
                  ),
                ],
              ),
            ),

            // SECCIÓN 2: TIMER (Con los 4 botones requeridos)
            _buildCard(
              title: "2. Timer (Cronómetro)",
              icon: Icons.timer_rounded,
              color: Colors.deepPurple,
              content: Column(
                children: [
                  Text(
                    "${(_milisegundos / 1000).toStringAsFixed(1)}s", 
                    style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                  ),
                  const SizedBox(height: 15),
                  
                  // Fila de botones principales
                  Row(
                    children: [
                      // Botón Iniciar o Reanudar
                      Expanded(
                        child: ElevatedButton.icon(
                          style: _btnStyle(_milisegundos > 0 ? Colors.green : Colors.deepPurple),
                          onPressed: _isTimerRunning ? null : _iniciarTimer,
                          icon: Icon(_milisegundos > 0 ? Icons.play_circle_outline : Icons.play_arrow),
                          label: Text(_milisegundos > 0 ? "REANUDAR" : "INICIAR"),
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Botón Pausar
                      Expanded(
                        child: ElevatedButton.icon(
                          style: _btnStyle(Colors.orange),
                          onPressed: _isTimerRunning ? _pausarTimer : null,
                          icon: const Icon(Icons.pause),
                          label: const Text("PAUSAR"),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Botón Reiniciar
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 45),
                      foregroundColor: Colors.redAccent,
                      side: const BorderSide(color: Colors.redAccent),
                    ),
                    onPressed: _milisegundos > 0 ? _reiniciarTimer : null,
                    icon: const Icon(Icons.refresh),
                    label: const Text("REINICIAR"),
                  ),
                ],
              ),
            ),

            // SECCIÓN 3: ISOLATE
            _buildCard(
              title: "3. Isolate (Tarea Pesada)",
              icon: Icons.memory_rounded,
              color: Colors.teal,
              content: Column(
                children: [
                  Text(_isolateResult, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 15),
                  if (_isIsolateLoading) 
                    const Padding(padding: EdgeInsets.only(bottom: 15), child: CircularProgressIndicator()),
                  ElevatedButton.icon(
                    style: _btnStyle(Colors.teal),
                    onPressed: _isIsolateLoading ? null : _ejecutarIsolate,
                    icon: const Icon(Icons.rocket_launch),
                    label: const Text("LANZAR ISOLATE"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Estilos de Apoyo ---
  ButtonStyle _btnStyle(Color color) {
    return ElevatedButton.styleFrom(
      backgroundColor: color,
      foregroundColor: Colors.white,
      minimumSize: const Size(double.infinity, 50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  Widget _buildCard({required String title, required IconData icon, required Color color, required Widget content}) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: color.withOpacity(0.2), width: 1.5),
      ),
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 10),
                Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: color)),
              ],
            ),
            const Divider(height: 30),
            content,
          ],
        ),
      ),
    );
  }
}