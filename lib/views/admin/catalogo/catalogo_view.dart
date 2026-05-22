import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/catalogo_provider.dart';
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
    // Carga inicial del catálogo al montar la vista
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: textDark),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Catálogo',
          style: TextStyle(color: textDark, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: const SafeArea(
        child: _CatalogoCuerpoOrquestador(),
      ),
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
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
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
