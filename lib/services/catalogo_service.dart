import 'dart:convert';
import '../models/sabor_model.dart';
import '../models/categoria_model.dart';
import 'api_client.dart';

class CatalogoService {
  final ApiClient apiClient;

  // Mock data stateful local por si falla la conexión
  static final List<SaborModel> _mockSabores = [
    SaborModel(id: 1, nombre: 'Maracuyá', categoria: 'Delux', precio: 28.50, activo: true, colorBorde: 'dorado'),
    SaborModel(id: 2, nombre: 'Limón', categoria: 'Tradicional', precio: 22.00, activo: true, colorBorde: 'verde'),
    SaborModel(id: 3, nombre: 'Naranja', categoria: 'Tradicional', precio: 25.00, activo: true, colorBorde: 'naranja'),
    SaborModel(id: 4, nombre: 'Tres Leches', categoria: 'Delux', precio: 35.00, activo: false, colorBorde: null),
    SaborModel(id: 5, nombre: 'Choco-Manjar', categoria: 'Delux', precio: 32.00, activo: true, colorBorde: null),
  ];

  static final List<CategoriaModel> _mockCategorias = [
    CategoriaModel(id: 1, nombre: 'Delux', cantidad: 8, activo: true),
    CategoriaModel(id: 2, nombre: 'Tradicional', cantidad: 2, activo: true),
    CategoriaModel(id: 3, nombre: 'Día de la Madre', cantidad: 1, activo: true),
    CategoriaModel(id: 4, nombre: 'Especiales', cantidad: 0, activo: false),
  ];

  CatalogoService({required this.apiClient});

  // Obtener todos los sabores
  Future<List<SaborModel>> obtenerSabores() async {
    try {
      final response = await apiClient.get('/sabores');
      if (response.statusCode == 200) {
        final List<dynamic> body = jsonDecode(response.body);
        return body.map((dynamic item) => SaborModel.fromJson(item as Map<String, dynamic>)).toList();
      }
      return _mockSabores;
    } catch (_) {
      // Fallback automático al mock local en caso de error de red
      return List.from(_mockSabores);
    }
  }

  // Actualizar un sabor
  Future<SaborModel> actualizarSabor(SaborModel sabor) async {
    try {
      final response = await apiClient.post('/sabores/actualizar', sabor.toJson());
      if (response.statusCode == 200 || response.statusCode == 201) {
        return SaborModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      }
      // Actualizar localmente en mock
      return _actualizarSaborLocal(sabor);
    } catch (_) {
      // Fallback automático
      return _actualizarSaborLocal(sabor);
    }
  }

  // Obtener todas las categorías
  Future<List<CategoriaModel>> obtenerCategorias() async {
    try {
      final response = await apiClient.get('/categorias');
      if (response.statusCode == 200) {
        final List<dynamic> body = jsonDecode(response.body);
        return body.map((dynamic item) => CategoriaModel.fromJson(item as Map<String, dynamic>)).toList();
      }
      return _mockCategorias;
    } catch (_) {
      // Fallback automático al mock local en caso de error de red
      return List.from(_mockCategorias);
    }
  }

  // Actualizar una categoría
  Future<CategoriaModel> actualizarCategoria(CategoriaModel categoria) async {
    try {
      final response = await apiClient.post('/categorias/actualizar', categoria.toJson());
      if (response.statusCode == 200 || response.statusCode == 201) {
        return CategoriaModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      }
      return _actualizarCategoriaLocal(categoria);
    } catch (_) {
      return _actualizarCategoriaLocal(categoria);
    }
  }

  // Métodos auxiliares para actualizar mock localmente
  SaborModel _actualizarSaborLocal(SaborModel saborModificado) {
    final index = _mockSabores.indexWhere((s) => s.id == saborModificado.id);
    if (index != -1) {
      _mockSabores[index] = saborModificado;
    } else {
      _mockSabores.add(saborModificado);
    }
    return saborModificado;
  }

  CategoriaModel _actualizarCategoriaLocal(CategoriaModel categoriaModificada) {
    final index = _mockCategorias.indexWhere((c) => c.id == categoriaModificada.id);
    if (index != -1) {
      _mockCategorias[index] = categoriaModificada;
    } else {
      _mockCategorias.add(categoriaModificada);
    }
    return categoriaModificada;
  }
}
