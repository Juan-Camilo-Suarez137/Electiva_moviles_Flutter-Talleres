import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taller 1',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String titulo = "La Orden Jedi";

  // --- PALETA DE COLORES DEL LADO OSCURO ---
  final Color sithBlack = const Color(0xFF050505); 
  final Color sithRed = const Color(0xFFD50000); 
  final Color empireGrey = const Color(0xFF1A1A1C); 
  final Color textDim = const Color(0xFFB0B0B0); 

  void cambiarTitulo() {
    setState(() {
      titulo = titulo == "La Orden Jedi" 
          ? "¡El Imperio domina!" 
          : "La Orden Jedi";
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Orden 66 Ejecutada", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
        backgroundColor: sithRed, // SnackBar rojo sangre
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> items = [
      {"image": "assets/anakinstar.jpg", "title": "Darth Vader/Anakin Skywalker", "subtitle": "Lord Sith"}, 
      {"image": "assets/ippo.jpg", "title": "Ippo", "subtitle": "Hajime no Ippo"},
      {"image": "assets/vegetta.jpg", "title": "Vegetta", "subtitle": "Dragon Ball Z"}, 
    ];

    return Scaffold(
      backgroundColor: sithBlack,
      appBar: AppBar(
        title: Text(
          titulo,
          style: TextStyle(
            color: sithRed,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.5, 
          ),
        ),
        centerTitle: true,
        backgroundColor: sithBlack, 
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: sithRed.withOpacity(0.3), 
            height: 1.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 200, 
              child: Image.network(
                "https://img.asmedia.epimg.net/resizer/v2/5HSJBDQIHZBJ7N7SBK6WRU54SA.jpg?auth=252eb580d16e341be04bf74894e26ca59d02064eef5b146e0c2346f6654899e0&width=644&height=362&smart=true",
                fit: BoxFit.cover, 
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: empireGrey,
                    child: const Center(
                      child: Text("Transmisión interceptada por el Imperio", style: TextStyle(color: Colors.redAccent)),
                    ),
                  );
                },
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    elevation: 10,
                    color: empireGrey, 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: sithRed.withOpacity(0.6), width: 1.5), 
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(
                            "Juan Camilo Suarez Holguin",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "230231027 - Aprendiz Sith", 
                            style: TextStyle(
                              fontSize: 16,
                              color: sithRed,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  
                  ElevatedButton(
                    onPressed: cambiarTitulo,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: sithRed, 
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), 
                      ),
                      elevation: 8,
                      shadowColor: sithRed.withOpacity(0.8), 
                    ),
                    child: const Text(
                      "Sucumbir al Lado Oscuro",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                    ),
                  ),
                  const SizedBox(height: 30),
                  
                  //  WIDGET ADICIONAL 1 
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: sithBlack,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: sithRed, width: 2), 
                      boxShadow: [
                        BoxShadow(
                          color: sithRed.withOpacity(0.15), 
                          blurRadius: 15,
                          spreadRadius: 2,
                        )
                      ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.local_fire_department, color: sithRed, size: 30), 
                        const SizedBox(width: 12),
                        const Text(
                          "Conoce el poder del Lado Oscuro",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  
                  Text(
                    "Mis Personajes Favoritos",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: sithRed,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // WIDGET ADICIONAL 2
                  Card(
                    elevation: 4,
                    color: empireGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: items.length, 
                      separatorBuilder: (context, index) => const Divider(
                        color: Colors.white12, 
                        indent: 16,
                        endIndent: 16,
                      ),
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: sithRed, width: 1.5), 
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.asset(
                                items[index]["image"] as String,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: sithBlack,
                                    child: const Icon(
                                      Icons.person_off,
                                      color: Colors.white24,
                                      size: 30,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          title: Text(
                            items[index]["title"] as String,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white, 
                            ),
                          ),
                          subtitle: Text(
                            items[index]["subtitle"] as String,
                            style: TextStyle(color: textDim), 
                          ),
                          trailing: Icon(Icons.arrow_forward_ios, size: 14, color: sithRed), // Flecha roja
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}