import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/sabor_model.dart';
import '../../../providers/catalogo_provider.dart';

class EditarSaborView extends StatefulWidget {
  final SaborModel sabor;

  const EditarSaborView({
    super.key,
    required this.sabor,
  });

  @override
  State<EditarSaborView> createState() => _EditarSaborViewState();
}

class _EditarSaborViewState extends State<EditarSaborView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nombreController;
  late TextEditingController _precioController;
  late String _categoriaSeleccionada;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.sabor.nombre);
    _precioController = TextEditingController(text: widget.sabor.precio.toStringAsFixed(2));
    _categoriaSeleccionada = widget.sabor.categoria;
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _precioController.dispose();
    super.dispose();
  }

  Future<void> _guardar(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    final provider = Provider.of<CatalogoProvider>(context, listen: false);
    
    final saborModificado = widget.sabor.copyWith(
      nombre: _nombreController.text.trim(),
      precio: double.parse(_precioController.text),
      categoria: _categoriaSeleccionada,
    );

    final success = await provider.guardarSabor(saborModificado);

    if (context.mounted) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sabor guardado correctamente.'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(provider.error ?? 'Error al guardar el sabor.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF4A1A17);
    const backgroundPink = Color(0xFFFFF5F5);

    return Scaffold(
      backgroundColor: backgroundPink,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: textDark),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Editar Sabor',
          style: TextStyle(
            color: textDark,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Consumer<CatalogoProvider>(
          builder: (context, provider, child) {
            return Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        
                        // Inputs del Formulario
                        _buildLabel('Nombre del Sabor'),
                        _buildNombreField(),
                        const SizedBox(height: 20),

                        _buildLabel('Precio (S/.)'),
                        _buildPrecioField(),
                        const SizedBox(height: 20),

                        _buildLabel('Categoría'),
                        _buildCategoriaDropdown(provider),
                        const SizedBox(height: 40),

                        // Botón de Guardar Redondeado Rojo Premium
                        _buildGuardarButton(context),
                      ],
                    ),
                  ),
                ),
                if (provider.cargando)
                  Container(
                    color: Colors.black.withOpacity(0.3),
                    child: const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFE24C4C)),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    const textDark = Color(0xFF4A1A17);
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: textDark,
        ),
      ),
    );
  }

  Widget _buildNombreField() {
    return TextFormField(
      controller: _nombreController,
      style: const TextStyle(fontWeight: FontWeight.w500),
      decoration: _buildInputDecoration('Ej. Maracuyá imperial'),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Por favor ingresa un nombre para el sabor';
        }
        return null;
      },
    );
  }

  Widget _buildPrecioField() {
    return TextFormField(
      controller: _precioController,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      style: const TextStyle(fontWeight: FontWeight.w500),
      decoration: _buildInputDecoration('Ej. 28.50'),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Por favor ingresa un precio';
        }
        if (double.tryParse(value) == null) {
          return 'Ingresa un valor decimal válido (ej. 28.50)';
        }
        if (double.parse(value) <= 0) {
          return 'El precio debe ser mayor a 0';
        }
        return null;
      },
    );
  }

  Widget _buildCategoriaDropdown(CatalogoProvider provider) {
    const textDark = Color(0xFF4A1A17);

    // Obtener nombres de categoría disponibles del provider, o usar fallback si está vacío
    final listaCategorias = provider.categorias.map((c) => c.nombre).toList();
    if (!listaCategorias.contains(_categoriaSeleccionada)) {
      listaCategorias.add(_categoriaSeleccionada);
    }
    if (listaCategorias.isEmpty) {
      listaCategorias.addAll(['Delux', 'Tradicional', 'Día de la Madre']);
    }

    return DropdownButtonFormField<String>(
      value: _categoriaSeleccionada,
      style: const TextStyle(fontWeight: FontWeight.w500, color: textDark, fontSize: 16),
      decoration: _buildInputDecoration('Selecciona categoría'),
      dropdownColor: Colors.white,
      items: listaCategorias.map((String cat) {
        return DropdownMenuItem<String>(
          value: cat,
          child: Text(cat),
        );
      }).toList(),
      onChanged: (String? nuevoValor) {
        if (nuevoValor != null) {
          setState(() {
            _categoriaSeleccionada = nuevoValor;
          });
        }
      },
    );
  }

  Widget _buildGuardarButton(BuildContext context) {
    const buttonRed = Color(0xFFE24C4C);
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonRed,
          foregroundColor: Colors.white,
          elevation: 2,
          shadowColor: buttonRed.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(27),
          ),
        ),
        onPressed: () => _guardar(context),
        child: const Text(
          'Guardar Cambios',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String hintText) {
    const buttonRed = Color(0xFFE24C4C);
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.grey.shade200, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: buttonRed, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
    );
  }
}
