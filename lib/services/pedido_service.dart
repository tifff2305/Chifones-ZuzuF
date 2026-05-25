import 'dart:convert';
import '../models/pedido_model.dart';
import 'api_client.dart';

class PedidoService {
  final ApiClient apiClient;

  PedidoService({required this.apiClient});

  static final List<PedidoModel> mockPedidos = [
    PedidoModel(
      id: 1,
      cliente: 'Sra Amalia',
      categoria: 'Preferencial',
      items: ['2 Chocochip', '1 Chocomani'],
      total: 200,
      fecha: DateTime.now(),
      estadoPedido: 'pendiente',
    ),
    PedidoModel(
      id: 2,
      cliente: 'Sra Ana',
      categoria: 'Activo',
      items: ['2 Chocochip', '1 Chocomani'],
      total: 200,
      fecha: DateTime.now(),
      estadoPedido: 'pendiente',
    ),
    PedidoModel(
      id: 3,
      cliente: 'Sr Saul',
      categoria: 'Activo',
      items: ['1 Chocomani'],
      total: 85,
      fecha: DateTime.now(),
      estadoPedido: 'pendiente',
    ),
    PedidoModel(
      id: 4,
      cliente: 'Comercio',
      categoria: 'Activo',
      items: ['2 Chocochip', 'Promoción - Limón'],
      total: 100,
      fecha: DateTime.now(),
      estadoPedido: 'pendiente',
    ),
    PedidoModel(
      id: 5,
      cliente: 'Dayana',
      categoria: 'Activo',
      items: ['2 Chocochip', 'Promoción - Limón'],
      total: 100,
      fecha: DateTime.now(),
      estadoPedido: 'pendiente',
    ),
  ];

  Future<List<PedidoModel>> obtenerPedidos() async {
    try {
      final response = await apiClient.get('/pedidos');
      if (response.statusCode == 200) {
        final List<dynamic> body = jsonDecode(response.body);
        return body.map((dynamic item) => PedidoModel.fromJson(item as Map<String, dynamic>)).toList();
      }
      return mockPedidos;
    } catch (_) {
      return List.from(mockPedidos);
    }
  }

  Future<bool> registrarPago(int pedidoId, String tipoPago) async {
    try {
      final response = await apiClient.post('/pagos', {
        'pedidoId': pedidoId,
        'tipoPago': tipoPago,
      });
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (_) {
      return false;
    }
  }
}
