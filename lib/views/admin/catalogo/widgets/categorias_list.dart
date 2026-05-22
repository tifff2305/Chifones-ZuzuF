import 'package:flutter/material.dart';
import '../../../../models/categoria_model.dart';

class CategoriasList extends StatelessWidget {
  final List<CategoriaModel> categorias;
  final Function(CategoriaModel) onToggleActivo;

  const CategoriasList({
    super.key,
    required this.categorias,
    required this.onToggleActivo,
  });

  @override
  Widget build(BuildContext context) {
    if (categorias.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Text(
            'No hay categorías registradas.',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categorias.length,
      itemBuilder: (context, index) {
        return _CategoriaCard(
          categoria: categorias[index],
          onToggleActivo: onToggleActivo,
        );
      },
    );
  }
}

class _CategoriaCard extends StatelessWidget {
  final CategoriaModel categoria;
  final Function(CategoriaModel) onToggleActivo;

  const _CategoriaCard({
    required this.categoria,
    required this.onToggleActivo,
  });

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF4A1A17);
    const buttonRed = Color(0xFFE24C4C);

    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade100, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.015),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Row(
          children: [
            // Icono / Círculo de la categoría
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: buttonRed.withOpacity(0.06),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.folder_open_rounded,
                color: buttonRed,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),

            // Nombre y cantidad de la categoría
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    categoria.nombre,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: textDark,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'Sabores en esta categoría: ${categoria.cantidad}',
                    style: TextStyle(
                      fontSize: 13,
                      color: textDark.withOpacity(0.55),
                    ),
                  ),
                ],
              ),
            ),

            // Interruptor activo/inactivo
            Switch(
              value: categoria.activo,
              activeColor: buttonRed,
              activeTrackColor: buttonRed.withOpacity(0.2),
              inactiveThumbColor: Colors.grey.shade400,
              inactiveTrackColor: Colors.grey.shade200,
              onChanged: (_) => onToggleActivo(categoria),
            ),
          ],
        ),
      ),
    );
  }
}
