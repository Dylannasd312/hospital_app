import 'package:flutter/material.dart';
import '../modules/auth/views/login_screen.dart';
import '../modules/home/views/home_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/': (context) => LoginScreen(),
    '/home': (context) => HomeScreen(),

    // Rutas temporales (pantallas vacías)
    '/inventario': (context) => Scaffold(
          appBar: AppBar(title: Text('Inventario')),
          body: Center(child: Text('Módulo Inventario')),
        ),

    '/turnos': (context) => Scaffold(
          appBar: AppBar(title: Text('Turnos')),
          body: Center(child: Text('Módulo Turnos')),
        ),

    '/camas': (context) => Scaffold(
          appBar: AppBar(title: Text('Camas')),
          body: Center(child: Text('Módulo Camas')),
        ),

    '/historia': (context) => Scaffold(
          appBar: AppBar(title: Text('Historia Clínica')),
          body: Center(child: Text('Módulo Historia Clínica')),
        ),
  };
}