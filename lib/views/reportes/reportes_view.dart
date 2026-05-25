import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/pedido_provider.dart';
import 'widgets/reporte_metricas.dart';
import 'widgets/grafico_barras.dart';
import 'widgets/grafico_dona.dart';
import 'widgets/reporte_descargas.dart';
import 'widgets/boton_grafico_selector.dart';

class ReportesView extends StatefulWidget {
  const ReportesView({Key? key}) : super(key: key);

  @override
  State<ReportesView> createState() => _ReportesViewState();
}

class _ReportesViewState extends State<ReportesView> {
  bool _verRendimiento = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PedidoProvider>().cargarPedidos();
    });
  }

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF4A1A17);
    const buttonRed = Color(0xFFE24C4C);

    return Consumer<PedidoProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator(color: buttonRed));
        }
        if (provider.error != null) {
          return Center(child: Text('Error: ${provider.error}', style: const TextStyle(color: textDark)));
        }
        final rep = provider.reporte;

        return SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReporteMetricas(reporte: rep),
              const SizedBox(height: 20),
              
              // Selector de Gráficos (Rendimiento vs Sabores)
              Row(
                children: [
                  Expanded(
                    child: BotonGraficoSelector(
                      icon: Icons.show_chart_rounded,
                      label: 'Rendimiento Mensual',
                      activo: _verRendimiento,
                      onTap: () => setState(() => _verRendimiento = true),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: BotonGraficoSelector(
                      icon: Icons.equalizer_rounded,
                      label: 'Sabores Preferidos',
                      activo: !_verRendimiento,
                      onTap: () => setState(() => _verRendimiento = false),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              
              // Gráfico Activo
              _verRendimiento 
                  ? GraficoBarras(rendimiento: rep.rendimientoMensual)
                  : GraficoDona(sabores: rep.saboresPreferidos),
              
              const SizedBox(height: 10),
              const ReporteDescargas(),
            ],
          ),
        );
      },
    );
  }
}
