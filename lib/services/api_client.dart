import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  // En producción se usa la IP del servidor. Para emulador Android se suele usar 10.0.2.2, para iOS localhost.
  final String baseUrl;
  String? _token;

  ApiClient({
    this.baseUrl = 'http://192.168.43.11:3000/api', // URL base por defecto del backend NestJS
  });

  // Guardar el token tras un login exitoso
  void setToken(String token) {
    _token = token;
  }

  // Limpiar el token al cerrar sesión
  void clearToken() {
    _token = null;
  }

  // Generar headers comunes
  Map<String, String> _getHeaders() {
    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    };
    if (_token != null) {
      headers['Authorization'] = 'Bearer $_token';
    }
    return headers;
  }

  // Método POST genérico
  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse('$baseUrl$endpoint');
    try {
      final response = await http.post(
        url,
        headers: _getHeaders(),
        body: jsonEncode(body),
      );
      return response;
    } catch (e) {
      throw Exception('Error de conexión a la red: No se pudo conectar al servidor.');
    }
  }

  // Método GET genérico (para endpoints protegidos del admin y snacks)
  Future<http.Response> get(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint');
    try {
      final response = await http.get(
        url,
        headers: _getHeaders(),
      );
      return response;
    } catch (e) {
      throw Exception('Error de conexión a la red: No se pudo conectar al servidor.');
    }
  }
}
