class ReporteModel {
  final double ventasTotales;
  final double gastosTotales;
  final double utilidadNeta;
  final Map<String, double> rendimientoMensual; // ej: {"01": 1200, "02": 1500, ...}
  final Map<String, double> saboresPreferidos;  // ej: {"Chocochip": 50, "Maracuyá": 30, "Limón": 20}

  ReporteModel({
    required this.ventasTotales,
    required this.gastosTotales,
    required this.utilidadNeta,
    required this.rendimientoMensual,
    required this.saboresPreferidos,
  });

  factory ReporteModel.fromJson(Map<String, dynamic> json) {
    return ReporteModel(
      ventasTotales: (json['ventasTotales'] as num).toDouble(),
      gastosTotales: (json['gastosTotales'] as num).toDouble(),
      utilidadNeta: (json['utilidadNeta'] as num).toDouble(),
      rendimientoMensual: Map<String, double>.from(
        (json['rendimientoMensual'] as Map).map(
          (k, v) => MapEntry(k as String, (v as num).toDouble()),
        ),
      ),
      saboresPreferidos: Map<String, double>.from(
        (json['saboresPreferidos'] as Map).map(
          (k, v) => MapEntry(k as String, (v as num).toDouble()),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ventasTotales': ventasTotales,
      'gastosTotales': gastosTotales,
      'utilidadNeta': utilidadNeta,
      'rendimientoMensual': rendimientoMensual,
      'saboresPreferidos': saboresPreferidos,
    };
  }
}
