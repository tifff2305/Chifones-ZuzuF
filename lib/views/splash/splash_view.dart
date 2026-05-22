import 'dart:async';
import 'package:flutter/material.dart';
import '../login/login_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // 1. Configurar animación de desvanecimiento (Fade In)
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _animationController.forward();

    // 2. Temporizador para navegar al Login después de 2.8 segundos
    Timer(const Duration(milliseconds: 2800), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const LoginView(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 650),
        ),
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Paleta de colores premium basada en los chifones Zuzu
    const primarySalmon = Color(0xFFFF8B8B);
    const darkBrown = Color(0xFF4A1A17);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: primarySalmon,
        ),
        child: Stack(
          children: [
            // Onda decorativa en la parte superior
            Positioned(
              top: -50,
              left: -50,
              child: CustomPaint(
                size: const Size(300, 300),
                painter: WavePainter(color: Colors.white.withOpacity(0.12)),
              ),
            ),
            // Onda decorativa en la parte inferior
            Positioned(
              bottom: -80,
              right: -80,
              child: CustomPaint(
                size: const Size(350, 350),
                painter: WavePainter(color: Colors.white.withOpacity(0.15)),
              ),
            ),
            // Contenido Central animado
            Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Nombre de la Marca
                      Text(
                        'CHIFONES',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2.0,
                          color: darkBrown,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'ZUZU',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2.0,
                          color: darkBrown,
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Lema Inspiracional
                      Text(
                        '"No es mi fuerza, es la gracia de Dios"',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600,
                          color: darkBrown.withOpacity(0.85),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Pintor de ondas vectoriales para fondo estético premium
class WavePainter extends CustomPainter {
  final Color color;

  WavePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.4);
    
    // Curvas Bezier estéticas
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.2,
      size.width * 0.5,
      size.height * 0.4,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.6,
      size.width,
      size.height * 0.35,
    );
    
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
