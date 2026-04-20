import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/api_service.dart';

class ListViewPage extends StatelessWidget {
  final String category;
  const ListViewPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final apiService = ApiService();

    return Scaffold(
      appBar: AppBar(title: Text('Lista de $category')),
      body: FutureBuilder<List<dynamic>>(
        future: apiService.fetchList(category),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}'));

          final data = snapshot.data!;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];
              return ListTile(
                title: Text(item.name),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => context.push('/detail/$category/${item.id}'),
              );
            },
          );
        },
      ),
    );
  }
}