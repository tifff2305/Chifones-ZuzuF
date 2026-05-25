import 'dart:convert';
import '../models/sabor_model.dart';
import '../models/categoria_model.dart';
import 'api_client.dart';
import 'catalogo_mock_data.dart';

class CatalogoService {
  final ApiClient apiClient;

  CatalogoService({required this.apiClient});

  // Obtener todos los sabores
  Future<List<SaborModel>> obtenerSabores() async {
    try {
      final response = await apiClient.get('/sabores');
      if (response.statusCode == 200) {
        final List<dynamic> body = jsonDecode(response.body);
        return body.map((dynamic item) => SaborModel.fromJson(item as Map<String, dynamic>)).toList();
      }
      return CatalogoMockData.mockSabores;
    } catch (_) {
      return List.from(CatalogoMockData.mockSabores);
    }
  }

  // Actualizar un sabor
  Future<SaborModel> actualizarSabor(SaborModel sabor) async {
    try {
      final response = await apiClient.post('/sabores/actualizar', sabor.toJson());
      if (response.statusCode == 200 || response.statusCode == 201) {
        return SaborModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      }
      return CatalogoMockData.actualizarSaborLocal(sabor);
    } catch (_) {
      return CatalogoMockData.actualizarSaborLocal(sabor);
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
      return CatalogoMockData.mockCategorias;
    } catch (_) {
      return List.from(CatalogoMockData.mockCategorias);
    }
  }

  // Actualizar una categoría
  Future<CategoriaModel> actualizarCategoria(CategoriaModel categoria) async {
    try {
      final response = await apiClient.post('/categorias/actualizar', categoria.toJson());
      if (response.statusCode == 200 || response.statusCode == 201) {
        return CategoriaModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      }
      return CatalogoMockData.actualizarCategoriaLocal(categoria);
    } catch (_) {
      return CatalogoMockData.actualizarCategoriaLocal(categoria);
    }
  }
}
