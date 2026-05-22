class SaborModel {
  final int id;
  final String nombre;
  final String categoria;
  final double precio;
  final bool activo;
  final String? colorBorde; // "dorado", "verde", "naranja", o null

  SaborModel({
    required this.id,
    required this.nombre,
    required this.categoria,
    required this.precio,
    required this.activo,
    this.colorBorde,
  });

  SaborModel copyWith({
    int? id,
    String? nombre,
    String? categoria,
    double? precio,
    bool? activo,
    String? colorBorde,
  }) {
    return SaborModel(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      categoria: categoria ?? this.categoria,
      precio: precio ?? this.precio,
      activo: activo ?? this.activo,
      colorBorde: colorBorde ?? this.colorBorde,
    );
  }

  factory SaborModel.fromJson(Map<String, dynamic> json) {
    return SaborModel(
      id: json['id'] as int,
      nombre: json['nombre'] as String,
      categoria: json['categoria'] as String,
      precio: (json['precio'] as num).toDouble(),
      activo: json['activo'] as bool? ?? true,
      colorBorde: json['colorBorde'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'categoria': categoria,
      'precio': precio,
      'activo': activo,
      'colorBorde': colorBorde,
    };
  }
}
