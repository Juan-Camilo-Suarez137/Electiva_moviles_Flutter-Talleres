import 'package:flutter/material.dart';
import '../services/api_service.dart';

class DetailView extends StatelessWidget {
  final String category;
  final String id;
  const DetailView({super.key, required this.category, required this.id});

  @override
  Widget build(BuildContext context) {
    final apiService = ApiService();

    return Scaffold(
      appBar: AppBar(title: const Text('Detalle')),
      body: FutureBuilder<Map<String, dynamic>>(
        future: apiService.fetchDetail(category, id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
          if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}'));

          final item = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (item['image'] != null) Image.network(item['image'], height: 200, width: double.infinity, fit: BoxFit.cover),
                const SizedBox(height: 20),
                Text(item['name'] ?? 'Sin nombre', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const Divider(),
                Text(item['description'] ?? 'No hay descripción disponible para este registro.', style: const TextStyle(fontSize: 16)),
              ],
            ),
          );
        },
      ),
    );
  }
}