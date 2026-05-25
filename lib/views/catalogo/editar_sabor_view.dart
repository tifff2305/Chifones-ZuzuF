import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/sabor_model.dart';
import '../../providers/catalogo_provider.dart';
import '../shared/widgets/cabecera_global.dart';
import '../shared/widgets/nav_bar_global.dart';
import 'widgets/editar_sabor_formulario.dart';

class EditarSaborView extends StatelessWidget {
  final SaborModel sabor;

  const EditarSaborView({
    super.key,
    required this.sabor,
  });

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF4A1A17);
    const backgroundPink = Color(0xFFFFF5F5);

    return Scaffold(
      backgroundColor: backgroundPink,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Cabecera Global compartida
              const CabeceraGlobal(titulo: 'CHIFONES ZUZÚ'),
              const SizedBox(height: 20),

              // 2. Fila de Retroceso estética "[<-] Editar Sabor"
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: textDark,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 11,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Text(
                    'Editar Sabor',
                    style: GoogleFonts.alfaSlabOne(
                      fontSize: 20,
                      letterSpacing: 0.5,
                      color: textDark,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // 3. Formulario principal (extraído para escalabilidad y modularidad)
              Expanded(
                child: Consumer<CatalogoProvider>(
                  builder: (context, provider, child) {
                    return Stack(
                      children: [
                        SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: EditarSaborFormulario(sabor: sabor),
                        ),
                        if (provider.cargando)
                          Container(
                            color: Colors.black.withOpacity(0.25),
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavBarGlobal(
        pestanaActual: 0,
        iconos: const [
          Icons.home_rounded,
          Icons.shopping_bag_outlined,
          Icons.bar_chart_rounded,
          Icons.person_outline_rounded,
        ],
        alCambiarPestana: (indice) => Navigator.of(context).pop(),
      ),
    );
  }
}