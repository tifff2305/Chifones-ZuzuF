import 'package:flutter/material.dart';
import '../models/pedido_model.dart';
import '../models/reporte_model.dart';
import '../services/pedido_service.dart';

class PedidoProvider extends ChangeNotifier {
  final PedidoService _pedidoService;
  List<PedidoModel> _pedidos = [];
  bool _isLoading = false;
  String? _error;

  PedidoProvider({required PedidoService pedidoService}) : _pedidoService = pedidoService;

  List<PedidoModel> get pedidos => _pedidos;
  bool get isLoading => _isLoading;
  String? get error => _error;

  List<PedidoModel> get pedidosHoy {
    final hoy = DateTime.now();
    return _pedidos.where((p) =>
      p.fecha.year == hoy.year &&
      p.fecha.month == hoy.month &&
      p.fecha.day == hoy.day
    ).toList();
  }

  Future<void> cargarPedidos() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _pedidos = await _pedidoService.obtenerPedidos();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> registrarPago(int pedidoId, String tipoPago) async {
    final success = await _pedidoService.registrarPago(pedidoId, tipoPago);
    final index = _pedidos.indexWhere((p) => p.id == pedidoId);
    if (index != -1) {
      _pedidos[index] = _pedidos[index].copyWith(
        estadoPedido: 'pagado',
        tipoPago: tipoPago,
      );
      notifyListeners();
    }
    return success;
  }

  ReporteModel get reporte {
    final ventas = _pedidos.fold(0.0, (sum, p) => sum + p.total);
    final gastos = ventas * 0.16;
    final Map<String, double> rendimiento = {
      '01': 1500.0, '02': 2200.0, '03': 3800.0, '04': 3200.0, '05': 0.0, '06': 0.0
    };
    for (final p in _pedidos) {
      final mesKey = p.fecha.month.toString().padLeft(2, '0');
      rendimiento[mesKey] = (rendimiento[mesKey] ?? 0.0) + p.total;
    }
    double chocochipCant = 0, maracuyaCant = 0, limonCant = 0;
    for (final p in _pedidos) {
      for (final item in p.items) {
        int cant = 1;
        String saborName = item.toLowerCase();
        final match = RegExp(r'^(\d+)\s+(.*)$').firstMatch(item);
        if (match != null) {
          cant = int.tryParse(match.group(1) ?? '1') ?? 1;
          saborName = (match.group(2) ?? '').toLowerCase();
        }
        if (saborName.contains('chocochip') || saborName.contains('chocomani')) {
          chocochipCant += cant;
        } else if (saborName.contains('maracuyá') || saborName.contains('maracuya')) {
          maracuyaCant += cant;
        } else if (saborName.contains('limón') || saborName.contains('limon') || saborName.contains('naranja')) {
          limonCant += cant;
        } else {
          chocochipCant += cant;
        }
      }
    }
    double totalSabs = chocochipCant + maracuyaCant + limonCant;
    Map<String, double> saboresDist = {
      'Chocochip': 50.0, 'Maracuyá': 30.0, 'Limón': 20.0
    };
    if (totalSabs > 0) {
      saboresDist = {
        'Chocochip': (chocochipCant / totalSabs) * 100,
        'Maracuyá': (maracuyaCant / totalSabs) * 100,
        'Limón': (limonCant / totalSabs) * 100,
      };
    }
    return ReporteModel(
      ventasTotales: ventas,
      gastosTotales: gastos,
      utilidadNeta: ventas - gastos,
      rendimientoMensual: rendimiento,
      saboresPreferidos: saboresDist,
    );
  }
}
