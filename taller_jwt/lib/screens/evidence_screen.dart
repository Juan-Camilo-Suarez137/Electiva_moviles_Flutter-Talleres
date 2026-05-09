import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';

class EvidenceScreen extends StatefulWidget {
  const EvidenceScreen({super.key});

  @override
  State<EvidenceScreen> createState() => _EvidenceScreenState();
}

class _EvidenceScreenState extends State<EvidenceScreen> {
  final AuthService _authService = AuthService();
  String _name = '';
  String _email = '';
  bool _hasToken = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final userData = await _authService.getUserData();
    final token = await _authService.getToken();

    setState(() {
      _name = userData['name'] ?? 'No disponible';
      _email = userData['email'] ?? 'No disponible';
      _hasToken = token != null && token.isNotEmpty;
      _isLoading = false;
    });
  }

  void _logout() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.logout();

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Evidencia Almacenamiento')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Datos leídos desde shared_preferences:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text('Nombre: $_name'),
            Text('Email: $_email'),
            const Divider(height: 32),
            const Text(
              'Estado del Token (flutter_secure_storage):',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  _hasToken ? Icons.check_circle : Icons.error,
                  color: _hasToken ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 8),
                Text(
                  _hasToken ? 'Token presente' : 'Sin token',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _logout,
                icon: const Icon(Icons.logout),
                label: const Text('Cerrar sesión'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade100,
                  foregroundColor: Colors.red.shade900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
