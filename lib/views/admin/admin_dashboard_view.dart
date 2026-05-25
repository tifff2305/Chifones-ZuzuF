import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../views/shared/widgets/base_layout.dart';
import '../../views/shared/widgets/vista_placeholder.dart';
import '../pedidos/pedidos_view.dart';
import '../reportes/reportes_view.dart';
import 'widgets/admin_metricas.dart';
import 'widgets/admin_menu.dart';

class AdminDashboardView extends StatelessWidget {
  const AdminDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final adminNombre = authProvider.usuario?.nombre ?? 'Tifanny';

    // Definición de las 4 vistas globales del Nav Bar
    final List<Widget> vistas = [
      // Pestaña 0: Panel Principal
      _DashboardPrincipalContent(adminNombre: adminNombre),
      
      // Pestaña 1: Pedidos / Tienda
      const PedidosView(),
      
      // Pestaña 2: Reportes
      const ReportesView(),
      
      // Pestaña 3: Perfil / Cuenta
      const VistaPlaceholder(titulo: 'Perfil del Admin', icono: Icons.person_outline_rounded),
    ];

    // Usando el BaseLayout genérico de la carpeta shared creado por el usuario
    return BaseLayout(
      pantallas: vistas,
      iconosNavBar: const [
        Icons.home_rounded,
        Icons.shopping_bag_outlined,
        Icons.bar_chart_rounded,
        Icons.person_outline_rounded,
      ],
      tituloCabecera: 'CHIFONES ZUZÚ',
      saludoCabecera: 'Bienvenida, $adminNombre',
    );
  }
}

// Cuerpo del Panel Principal (Métricas + Menú)
class _DashboardPrincipalContent extends StatelessWidget {
  final String adminNombre;

  const _DashboardPrincipalContent({required this.adminNombre});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          AdminMetricas(),
          SizedBox(height: 30),
          AdminMenu(),
        ],
      ),
    );
  }
}