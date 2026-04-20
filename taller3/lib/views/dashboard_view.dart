import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Colombia Data'), centerTitle: true),
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: [
          _menuCard(context, 'Presidentes', Icons.person, Colors.blue, 'President'),
          _menuCard(context, 'Regiones', Icons.public, Colors.green, 'Region'),
          _menuCard(context, 'Atracciones', Icons.fort, Colors.orange, 'TouristicAttraction'),
          _menuCard(context, 'Departamentos', Icons.map, Colors.red, 'Department'),
        ],
      ),
    );
  }

  Widget _menuCard(BuildContext context, String title, IconData icon, Color color, String type) {
    return Card(
      child: InkWell(
        onTap: () => context.push('/list/$type'),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}