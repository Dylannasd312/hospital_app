import 'package:flutter/material.dart';

import '../modules/auth/views/login_screen.dart';
import '../modules/home/views/home_screen.dart';

import '../modules/pacientes/views/paciente_screen.dart';
import '../modules/historia_clinica/views/historia_screen.dart';
import '../modules/camas/views/camas_screen.dart';
import '../modules/medicos/views/medico_screen.dart';
import '../modules/turnos/views/turno_screen.dart';
import '../modules/configuracion/views/configuracion_screen.dart';
class AppRoutes {

  static Map<String, WidgetBuilder> routes = {

    '/': (context) => const LoginScreen(),

    '/home': (context) => const HomeScreen(),

    // PACIENTES
    '/pacientes': (context) => const PacienteScreen(),

    // HISTORIA CLÍNICA
    '/historia': (context) => const HistoriaScreen(),

    // CAMAS Y HOSPITALIZACIÓN
    '/camas': (context) => const CamasScreen(),

    // MÉDICOS
    '/medicos': (context) => const MedicoScreen(),

    // TEMPORAL (se implementará después)
    '/inventario': (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Inventario'),
          ),
          body: const Center(
            child: Text('Módulo Inventario'),
          ),
        ),

    
    '/turnos': (context) => const TurnoScreen(),
    '/configuracion': (context) => const ConfiguracionScreen(),
  };
}