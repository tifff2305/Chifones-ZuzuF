import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminCabecera extends StatelessWidget {
  final String nombreAdmin;

  const AdminCabecera({
    Key? key,
    required this.nombreAdmin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF4A1A17);
    const buttonRed = Color(0xFFE24C4C);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Cabecera: Marca + Mini Logo
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'CHIFONES ZUZÚ',
              style: GoogleFonts.alfaSlabOne(
                fontSize: 26,
                letterSpacing: 0.5,
                color: textDark,
              ),
            ),
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: ClipOval(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Image.network(
                    'https://raw.githubusercontent.com/antigravity-assets/mascot/main/chifon_chef.png',
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.cookie_outlined, color: buttonRed);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        // Saludo Bienvenida
        Text(
          'Bienvenida, $nombreAdmin',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: textDark,
          ),
        ),
      ],
    );
  }
}
