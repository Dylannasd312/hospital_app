import 'package:flutter/material.dart';

import '../modules/auth/views/login_screen.dart';
import '../modules/home/views/home_screen.dart';
import '../modules/pacientes/views/paciente_screen.dart';
import '../modules/historia_clinica/views/historia_screen.dart';
import '../modules/camas/views/camas_screen.dart';
class AppRoutes {

  static Map<String, WidgetBuilder> routes = {

    // LOGIN
    '/': (context) => const LoginScreen(),

    // HOME
    '/home': (context) => const HomeScreen(),

    // PACIENTES
    '/pacientes': (context) => const PacienteScreen(),

    // INVENTARIO
    '/inventario': (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Inventario'),
          ),
          body: const Center(
            child: Text('Módulo Inventario'),
          ),
        ),

    // TURNOS
    '/turnos': (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Turnos'),
          ),
          body: const Center(
            child: Text('Módulo Turnos'),
          ),
        ),

    // CAMAS
    '/camas': (context) => const CamasScreen(),
          

    // HISTORIA CLINICA
    '/historia': (context) => const HistoriaScreen(),
  };
}