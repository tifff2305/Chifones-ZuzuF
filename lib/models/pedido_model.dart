class PedidoModel {
  final int id;
  final String cliente;
  final String categoria; // "Preferencial" o "Activo"
  final List<String> items;
  final double total;
  final bool activo;
  final DateTime fecha;
  final String estadoPedido; // "pendiente" o "pagado"
  final String? tipoPago; // "efectivo", "tarjeta", "transferencia"

  PedidoModel({
    required this.id,
    required this.cliente,
    required this.categoria,
    required this.items,
    required this.total,
    this.activo = true,
    required this.fecha,
    this.estadoPedido = 'pendiente',
    this.tipoPago,
  });

  PedidoModel copyWith({
    int? id,
    String? cliente,
    String? categoria,
    List<String>? items,
    double? total,
    bool? activo,
    DateTime? fecha,
    String? estadoPedido,
    String? tipoPago,
  }) {
    return PedidoModel(
      id: id ?? this.id,
      cliente: cliente ?? this.cliente,
      categoria: categoria ?? this.categoria,
      items: items ?? this.items,
      total: total ?? this.total,
      activo: activo ?? this.activo,
      fecha: fecha ?? this.fecha,
      estadoPedido: estadoPedido ?? this.estadoPedido,
      tipoPago: tipoPago ?? this.tipoPago,
    );
  }

  factory PedidoModel.fromJson(Map<String, dynamic> json) {
    // 1. Get client name
    String clientName = 'Cliente';
    if (json['usuario'] != null) {
      final String nom = json['usuario']['nombre'] ?? '';
      final String ape = json['usuario']['apellido'] ?? '';
      clientName = '$nom $ape'.trim();
      if (clientName.isEmpty) {
        clientName = 'Cliente';
      }
    } else if (json['cliente'] != null) {
      clientName = json['cliente'] as String;
    }

    // 2. Parse items
    List<String> itemsList = [];
    if (json['detalles'] != null) {
      itemsList = (json['detalles'] as List).map((dynamic d) {
        final Map<String, dynamic> detail = d as Map<String, dynamic>;
        final cant = detail['cantidad'] ?? 1;
        final prodName = detail['producto'] != null ? detail['producto']['nombre'] : 'Producto';
        return '$cant $prodName';
      }).toList();
    } else if (json['items'] != null) {
      itemsList = List<String>.from(json['items'] as List);
    }

    // 3. Determine category
    String cat = 'Activo';
    if (json['categoria'] != null) {
      cat = json['categoria'] as String;
    } else if (clientName.contains('Amalia')) {
      cat = 'Preferencial';
    }

    // 4. Parse total
    double tot = 0.0;
    if (json['totalPedido'] != null) {
      tot = double.tryParse(json['totalPedido'].toString()) ?? 0.0;
    } else if (json['total'] != null) {
      tot = (json['total'] as num).toDouble();
    }

    return PedidoModel(
      id: json['id'] as int,
      cliente: clientName,
      categoria: cat,
      items: itemsList,
      total: tot,
      activo: json['activo'] as bool? ?? true,
      fecha: json['fecha'] != null ? DateTime.parse(json['fecha'] as String) : DateTime.now(),
      estadoPedido: json['estadoPedido'] as String? ?? 'pendiente',
      tipoPago: json['tipoPago'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cliente': cliente,
      'categoria': categoria,
      'items': items,
      'total': total,
      'activo': activo,
      'fecha': fecha.toIso8601String(),
      'estadoPedido': estadoPedido,
      'tipoPago': tipoPago,
    };
  }
}
