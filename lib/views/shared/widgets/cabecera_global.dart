import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CabeceraGlobal extends StatelessWidget {
  final String titulo;
  final String? saludo;
  final String rutaImagenMascota;

  const CabeceraGlobal({
    Key? key,
    required this.titulo,
    this.saludo,
    this.rutaImagenMascota = 'assets/images/chifon_chef_whisk.jpg',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const colorOscuro = Color(0xFF4A1A17);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center, // Alinea el texto y la imagen al centro verticalmente
          children: [
            Text(
              titulo,
              style: GoogleFonts.alfaSlabOne(
                fontSize: 24,
                letterSpacing: 0.5,
                color: colorOscuro,
              ),
            ),
            
            // Ahora la imagen de la mascota está completamente suelta y transparente.
            Image.asset(
              rutaImagenMascota,
              height: 62, // 🚀 Ajusta este número si quieres que la mascota sea más grande o pequeña
              fit: BoxFit.contain,
            ),
          ],
        ),
        if (saludo != null) ...[
          const SizedBox(height: 6),
          Text(
            saludo!,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: colorOscuro,
            ),
          ),
        ],
      ],
    );
  }
}