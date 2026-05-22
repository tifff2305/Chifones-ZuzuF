import 'package:flutter/material.dart';
import '../models/usuario_model.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService;

  AuthProvider({required AuthService authService}) : _authService = authService;

  // Variables de estado interno
  UsuarioModel? _usuario;
  String? _token;
  bool _cargando = false;
  String? _error;
  bool _recordarCredenciales = false;

  // Getters públicos para acceder al estado desde los Widgets
  UsuarioModel? get usuario => _usuario;
  String? get token => _token;
  bool get cargando => _cargando;
  String? get error => _error;
  bool get estaAutenticado => _usuario != null;
  bool get recordarCredenciales => _recordarCredenciales;

  // Cambiar el valor de recordar credenciales
  void setRecordarCredenciales(bool valor) {
    _recordarCredenciales = valor;
    notifyListeners();
  }

  // Limpiar cualquier mensaje de error anterior
  void limpiarError() {
    _error = null;
    notifyListeners();
  }

  // Acción: Realizar el login y actualizar el estado
  Future<bool> login(String telefono, String password) async {
    _cargando = true;
    _error = null;
    notifyListeners(); // Notifica a la UI para mostrar el indicador de carga

    try {
      final response = await _authService.login(telefono, password);
      
      _usuario = response.usuario;
      _token = response.accessToken;
      _cargando = false;
      
      notifyListeners(); // Notifica que el usuario está logueado con éxito
      return true;
    } catch (e) {
      _cargando = false;
      // Remover el prefijo 'Exception: ' para mostrar un mensaje amigable
      _error = e.toString().replaceAll('Exception: ', '');
      
      notifyListeners(); // Notifica el error a la UI
      return false;
    }
  }

  // Acción: Cerrar sesión
  Future<void> logout() async {
    await _authService.logout();
    _usuario = null;
    _token = null;
    _error = null;
    notifyListeners(); // Notifica para redirigir al login
  }
}
