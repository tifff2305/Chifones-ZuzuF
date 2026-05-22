import 'package:flutter/material.dart';
import 'widgets/login_mascota.dart';
import 'widgets/login_formulario.dart';
import 'widgets/login_registro.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const backgroundPink = Color(0xFFFFF5F5);

    return Scaffold(
      backgroundColor: backgroundPink,
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 1. Cabecera con Mascota y Textos de Bienvenida
              LoginMascota(),
              SizedBox(height: 35),
              // 2. Tarjeta blanca con Formulario y opciones de registro
              _TarjetaContenedorBlanco(),
            ],
          ),
        ),
      ),
    );
  }
}

// Sub-widget interno para dar estructura a la sección inferior
class _TarjetaContenedorBlanco extends StatelessWidget {
  const _TarjetaContenedorBlanco();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -4),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(28.0, 40.0, 28.0, 10.0),
      child: const Column(
        children: [
          // Formulario con campos de texto y botón acceder
          FormularioLogin(),
          // Enlace de registro al final
          LoginRegistro(),
        ],
      ),
    );
  }
}
