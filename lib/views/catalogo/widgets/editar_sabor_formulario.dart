import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../models/sabor_model.dart';
import '../../../../providers/catalogo_provider.dart';
import '../../shared/widgets/custom_text_field.dart';
import '../../shared/widgets/custom_dropdown_field.dart';

class EditarSaborFormulario extends StatefulWidget {
  final SaborModel sabor;

  const EditarSaborFormulario({
    Key? key,
    required this.sabor,
  }) : super(key: key);

  @override
  State<EditarSaborFormulario> createState() => _EditarSaborFormularioState();
}

class _EditarSaborFormularioState extends State<EditarSaborFormulario> {
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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(success ? 'Sabor guardado correctamente.' : (provider.error ?? 'Error al guardar.')),
        backgroundColor: success ? Colors.green : Colors.red,
      ));
      if (success) Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CatalogoProvider>(context);
    final listaCategorias = provider.categorias.map((c) => c.nombre).toList();
    if (!listaCategorias.contains(_categoriaSeleccionada)) {
      listaCategorias.add(_categoriaSeleccionada);
    }
    if (listaCategorias.isEmpty) {
      listaCategorias.addAll(['Delux', 'Tradicional', 'Día de la Madre']);
    }

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          CustomTextField(
            controller: _nombreController,
            labelText: 'Nombre del Sabor',
            hintText: 'Ej. Maracuyá imperial',
            validator: (value) => (value == null || value.trim().isEmpty) ? 'Ingresa un nombre para el sabor' : null,
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: _precioController,
            labelText: 'Precio (Bs)',
            hintText: 'Ej. 28.50',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: (value) {
              if (value == null || value.trim().isEmpty) return 'Ingresa un precio';
              if (double.tryParse(value) == null) return 'Ingresa un decimal válido';
              if (double.parse(value) <= 0) return 'Debe ser mayor a 0';
              return null;
            },
          ),
          const SizedBox(height: 20),
          CustomDropdownField<String>(
            value: _categoriaSeleccionada,
            labelText: 'Categoría',
            items: listaCategorias.map((cat) => DropdownMenuItem(value: cat, child: Text(cat))).toList(),
            onChanged: (val) {
              if (val != null) setState(() => _categoriaSeleccionada = val);
            },
          ),
          const SizedBox(height: 40),
          _buildGuardarButton(context),
        ],
      ),
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(27)),
        ),
        onPressed: () => _guardar(context),
        child: const Text('Guardar Cambios', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
