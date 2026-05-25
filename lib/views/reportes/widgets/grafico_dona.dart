import 'dart:math';
import 'package:flutter/material.dart';

class GraficoDona extends StatelessWidget {
  final Map<String, double> sabores;

  const GraficoDona({Key? key, required this.sabores}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF4A1A17);
    const colorGold = Color(0xFFD4AC0D);
    const colorGreen = Color(0xFF2ECC71);

    final valChoc = sabores['Chocochip'] ?? 50.0;
    final valMara = sabores['Maracuyá'] ?? 30.0;
    final valLim = sabores['Limón'] ?? 20.0;
    final total = valChoc + valMara + valLim;

    return Column(
      children: [
        SizedBox(
          height: 140,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: const Size(120, 120),
                painter: _DonaPainter(
                  valores: [valChoc, valMara, valLim],
                  colores: const [textDark, colorGold, colorGreen],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Total', style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.w600)),
                  Text(
                    total.toStringAsFixed(0),
                    style: const TextStyle(color: textDark, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildLegendItem(textDark, 'Chocochip', valChoc),
            _buildLegendItem(colorGold, 'Maracuyá', valMara),
            _buildLegendItem(colorGreen, 'Limón', valLim),
          ],
        ),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String name, double value) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(
          '$name (${value.toStringAsFixed(0)}%)',
          style: const TextStyle(color: Color(0xFF4A1A17), fontSize: 10.5, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class _DonaPainter extends CustomPainter {
  final List<double> valores;
  final List<Color> colores;

  _DonaPainter({required this.valores, required this.colores});

  @override
  void paint(Canvas canvas, Size size) {
    final double total = valores.fold(0, (sum, val) => sum + val);
    double startAngle = -pi / 2;

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 22.0
      ..isAntiAlias = true;

    final Rect rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: (size.width - 22) / 2,
    );

    for (int i = 0; i < valores.length; i++) {
      if (valores[i] == 0) continue;
      final double sweepAngle = (valores[i] / total) * 2 * pi;
      paint.color = colores[i];
      canvas.drawArc(rect, startAngle + 0.03, sweepAngle - 0.06, false, paint);
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
