import 'package:flutter/material.dart';

class LoginMascota extends StatelessWidget {
  const LoginMascota({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF4A1A17);

    return Column(
      children: [
        const SizedBox(height: 30),
        SizedBox(
          height: 140,
          child: Image.asset(
            'assets/images/chifon_chef_waving.jpg',
            fit: BoxFit.contain,
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
