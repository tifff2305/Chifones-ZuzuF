import 'package:flutter/material.dart';
import '../models/sabor_model.dart';
import '../models/categoria_model.dart';
import '../services/catalogo_service.dart';

class CatalogoProvider with ChangeNotifier {
  final CatalogoService catalogoService;

  List<SaborModel> _sabores = [];
  List<CategoriaModel> _categorias = [];
  bool _cargando = false;
  String? _error;
  String _activeTab = 'sabores'; // 'sabores' o 'categorias'

  CatalogoProvider({required this.catalogoService});

  // Getters públicos
  List<SaborModel> get sabores => _sabores;
  List<CategoriaModel> get categorias => _categorias;
  bool get cargando => _cargando;
  String? get error => _error;
  String get activeTab => _activeTab;

  // Cambiar pestaña activa
  void cambiarTab(String tab) {
    if (_activeTab != tab) {
      _activeTab = tab;
      notifyListeners();
    }
  }

  // Cargar datos del catálogo
  Future<void> cargarCatalogo() async {
    _cargando = true;
    _error = null;
    notifyListeners();

    try {
      final nuevosSabores = await catalogoService.obtenerSabores();
      final nuevasCategorias = await catalogoService.obtenerCategorias();
      _sabores = nuevosSabores;
      _categorias = nuevasCategorias;
    } catch (e) {
      _error = 'Ocurrió un error al cargar el catálogo.';
    } finally {
      _cargando = false;
      notifyListeners();
    }
  }

  // Activar/desactivar sabor optimista
  Future<void> toggleSaborActivo(SaborModel sabor) async {
    final nuevoSabor = sabor.copyWith(activo: !sabor.activo);
    
    // Actualización optimista
    final index = _sabores.indexWhere((s) => s.id == sabor.id);
    if (index != -1) {
      _sabores[index] = nuevoSabor;
      notifyListeners();
    }

    try {
      await catalogoService.actualizarSabor(nuevoSabor);
    } catch (_) {
      // Revertir si falla
      if (index != -1) {
        _sabores[index] = sabor;
        notifyListeners();
      }
    }
  }

  // Activar/desactivar categoría optimista
  Future<void> toggleCategoriaActiva(CategoriaModel categoria) async {
    final nuevaCategoria = categoria.copyWith(activo: !categoria.activo);

    // Actualización optimista
    final index = _categorias.indexWhere((c) => c.id == categoria.id);
    if (index != -1) {
      _categorias[index] = nuevaCategoria;
      notifyListeners();
    }

    try {
      await catalogoService.actualizarCategoria(nuevaCategoria);
    } catch (_) {
      // Revertir si falla
      if (index != -1) {
        _categorias[index] = categoria;
        notifyListeners();
      }
    }
  }

  // Guardar cambios al editar sabor
  Future<bool> guardarSabor(SaborModel saborModificado) async {
    _cargando = true;
    notifyListeners();

    try {
      final guardado = await catalogoService.actualizarSabor(saborModificado);
      
      final index = _sabores.indexWhere((s) => s.id == guardado.id);
      if (index != -1) {
        _sabores[index] = guardado;
      } else {
        _sabores.add(guardado);
      }
      return true;
    } catch (e) {
      _error = 'No se pudo guardar la modificación del sabor.';
      return false;
    } finally {
      _cargando = false;
      notifyListeners();
    }
  }
}
