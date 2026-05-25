import 'package:flutter/material.dart';

class ReporteDescargas extends StatelessWidget {
  const ReporteDescargas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF4A1A17);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Reportes y Descargas',
          style: TextStyle(
            color: textDark,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        _buildDescargaItem(context, 'Ranking de Fidelidad'),
        _buildDescargaItem(context, 'Sabores Preferidos'),
        _buildDescargaItem(context, 'Otros'),
      ],
    );
  }

  Widget _buildDescargaItem(BuildContext context, String titulo) {
    const textDark = Color(0xFF4A1A17);
    const buttonRed = Color(0xFFE24C4C);

    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.015),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(
          color: const Color(0xFFF6E2E2),
          width: 1.0,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
        leading: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFFECEC),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.picture_as_pdf_outlined,
            color: buttonRed,
            size: 20,
          ),
        ),
        title: Text(
          titulo,
          style: TextStyle(
            color: textDark.withOpacity(0.4),
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right_rounded,
          color: buttonRed,
          size: 20,
        ),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Descargando $titulo...'),
              backgroundColor: buttonRed,
            ),
          );
        },
      ),
    );
  }
}
