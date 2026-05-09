import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final String _baseUrl = 'https://parking.visiontic.com.co/api';
  final _storage = const FlutterSecureStorage();

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        // El token viene en data['access_token'] si seguimos estándar, o data['token']
        // Asumimos que la respuesta tiene { "token": "...", "user": { "name": "...", "email": "..." } }
        // Ajustar según la estructura real de la API de visiontic
        final String token = data['access_token'] ?? data['token'] ?? '';
        final user = data['user'] ?? {};
        final name = user['name'] ?? 'Usuario';
        final userEmail = user['email'] ?? email;

        await saveToken(token);
        await saveUserData(name, userEmail);

        return {'success': true, 'message': 'Login exitoso'};
      } else {
        final data = jsonDecode(response.body);
        return {'success': false, 'message': data['message'] ?? 'Error de autenticación'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Error de conexión: $e'};
    }
  }

  Future<void> saveToken(String token) async {
    await _storage.write(key: 'access_token', value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'access_token');
  }

  Future<void> saveUserData(String name, String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', name);
    await prefs.setString('user_email', email);
  }

  Future<Map<String, String?>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('user_name');
    final email = prefs.getString('user_email');
    return {'name': name, 'email': email};
  }

  Future<void> logout() async {
    await _storage.delete(key: 'access_token');
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_name');
    await prefs.remove('user_email');
  }
}
