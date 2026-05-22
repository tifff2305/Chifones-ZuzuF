import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';
import '../../admin/admin_dashboard_view.dart';

class FormularioLogin extends StatefulWidget {
  const FormularioLogin({super.key});

  @override
  State<FormularioLogin> createState() => _FormularioLoginState();
}

class _FormularioLoginState extends State<FormularioLogin> {
  final _formKey = GlobalKey<FormState>();
  final _telefonoController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _telefonoController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _ejecutarAcceso(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    final navigator = Navigator.of(context);
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final exito = await authProvider.login(
      _telefonoController.text.trim(),
      _passwordController.text,
    );

    if (exito && mounted) {
      navigator.pushReplacement(
        MaterialPageRoute(builder: (context) => const AdminDashboardView()),
      );
    } else if (mounted) {
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text(authProvider.error ?? 'Error de acceso'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const borderPink = Color(0xFFFFB3B3);
    const buttonRed = Color(0xFFE24C4C);
    const textDark = Color(0xFF4A1A17);

    final authProvider = Provider.of<AuthProvider>(context);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Campo de Teléfono
          TextFormField(
            controller: _telefonoController,
            keyboardType: TextInputType.phone,
            decoration: _construirInputDecoracion('Teléfono', Icons.phone_android_rounded, borderPink, buttonRed),
            validator: (v) => (v == null || v.trim().isEmpty) ? 'Ingrese su teléfono' : null,
          ),
          const SizedBox(height: 16),
          // Campo de Contraseña
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            decoration: _construirInputDecoracion('Password', Icons.lock_outline_rounded, borderPink, buttonRed,
                sufijo: IconButton(
                  icon: Icon(_obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                  onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                )),
            validator: (v) => (v == null || v.isEmpty) ? 'Ingrese su contraseña' : null,
          ),
          const SizedBox(height: 12),
          // Recordarme y Enlace
          _buildOpcionesFila(authProvider, buttonRed, textDark),
          const SizedBox(height: 24),
          // Botón de Acceder
          ElevatedButton(
            onPressed: authProvider.cargando ? null : () => _ejecutarAcceso(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonRed,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            child: authProvider.cargando
                ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
                : const Text('Acceder', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  InputDecoration _construirInputDecoracion(String hint, IconData icono, Color colorBorde, Color colorFoco, {Widget? sufijo}) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icono, color: colorFoco),
      suffixIcon: sufijo,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: colorBorde, width: 1.5)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: colorFoco, width: 2.0)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: const BorderSide(color: Colors.redAccent)),
      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: const BorderSide(color: Colors.redAccent, width: 2.0)),
    );
  }

  Widget _buildOpcionesFila(AuthProvider auth, Color activeColor, Color textColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: auth.recordarCredenciales,
              activeColor: activeColor,
              onChanged: (val) => auth.setRecordarCredenciales(val ?? false),
            ),
            Text('Recordar', style: TextStyle(color: textColor.withOpacity(0.8), fontSize: 13)),
          ],
        ),
        TextButton(
          onPressed: () {},
          child: Text('¿Olvidaste tu contraseña?', style: TextStyle(color: activeColor, fontWeight: FontWeight.w600, fontSize: 13)),
        ),
      ],
    );
  }
}
