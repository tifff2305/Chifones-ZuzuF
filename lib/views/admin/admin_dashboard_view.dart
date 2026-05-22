import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import 'widgets/admin_cabecera.dart';
import 'widgets/admin_metricas.dart';
import 'widgets/admin_menu.dart';
import 'widgets/admin_nav_bar.dart';

class AdminDashboardView extends StatefulWidget {
  const AdminDashboardView({super.key});

  @override
  State<AdminDashboardView> createState() => _AdminDashboardViewState();
}

class _AdminDashboardViewState extends State<AdminDashboardView> {
  int _currentTab = 0;

  @override
  Widget build(BuildContext context) {
    const backgroundPink = Color(0xFFFFF5F5);
    final authProvider = Provider.of<AuthProvider>(context);
    final adminNombre = authProvider.usuario?.nombre ?? 'Tifanny';

    // Definición de las 4 vistas globales del Nav Bar
    final List<Widget> vistas = [
      // Pestaña 0: Panel Principal (El código de tu vista actual sin modificar)
      _DashboardPrincipal(adminNombre: adminNombre),
      
      // Pestaña 1: Pedidos / Tienda
      const _VistaPlaceholder(titulo: 'Pedidos / Snacks', icono: Icons.shopping_bag_outlined),
      
      // Pestaña 2: Reportes
      const _VistaPlaceholder(titulo: 'Reportes y Estadísticas', icono: Icons.bar_chart_rounded),
      
      // Pestaña 3: Perfil / Cuenta
      const _VistaPlaceholder(titulo: 'Perfil del Admin', icono: Icons.person_outline_rounded),
    ];

    return Scaffold(
      backgroundColor: backgroundPink,
      body: SafeArea(
        child: IndexedStack(
          index: _currentTab,
          children: vistas,
        ),
      ),
      bottomNavigationBar: AdminNavBar(
        currentTab: _currentTab,
        onTabSelected: (index) => setState(() => _currentTab = index),
      ),
    );
  }
}

// Sub-widget que encapsula exactamente tu vista original para mantener el código actual sin modificaciones
class _DashboardPrincipal extends StatelessWidget {
  final String adminNombre;

  const _DashboardPrincipal({required this.adminNombre});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AdminCabecera(nombreAdmin: adminNombre),
          const SizedBox(height: 25),
          const AdminMetricas(),
          const SizedBox(height: 35),
          const AdminMenu(),
        ],
      ),
    );
  }
}

// Widget estético para las demás vistas globales asociadas al Nav Bar
class _VistaPlaceholder extends StatelessWidget {
  final String titulo;
  final IconData icono;

  const _VistaPlaceholder({
    required this.titulo,
    required this.icono,
  });

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF4A1A17);
    const buttonRed = Color(0xFFE24C4C);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: buttonRed.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icono,
                size: 64,
                color: buttonRed,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              titulo,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: textDark,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Esta sección se integrará próximamente con tu backend de Chifones Zuzu.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: textDark.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
