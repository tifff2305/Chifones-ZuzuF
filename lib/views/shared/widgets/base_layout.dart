import 'package:flutter/material.dart';
import 'cabecera_global.dart';
import 'nav_bar_global.dart';

class BaseLayout extends StatefulWidget {
  final List<Widget> pantallas;
  final List<IconData> iconosNavBar;
  final String tituloCabecera;
  final String? saludoCabecera;
  final bool mostrarCabecera;

  const BaseLayout({
    Key? key,
    required this.pantallas,
    required this.iconosNavBar,
    required this.tituloCabecera,
    this.saludoCabecera,
    this.mostrarCabecera = true,
  }) : super(key: key);

  @override
  State<BaseLayout> createState() => _BaseLayoutState();
}

class _BaseLayoutState extends State<BaseLayout> {
  int _pestanaActual = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.mostrarCabecera) ...[
                CabeceraGlobal(
                  titulo: widget.tituloCabecera,
                  saludo: widget.saludoCabecera,
                ),
                const SizedBox(height: 20),
              ],
              Expanded(
                child: IndexedStack(
                  index: _pestanaActual,
                  children: widget.pantallas,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavBarGlobal(
        pestanaActual: _pestanaActual,
        iconos: widget.iconosNavBar,
        alCambiarPestana: (indice) {
          setState(() {
            _pestanaActual = indice;
          });
        },
      ),
    );
  }
}