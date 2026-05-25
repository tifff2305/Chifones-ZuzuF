import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/catalogo_provider.dart';
import 'selector_tabs.dart';
import 'sabores_list.dart';
import 'categorias_list.dart';

class CatalogoCuerpo extends StatelessWidget {
  const CatalogoCuerpo({super.key});

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
    );
  }
}
