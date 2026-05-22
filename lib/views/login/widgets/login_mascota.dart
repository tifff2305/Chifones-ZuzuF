import 'package:flutter/material.dart';

class LoginMascota extends StatelessWidget {
  const LoginMascota({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF4A1A17);

    return Column(
      children: [
        const SizedBox(height: 30),
        // Círculo contenedor de la mascota
        Container(
          width: 130,
          height: 130,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipOval(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.network(
                'https://raw.githubusercontent.com/antigravity-assets/mascot/main/chifon_chef.png',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.bakery_dining_rounded,
                    size: 70,
                    color: Color(0xFFD68A56),
                  );
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Título de Bienvenida
        const Text(
          '¡Bienvenido!',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: textDark,
          ),
        ),
        const SizedBox(height: 8),
        // Subtítulo
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Text(
            'Inicia sesión para disfrutar del mejor chifón peruano',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: textDark.withOpacity(0.65),
            ),
          ),
        ),
      ],
    );
  }
}
