import 'dart:convert';
import '../models/login_response.dart';
import 'api_client.dart';

class AuthService {
  final ApiClient apiClient;

  AuthService({required this.apiClient});

  // Realizar el login en el backend
  Future<LoginResponse> login(String telefono, String password) async {
    // 1. Envía la petición HTTP a través de ApiClient
    final response = await apiClient.post(
      '/autenticacion/login',
      {
        'telefono': telefono,
        'password': password,
      },
    );

    // 2. Verifica si la respuesta es exitosa (200 OK)
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      
      // Deserialización: Convierte el JSON en Modelo de Dart
      final loginResponse = LoginResponse.fromJson(responseData);
      
      // Guardar el token en el cliente HTTP para futuras peticiones autenticadas
      apiClient.setToken(loginResponse.accessToken);
      
      return loginResponse;
    } else {
      // 3. Si hay un error HTTP, deserializar el mensaje de error del backend
      try {
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        final dynamic mensaje = errorData['message'];
        
        if (mensaje is List) {
          // Si NestJS devuelve una lista de errores de validación de class-validator
          throw Exception(mensaje.join('\n'));
        } else if (mensaje is String) {
          throw Exception(mensaje);
        } else {
          throw Exception('Las credenciales de acceso son incorrectas.');
        }
      } catch (e) {
        // En caso de que la respuesta no sea JSON válido
        if (response.statusCode == 401) {
          throw Exception('Las credenciales de acceso son incorrectas.');
        } else {
          throw Exception('Error del servidor (${response.statusCode}). Por favor intente más tarde.');
        }
      }
    }
  }

  // Cerrar sesión
  Future<void> logout() async {
    apiClient.clearToken();
  }
}
