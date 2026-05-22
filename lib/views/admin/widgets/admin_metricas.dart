import 'package:flutter/material.dart';
import '../widgets/diseño_cont.dart';

class AdminMetricas extends StatelessWidget {
  const AdminMetricas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const buttonRed = Color(0xFFE24C4C);

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), 
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: AppDesign.cardAspectRatio,
      children: [
        _BotonMenuAdmin(
          titulo: 'Ventas Hoy',
          colorFondo: const Color(0xFFE2F9EB),
          colorIcono: const Color(0xFF2ECC71),
          icono: Icons.trending_up_rounded,
          onTap: () {
            print('Navegar a historial de ventas');
          },
        ),
        _BotonMenuAdmin(
          titulo: 'Gastos Hoy',
          colorFondo: const Color(0xFFFFECEC),
          colorIcono: buttonRed,
          iconoCustom: const Text(
            'Bs',
            style: TextStyle(
              fontSize: AppDesign.fontSizeIconText, 
              fontWeight: FontWeight.bold,
              color: buttonRed,
            ),
          ),
          onTap: () {
            print('Navegar a gastos de insumos');
          },
        ),
        _BotonMenuAdmin(
          titulo: 'Stock Faltante',
          colorFondo: const Color(0xFFE4F0FF),
          colorIcono: const Color(0xFF3498DB),
          icono: Icons.inventory_2_outlined,
          onTap: () {
            print('Navegar a alertas de inventario');
          },
        ),
        _BotonMenuAdmin(
          titulo: 'Clientes',
          colorFondo: const Color(0xFFFFF9E3),
          colorIcono: const Color(0xFFF1C40F),
          icono: Icons.people_alt_outlined,
          onTap: () {
            print('Navegar a gestión de clientes/snacks');
          },
        ),
      ],
    );
  }
}

class _BotonMenuAdmin extends StatelessWidget {
  final String titulo;
  final Color colorFondo;
  final Color colorIcono;
  final IconData? icono;
  final Widget? iconoCustom;
  final VoidCallback onTap; 

  const _BotonMenuAdmin({
    Key? key,
    required this.titulo,
    required this.colorFondo,
    required this.colorIcono,
    this.icono,
    this.iconoCustom,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDesign.cardRadius), 
        border: Border.all(
          color: colorFondo.withOpacity(0.4), 
          width: AppDesign.cardBorderWidth,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppDesign.cardRadius),
          onTap: onTap, 
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDesign.cardPaddingHorizontal, 
              vertical: AppDesign.cardPaddingVertical,     
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center, 
              children: [
                // Icono decorativo en su caja de color
                Container(
                  padding: const EdgeInsets.all(AppDesign.iconBoxPadding), 
                  decoration: BoxDecoration(
                    color: colorFondo,
                    borderRadius: BorderRadius.circular(AppDesign.iconBoxRadius), 
                  ),
                  child: iconoCustom ?? Icon(
                    icono, 
                    size: AppDesign.iconSize, 
                    color: colorIcono,
                  ),
                ),

                const SizedBox(height: 18),
                // Texto inferior descriptivo heredado del Theme global optimizado
                Text(
                  titulo,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}