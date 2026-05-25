import 'package:flutter/material.dart';

class GraficoBarras extends StatelessWidget {
  final Map<String, double> rendimiento;

  const GraficoBarras({Key? key, required this.rendimiento}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const colorRed = Color(0xFFE24C4C);

    final maxVal = rendimiento.values.isEmpty 
        ? 1.0 
        : rendimiento.values.reduce((a, b) => a > b ? a : b);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Column(
        children: [
          SizedBox(
            height: 160,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: rendimiento.entries.map((entry) {
                final double alturaProporcional = (entry.value / maxVal) * 95;
                final bool esMaximo = entry.value == maxVal;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (esMaximo) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.grey.shade300, width: 0.5),
                        ),
                        child: Text(
                          'Bs ${entry.value.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 8.5,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                    ],
                    Container(
                      width: 24,
                      height: alturaProporcional,
                      decoration: BoxDecoration(
                        color: colorRed,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(6),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      entry.key,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
