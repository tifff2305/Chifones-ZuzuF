import '../models/sabor_model.dart';
import '../models/categoria_model.dart';

class CatalogoMockData {
  static final List<SaborModel> mockSabores = [
    SaborModel(id: 1, nombre: 'Maracuyá', categoria: 'Delux', precio: 28.50, activo: true, colorBorde: 'dorado'),
    SaborModel(id: 2, nombre: 'Limón', categoria: 'Tradicional', precio: 22.00, activo: true, colorBorde: 'verde'),
    SaborModel(id: 3, nombre: 'Naranja', categoria: 'Tradicional', precio: 25.00, activo: true, colorBorde: 'naranja'),
    SaborModel(id: 4, nombre: 'Tres Leches', categoria: 'Delux', precio: 35.00, activo: false, colorBorde: null),
    SaborModel(id: 5, nombre: 'Choco-Manjar', categoria: 'Delux', precio: 32.00, activo: true, colorBorde: null),
  ];

  static final List<CategoriaModel> mockCategorias = [
    CategoriaModel(id: 1, nombre: 'Delux', cantidad: 8, activo: true),
    CategoriaModel(id: 2, nombre: 'Tradicional', cantidad: 2, activo: true),
    CategoriaModel(id: 3, nombre: 'Día de la Madre', cantidad: 1, activo: true),
    CategoriaModel(id: 4, nombre: 'Especiales', cantidad: 0, activo: false),
  ];

  static SaborModel actualizarSaborLocal(SaborModel saborModificado) {
    final index = mockSabores.indexWhere((s) => s.id == saborModificado.id);
    if (index != -1) {
      mockSabores[index] = saborModificado;
    } else {
      mockSabores.add(saborModificado);
    }
    return saborModificado;
  }

  static CategoriaModel actualizarCategoriaLocal(CategoriaModel categoriaModificada) {
    final index = mockCategorias.indexWhere((c) => c.id == categoriaModificada.id);
    if (index != -1) {
      mockCategorias[index] = categoriaModificada;
    } else {
      mockCategorias.add(categoriaModificada);
    }
    return categoriaModificada;
  }
}
