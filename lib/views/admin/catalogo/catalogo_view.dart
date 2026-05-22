import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/catalogo_provider.dart';
import '../../../providers/admin_provider.dart';
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
    // Cargar catálogo inicial al montar
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CatalogoProvider>(context, listen: false).cargarCatalogo();
    });
  }

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF4A1A17);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Fila de Retroceso estética "[<-] Catálogo" fiel a tu Mockup
        Row(
          children: [
            GestureDetector(
              onTap: () {
                Provider.of<AdminProvider>(context, listen: false).cambiarVista('dashboard');
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: textDark,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
            const SizedBox(width: 14),
            const Text(
              'Catálogo',
              style: TextStyle(
                color: textDark,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        
        // Cuerpo principal del Catálogo
        const Expanded(
          child: _CatalogoCuerpoOrquestador(),
        ),
      ],
    );
  }
}

// Sub-widget orquestador del cuerpo principal para cumplir con la restricción de build ultralimpio
class _CatalogoCuerpoOrquestador extends StatelessWidget {
  const _CatalogoCuerpoOrquestador();

  @override
  Widget build(BuildContext context) {
    return Consumer<CatalogoProvider>(
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
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 8.0), // Padding vertical limpio sin duplicación horizontal
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Selector de Sabores / Categorías modular
                SelectorTabs(
                  activeTab: provider.activeTab,
                  onTabChanged: (tab) => provider.cambiarTab(tab),
                ),
                const SizedBox(height: 16),

                // Lista de sabores o categorías según corresponda
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
        );
      },
    );
  }
}
