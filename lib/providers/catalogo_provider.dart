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
  String _activeTab = 'sabores';

  CatalogoProvider({required this.catalogoService});

  List<SaborModel> get sabores => _sabores;
  List<CategoriaModel> get categorias => _categorias;
  bool get cargando => _cargando;
  String? get error => _error;
  String get activeTab => _activeTab;

  void cambiarTab(String tab) {
    if (_activeTab != tab) {
      _activeTab = tab;
      notifyListeners();
    }
  }

  Future<void> cargarCatalogo() async {
    _cargando = true;
    _error = null;
    notifyListeners();

    try {
      _sabores = await catalogoService.obtenerSabores();
      _categorias = await catalogoService.obtenerCategorias();
    } catch (e) {
      _error = 'Ocurrió un error al cargar el catálogo.';
    } finally {
      _cargando = false;
      notifyListeners();
    }
  }

  Future<void> toggleSaborActivo(SaborModel sabor) async {
    final nuevoSabor = sabor.copyWith(activo: !sabor.activo);
    final index = _sabores.indexWhere((s) => s.id == sabor.id);
    if (index == -1) return;
    
    _sabores[index] = nuevoSabor;
    notifyListeners();

    try {
      await catalogoService.actualizarSabor(nuevoSabor);
    } catch (_) {
      _sabores[index] = sabor;
      notifyListeners();
    }
  }

  Future<void> toggleCategoriaActiva(CategoriaModel categoria) async {
    final nuevaCategoria = categoria.copyWith(activo: !categoria.activo);
    final index = _categorias.indexWhere((c) => c.id == categoria.id);
    if (index == -1) return;

    _categorias[index] = nuevaCategoria;
    notifyListeners();

    try {
      await catalogoService.actualizarCategoria(nuevaCategoria);
    } catch (_) {
      _categorias[index] = categoria;
      notifyListeners();
    }
  }

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
