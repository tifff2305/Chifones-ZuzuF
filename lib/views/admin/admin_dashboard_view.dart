import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/auth_provider.dart';
import '../../providers/admin_provider.dart';
import 'catalogo/catalogo_view.dart';
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
      // Pestaña 0: Panel Principal (Orquestado para intercambiar sub-vistas con Cabecera Global)
      _DashboardTabContent(adminNombre: adminNombre),
      
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

// Orquestador de la Pestaña 0 que mantiene la Cabecera de Marca como GLOBAL y fija en la parte superior
class _DashboardTabContent extends StatelessWidget {
  final String adminNombre;

  const _DashboardTabContent({required this.adminNombre});

  @override
  Widget build(BuildContext context) {
    final adminProvider = Provider.of<AdminProvider>(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Nav Superior / Cabecera de Marca GLOBAL fija
          const _GlobalHeaderMarca(),
          const SizedBox(height: 20),

          // 2. Contenido Dinámico que cambia bajo la Cabecera Global
          Expanded(
            child: _buildSubView(adminProvider.vistaActiva),
          ),
        ],
      ),
    );
  }

  Widget _buildSubView(String vista) {
    if (vista == 'catalogo') {
      return const CatalogoView();
    }
    // Por defecto: Métricas y Menú de Opciones
    return _DashboardPrincipalContent(adminNombre: adminNombre);
  }
}

// Cabecera de marca global (Fiel al nav superior de tu Mockup)
class _GlobalHeaderMarca extends StatelessWidget {
  const _GlobalHeaderMarca();

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF4A1A17);
    const buttonRed = Color(0xFFE24C4C);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'CHIFONES ZUZÚ',
          style: GoogleFonts.alfaSlabOne(
            fontSize: 26,
            letterSpacing: 0.5,
            color: textDark,
          ),
        ),
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 4,
              ),
            ],
          ),
          child: ClipOval(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image.network(
                'https://raw.githubusercontent.com/antigravity-assets/mascot/main/chifon_chef.png',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.cookie_outlined, color: buttonRed);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Cuerpo del Panel Principal (Métricas + Menú)
class _DashboardPrincipalContent extends StatelessWidget {
  final String adminNombre;

  const _DashboardPrincipalContent({required this.adminNombre});

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF4A1A17);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Saludo Bienvenida
          Text(
            'Bienvenida, $adminNombre',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: textDark,
            ),
          ),
          const SizedBox(height: 22),
          const AdminMetricas(),
          const SizedBox(height: 30),
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
