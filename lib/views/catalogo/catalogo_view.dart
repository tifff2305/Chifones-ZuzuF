import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/catalogo_provider.dart';
import '../shared/widgets/cabecera_global.dart';
import '../shared/widgets/nav_bar_global.dart';
import 'widgets/selector_tabs.dart';
import 'widgets/sabores_list.dart';
import 'widgets/categorias_list.dart';

class CatalogoView extends StatefulWidget {
  const CatalogoView({super.key});

  @override
  State<CatalogoView> createState() => _CatalogoViewState();
}

class _CatalogoViewState extends State<CatalogoView> {
  @override
  void initState() {
    super.initState();
    // Carga los datos del catálogo de forma segura al inicializar la vista
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
              // 1. Cabecera Global compartida (fiel al diseño)
              const CabeceraGlobal(
                titulo: 'CHIFONES ZUZÚ',
              ),
              const SizedBox(height: 20),

              // 2. Fila de Retroceso estética "[<-] Catálogo" (llama a Navigator.pop)
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: textDark,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 10,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Text(
                    'Catálogo',
                    style: GoogleFonts.alfaSlabOne(
                      fontSize: 21,
                      letterSpacing: 0.5,
                      color: textDark,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // 3. Contenido del Catálogo
              Expanded(
                child: Consumer<CatalogoProvider>(
                  builder: (context, provider, child) {
                    if (provider.cargando && provider.sabores.isEmpty) {
                      return const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFE24C4C)),
                        ),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: () => provider.cargarCatalogo(),
                      color: const Color(0xFFE24C4C),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Selector de Sabores / Categorías modular
                          SelectorTabs(
                            activeTab: provider.activeTab,
                            onTabChanged: (tab) => provider.cambiarTab(tab),
                          ),
                          const SizedBox(height: 16),

                          // Contenido scrolleable
                          Expanded(
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Column(
                                children: [
                                  if (provider.activeTab == 'sabores')
                                    SaboresList(
                                      sabores: provider.sabores,
                                      onToggleActivo: (sabor) => provider.toggleSaborActivo(sabor),
                                    )
                                  else
                                    CategoriasList(
                                      categorias: provider.categorias,
                                      onToggleActivo: (categoria) => provider.toggleCategoriaActiva(categoria),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      // 4. Barra de navegación inferior global
      bottomNavigationBar: NavBarGlobal(
        pestanaActual: 0, // El catálogo pertenece al flujo de la pestaña de inicio (0)
        iconos: const [
          Icons.home_rounded,
          Icons.shopping_bag_outlined,
          Icons.bar_chart_rounded,
          Icons.person_outline_rounded,
        ],
        alCambiarPestana: (indice) {
          // Si cambias de pestaña, regresas al dashboard principal
          Navigator.of(context).pop();
        },
      ),
    );
  }
}