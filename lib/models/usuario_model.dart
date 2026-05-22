class UsuarioModel {
  final int id;
  final String nombre;
  final String apellido;
  final String telefono;
  final String rol;

  UsuarioModel({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.telefono,
    required this.rol,
  });

  // Constructor factory para crear una instancia desde un JSON
  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    return UsuarioModel(
      id: json['id'] as int,
      nombre: json['nombre'] as String,
      apellido: json['apellido'] as String,
      telefono: json['telefono'] as String,
      rol: json['rol'] as String,
    );
  }

  // Método para convertir el modelo a un mapa JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'apellido': apellido,
      'telefono': telefono,
      'rol': rol,
    };
  }

  // Propiedad auxiliar para saber si es administrador
  bool get esAdmin => rol.toLowerCase() == 'admin' || rol.toLowerCase() == 'administrador';
}
