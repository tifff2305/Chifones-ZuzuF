import 'package:flutter/material.dart';
import '../services/api_client.dart';

class AdminProvider with ChangeNotifier {
  final ApiClient apiClient;

  AdminProvider({required this.apiClient});

  // Variables de estado del Dashboard
  double _ventasHoy = 0.0;
  double _gastosHoy = 0.0;
  int _stockFaltante = 0;
  int _clientes = 0;

  bool _cargando = false;
  String? _error;
  String _vistaActiva = 'dashboard'; // 'dashboard', 'catalogo', etc.

  // Getters públicos
  double get ventasHoy => _ventasHoy;
  double get gastosHoy => _gastosHoy;
  int get stockFaltante => _stockFaltante;
  int get clientes => _clientes;
  bool get cargando => _cargando;
  String? get error => _error;
  String get vistaActiva => _vistaActiva;

  // Cambiar sub-vista activa del Tab 0
  void cambiarVista(String nuevaVista) {
    if (_vistaActiva != nuevaVista) {
      _vistaActiva = nuevaVista;
      notifyListeners();
    }
  }

  // Cargar datos de manera ficticia (simulada) o real llamando al backend
  Future<void> cargarDatosDashboard() async {
    _cargando = true;
    _error = null;
    notifyListeners();

    try {
      // Simulación de llamada a API (en producción se harían peticiones GET a endpoints como /orders y /inventory/alerts)
      await Future.delayed(const Duration(milliseconds: 800));

      // Asignar datos de prueba fieles a la operación de Chifones Zuzu
      _ventasHoy = 850.0; // 850 Bs en ventas hoy
      _gastosHoy = 120.0; // 120 Bs en insumos/combustible hoy
      _stockFaltante = 3;  // 3 Sabores o insumos bajo stock mínimo
      _clientes = 15;     // 15 Snacks/Clientes atendidos o activos hoy

      _cargando = false;
      notifyListeners();
    } catch (e) {
      _cargando = false;
      _error = 'Error al cargar los datos del dashboard: $e';
      notifyListeners();
    }
  }

  // Métodos setters manuales para actualizar en tiempo real
  void actualizarMetricas({
    double? ventas,
    double? gastos,
    int? stock,
    int? cantClientes,
  }) {
    if (ventas != null) _ventasHoy = ventas;
    if (gastos != null) _gastosHoy = gastos;
    if (stock != null) _stockFaltante = stock;
    if (cantClientes != null) _clientes = cantClientes;
    notifyListeners();
  }
}
