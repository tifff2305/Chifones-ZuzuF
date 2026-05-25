import 'package:flutter/material.dart';
import '../../../../models/sabor_model.dart';
import '../editar_sabor_view.dart';

class SaboresList extends StatelessWidget {
  final List<SaborModel> sabores;
  final Function(SaborModel) onToggleActivo;

  const SaboresList({
    super.key,
    required this.sabores,
    required this.onToggleActivo,
  });

  @override
  Widget build(BuildContext context) {
    if (sabores.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Text(
            'No hay sabores registrados.',
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: sabores.length,
      itemBuilder: (context, index) {
        return _SaborCard(
          sabor: sabores[index],
          onToggleActivo: onToggleActivo,
        );
      },
    );
  }
}

class _SaborCard extends StatelessWidget {
  final SaborModel sabor;
  final Function(SaborModel) onToggleActivo;

  const _SaborCard({
    required this.sabor,
    required this.onToggleActivo,
  });

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF4A1A17);
    const buttonRed = Color(0xFFE24C4C);

    return Container(
      margin: const EdgeInsets.only(bottom: 14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        // 🌟 Borde gris sutil unificado
        border: Border.all(color: Colors.grey.shade100, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.015),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Detalles del Sabor
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sabor.nombre,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: textDark,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      // Badge de la Categoría
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: buttonRed.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          sabor.categoria,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: buttonRed,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // 🌟 Moneda local corregida a Bolivianos
                      Text(
                        '${sabor.precio.toStringAsFixed(2)} Bs',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: textDark.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Acciones del Sabor (Switch de activar y botón de editar)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Switch(
                  value: sabor.activo,
                  activeColor: buttonRed,
                  activeTrackColor: buttonRed.withOpacity(0.2),
                  inactiveThumbColor: Colors.grey.shade400,
                  inactiveTrackColor: Colors.grey.shade200,
                  onChanged: (_) => onToggleActivo(sabor),
                ),
                const SizedBox(width: 2),
                IconButton(
                  icon: const Icon(Icons.edit_rounded, color: buttonRed, size: 22),
                  tooltip: 'Editar sabor',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EditarSaborView(sabor: sabor),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}