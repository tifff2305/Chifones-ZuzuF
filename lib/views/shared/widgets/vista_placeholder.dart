import 'package:flutter/material.dart';

class VistaPlaceholder extends StatelessWidget {
  final String titulo;
  final IconData icono;

  const VistaPlaceholder({
    Key? key,
    required this.titulo,
    required this.icono,
  }) : super(key: key);

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
