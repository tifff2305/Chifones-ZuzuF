import 'usuario_model.dart';

class LoginResponse {
  final String accessToken;
  final UsuarioModel usuario;

  LoginResponse({
    required this.accessToken,
    required this.usuario,
  });

  // Constructor factory para crear una instancia desde el JSON de respuesta de la API
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['access_token'] as String,
      usuario: UsuarioModel.fromJson(json['usuario'] as Map<String, dynamic>),
    );
  }

  // Método para convertir a mapa JSON
  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'usuario': usuario.toJson(),
    };
  }
}
