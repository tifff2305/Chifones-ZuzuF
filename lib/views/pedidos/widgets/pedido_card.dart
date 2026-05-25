import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/pedido_model.dart';
import '../../../providers/pedido_provider.dart';

class PedidoCard extends StatelessWidget {
  final PedidoModel pedido;

  const PedidoCard({Key? key, required this.pedido}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF4A1A17);
    final esPendiente = pedido.estadoPedido == 'pendiente';

    return Container(
      margin: const EdgeInsets.only(bottom: 14.0),
      height: 125,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.0),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.015), blurRadius: 6.0, offset: const Offset(0, 3))],
        border: Border.all(color: const Color(0xFFF6E2E2), width: 1.0),
      ),
      child: Row(
        children: [
          Container(
            width: 10,
            decoration: BoxDecoration(
              color: esPendiente ? textDark : const Color(0xFF2ECC71),
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(18.0), bottomLeft: Radius.circular(18.0)),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14.0, 10.0, 14.0, 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(pedido.cliente, style: const TextStyle(color: textDark, fontSize: 15, fontWeight: FontWeight.bold)),
                      _buildStatusBadge(),
                    ],
                  ),
                  const Text('Detalle del pedido:', style: TextStyle(color: Colors.grey, fontSize: 11)),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4.0, top: 1.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: pedido.items.take(2).map((i) => Text('• $i', style: const TextStyle(color: textDark, fontSize: 10.5, fontWeight: FontWeight.w500))).toList(),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total: Bs ${pedido.total.toStringAsFixed(0)}', style: const TextStyle(color: textDark, fontSize: 13, fontWeight: FontWeight.bold)),
                      if (esPendiente) _buildAccionesPago(context) else _buildPagoCompletadoLabel(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge() {
    final esPendiente = pedido.estadoPedido == 'pendiente';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      decoration: BoxDecoration(
        color: esPendiente ? const Color(0xFFFFD8C9) : const Color(0xFFE2F9EB),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        esPendiente ? pedido.categoria : '✓ Pagado',
        style: TextStyle(color: esPendiente ? const Color(0xFF8A3D35) : const Color(0xFF2ECC71), fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildAccionesPago(BuildContext context) {
    return Row(
      children: [
        _buildBotonPago(context, '💵 Efec', 'efectivo'),
        const SizedBox(width: 6),
        _buildBotonPago(context, '📱 QR', 'transferencia'),
      ],
    );
  }

  Widget _buildBotonPago(BuildContext context, String label, String tipo) {
    return InkWell(
      onTap: () async {
        final messenger = ScaffoldMessenger.of(context);
        final exito = await context.read<PedidoProvider>().registrarPago(pedido.id, tipo);
        messenger.showSnackBar(SnackBar(
          content: Text(exito ? 'Pago registrado con éxito' : 'Pago guardado localmente'),
          backgroundColor: const Color(0xFFE24C4C),
          duration: const Duration(seconds: 1),
        ));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(border: Border.all(color: const Color(0xFFE24C4C)), borderRadius: BorderRadius.circular(6.0)),
        child: Text(label, style: const TextStyle(color: Color(0xFFE24C4C), fontSize: 10.5, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildPagoCompletadoLabel() {
    final metodo = pedido.tipoPago == 'transferencia' ? 'QR' : 'Efectivo';
    return Text(
      'Cobrado con $metodo',
      style: const TextStyle(color: Color(0xFF2ECC71), fontSize: 11, fontWeight: FontWeight.bold),
    );
  }
}
