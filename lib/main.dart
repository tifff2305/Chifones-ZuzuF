import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zuzu/views/admin/widgets/dise%C3%B1o_cont.dart';

// Importaciones de la Arquitectura
import 'services/api_client.dart';
import 'services/auth_service.dart';
import 'services/catalogo_service.dart';
import 'providers/auth_provider.dart';
import 'providers/admin_provider.dart';
import 'providers/catalogo_provider.dart';
import 'views/splash/splash_view.dart';
import 'views/login/login_view.dart';
import 'views/admin/admin_dashboard_view.dart';

void main() {
  // 1. Inicialización de dependencias base de la capa de API y Servicios
  final apiClient = ApiClient(
    baseUrl: 'http://192.168.43.11:3000/api', // Ajustar a la IP de tu servidor backend
  );
  
  final authService = AuthService(apiClient: apiClient);
  final catalogoService = CatalogoService(apiClient: apiClient);

  // 2. Iniciar la aplicación envolviéndola en el MultiProvider
  runApp(
    MultiProvider(
      providers: [
        // Proveedor del Cliente API (por si otros servicios lo necesitan)
        Provider<ApiClient>.value(value: apiClient),
        
        // Proveedor del Servicio de Autenticación
        Provider<AuthService>.value(value: authService),
        
        // Proveedor del Servicio del Catálogo
        Provider<CatalogoService>.value(value: catalogoService),

        // AuthProvider: Maneja el estado de sesión de toda la app
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(authService: authService),
        ),

        // AdminProvider: Maneja los datos del panel de administración
        ChangeNotifierProvider<AdminProvider>(
          create: (context) => AdminProvider(apiClient: apiClient),
        ),

        // CatalogoProvider: Maneja los datos del catálogo de sabores y categorías
        ChangeNotifierProvider<CatalogoProvider>(
          create: (context) => CatalogoProvider(catalogoService: catalogoService),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF4A1A17);
    const buttonRed = Color(0xFFE24C4C);

    return MaterialApp(
      title: 'Chifones ZUZÚ',
      debugShowCheckedModeBanner: false,
      
      // Tema estético premium y optimizado de forma genérica
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: buttonRed,
        colorScheme: ColorScheme.fromSeed(
          seedColor: buttonRed,
          primary: buttonRed,
          secondary: const Color(0xFFFF8B8B),
          surface: const Color(0xFFFFF5F5),
        ),
        
        // REGULACIÓN GENÉRICA DE TEXTOS:
        // Combinamos la aplicación de colores por defecto con tus fuentes corporativas específicas
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: textDark,
              displayColor: textDark,
            ).copyWith(
              // Estilo para el título de tu marca pesada (Usa el font de bloque tipo Slab)
              displayLarge: GoogleFonts.alfaSlabOne(color: textDark),
              
              // Estilo genérico estandarizado para los textos grises de tus botones modulares
              bodyMedium: TextStyle(
                fontSize: AppDesign.fontSizeTitle,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
      ),
      
      // Pantalla de inicio de la aplicación
      home: const SplashView(),
      
      // Definición de rutas nombradas para navegación interna simple
      routes: {
        '/login': (context) => const LoginView(),
        '/admin': (context) => const AdminDashboardView(),
      },
    );
  }
}