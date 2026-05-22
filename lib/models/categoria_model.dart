class CategoriaModel {
  final int id;
  final String nombre;
  final int cantidad;
  final bool activo;

  CategoriaModel({
    required this.id,
    required this.nombre,
    required this.cantidad,
    required this.activo,
  });

  CategoriaModel copyWith({
    int? id,
    String? nombre,
    int? cantidad,
    bool? activo,
  }) {
    return CategoriaModel(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      cantidad: cantidad ?? this.cantidad,
      activo: activo ?? this.activo,
    );
  }

  factory CategoriaModel.fromJson(Map<String, dynamic> json) {
    return CategoriaModel(
      id: json['id'] as int,
      nombre: json['nombre'] as String,
      cantidad: json['cantidad'] as int? ?? 0,
      activo: json['activo'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'cantidad': cantidad,
      'activo': activo,
    };
  }
}
