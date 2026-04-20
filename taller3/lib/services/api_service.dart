import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/colombia_models.dart';

class ApiService {
  final String _baseUrl = dotenv.env['API_URL'] ?? '';

  Future<List<dynamic>> fetchList(String endpoint) async {
    final response = await http.get(Uri.parse('$_baseUrl/$endpoint'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      if (endpoint == 'President') {
        return data.map((e) => President.fromJson(e)).toList();
      }
      return data.map((e) => GenericItem.fromJson(e)).toList();
    } else {
      throw Exception('Fallo al cargar $endpoint');
    }
  }

  Future<Map<String, dynamic>> fetchDetail(String endpoint, String id) async {
    final response = await http.get(Uri.parse('$_baseUrl/$endpoint/$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Fallo al cargar detalle');
    }
  }
}