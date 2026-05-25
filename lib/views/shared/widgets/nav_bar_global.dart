import 'package:flutter/material.dart';

class NavBarGlobal extends StatelessWidget {
  final int pestanaActual;
  final ValueChanged<int> alCambiarPestana;
  final List<IconData> iconos;

  const NavBarGlobal({
    Key? key,
    required this.pestanaActual,
    required this.alCambiarPestana,
    required this.iconos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(iconos.length, (indice) => _construirItem(indice, iconos[indice])),
      ),
    );
  }

  Widget _construirItem(int indice, IconData icono) {
    const colorRojo = Color(0xFFE24C4C);
    final seleccionado = pestanaActual == indice;

    return GestureDetector(
      onTap: () => alCambiarPestana(indice),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: seleccionado ? colorRojo : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(
          icono,
          size: 26,
          color: seleccionado ? Colors.white : Colors.grey.shade400,
        ),
      ),
    );
  }
}