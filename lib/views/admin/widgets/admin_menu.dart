import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';

class AdminMenu extends StatelessWidget {
  const AdminMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Column(
      children: [
        _buildMenuOption(
          icon: Icons.edit_note_rounded,
          title: 'Catálogo',
          onTap: () => Navigator.of(context).pushNamed('/catalogo'),
        ),
        _buildMenuOption(
          icon: Icons.edit_note_rounded,
          title: 'Envases',
          onTap: () {},
        ),
        _buildMenuOption(
          icon: Icons.edit_note_rounded,
          title: 'Cartilla',
          onTap: () {},
        ),
        _buildMenuOption(
          icon: Icons.edit_note_rounded,
          title: 'Otros',
          onTap: () {},
        ),
        const SizedBox(height: 20),
        TextButton.icon(
          onPressed: () {
            authProvider.logout();
            Navigator.of(context).pushReplacementNamed('/login');
          },
          icon: const Icon(Icons.exit_to_app_rounded, color: Colors.grey),
          label: const Text('Cerrar Sesión', style: TextStyle(color: Colors.grey)),
        ),
      ],
    );
  }

  Widget _buildMenuOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    const textDark = Color(0xFF4A1A17);
    const buttonRed = Color(0xFFE24C4C);

    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.015),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
        leading: Icon(icon, color: buttonRed, size: 30),
        title: Text(
          title,
          style: const TextStyle(
            color: textDark,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: const Icon(Icons.chevron_right_rounded, color: buttonRed, size: 30),
        onTap: onTap,
      ),
    );
  }
}
