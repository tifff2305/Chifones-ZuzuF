import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/pedido_provider.dart';
import 'widgets/pedido_card.dart';

class PedidosView extends StatefulWidget {
  const PedidosView({Key? key}) : super(key: key);

  @override
  State<PedidosView> createState() => _PedidosViewState();
}

class _PedidosViewState extends State<PedidosView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PedidoProvider>().cargarPedidos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PedidoProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFFE24C4C),
            ),
          );
        }

        if (provider.error != null) {
          return Center(
            child: Text(
              'Error: ${provider.error}',
              style: const TextStyle(color: Color(0xFF4A1A17)),
            ),
          );
        }

        if (provider.pedidosHoy.isEmpty) {
          return const Center(
            child: Text(
              'No hay pedidos para hoy',
              style: TextStyle(color: Color(0xFF4A1A17), fontSize: 16),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 24.0, top: 8.0),
          itemCount: provider.pedidosHoy.length,
          itemBuilder: (context, index) {
            return PedidoCard(pedido: provider.pedidosHoy[index]);
          },
        );
      },
    );
  }
}
