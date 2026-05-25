import 'package:flutter/material.dart';
import '../../../models/reporte_model.dart';

class ReporteMetricas extends StatelessWidget {
  final ReporteModel reporte;

  const ReporteMetricas({Key? key, required this.reporte}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF4A1A17);
    const colorGreenBg = Color(0xFFE2F9EB);
    const colorGreen = Color(0xFF2ECC71);
    const colorRedBg = Color(0xFFFFECEC);
    const colorRed = Color(0xFFE24C4C);
    const colorYellowBg = Color(0xFFFFF9E3);
    const colorYellow = Color(0xFFF1C40F);

    return Row(
      children: [
        // Box 1: Ventas Totales
        Expanded(
          child: _MetricCard(
            title: 'Ventas totales',
            value: 'Bs ${reporte.ventasTotales.toStringAsFixed(0)}',
            colorBg: colorGreenBg,
            colorContent: colorGreen,
            iconWidget: const Icon(
              Icons.trending_up_rounded,
              color: colorGreen,
              size: 20,
            ),
          ),
        ),
        const SizedBox(width: 8),
        
        // Box 2: Gastos Totales
        Expanded(
          child: _MetricCard(
            title: 'Gastos totales',
            value: 'Bs ${reporte.gastosTotales.toStringAsFixed(0)}',
            colorBg: colorRedBg,
            colorContent: colorRed,
            iconWidget: const Text(
              'Bs',
              style: TextStyle(
                color: colorRed,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        
        // Box 3: Utilidad Neta
        Expanded(
          child: _MetricCard(
            title: 'Utilidad neta',
            value: 'Bs ${reporte.utilidadNeta.toStringAsFixed(0)}',
            colorBg: colorYellowBg,
            colorContent: textDark,
            iconWidget: const Icon(
              Icons.credit_card_outlined,
              color: colorYellow,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final Color colorBg;
  final Color colorContent;
  final Widget iconWidget;

  const _MetricCard({
    required this.title,
    required this.value,
    required this.colorBg,
    required this.colorContent,
    required this.iconWidget,
  });

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF4A1A17);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 4.0),
      decoration: BoxDecoration(
        color: colorBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorBg.withOpacity(0.6),
          width: 1.0,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconWidget,
          const SizedBox(height: 6),
          Text(
            title,
            style: TextStyle(
              color: colorContent.withOpacity(0.8),
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: textDark,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
