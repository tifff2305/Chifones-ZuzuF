import 'package:flutter/material.dart';

class LoginRegistro extends StatelessWidget {
  const LoginRegistro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF4A1A17);
    const buttonRed = Color(0xFFE24C4C);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '¿No tienes cuenta? ',
            style: TextStyle(
              color: textDark.withOpacity(0.65),
              fontSize: 13,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: const Text(
              'Regístrate aquí',
              style: TextStyle(
                color: buttonRed,
                fontWeight: FontWeight.bold,
                fontSize: 13,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
