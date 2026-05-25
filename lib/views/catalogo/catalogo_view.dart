import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/catalogo_provider.dart';
import '../shared/widgets/cabecera_global.dart';
import '../shared/widgets/nav_bar_global.dart';
import 'widgets/catalogo_cuerpo.dart';

class CatalogoView extends StatefulWidget {
  const CatalogoView({super.key});

  @override
  State<CatalogoView> createState() => _CatalogoViewState();
}

class _CatalogoViewState extends State<CatalogoView> {
  @override
  void initState() {
    super.initState();
    // Carga los datos del catálogo de forma segura al inicializar
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CatalogoProvider>(context, listen: false).cargarCatalogo();
    });
  }

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF4A1A17);
    const backgroundPink = Color(0xFFFFF5F5);

    return Scaffold(
      backgroundColor: backgroundPink,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Cabecera Global compartida
              const CabeceraGlobal(titulo: 'CHIFONES ZUZÚ'),
              const SizedBox(height: 20),

              // 2. Fila de Retroceso estética "[<-] Catálogo"
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: textDark,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 11,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Text(
                    'Catálogo',
                    style: GoogleFonts.alfaSlabOne(
                      fontSize: 20,
                      letterSpacing: 0.5,
                      color: textDark,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // 3. Contenido del Catálogo
              const Expanded(
                child: CatalogoCuerpo(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavBarGlobal(
        pestanaActual: 0,
        iconos: const [
          Icons.home_rounded,
          Icons.shopping_bag_outlined,
          Icons.bar_chart_rounded,
          Icons.person_outline_rounded,
        ],
        alCambiarPestana: (indice) => Navigator.of(context).pop(),
      ),
    );
  }
}