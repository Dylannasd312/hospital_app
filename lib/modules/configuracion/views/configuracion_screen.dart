import 'package:flutter/material.dart';

import '../controllers/configuracion_controller.dart';
import '../controllers/importacion_controller.dart';

class ConfiguracionScreen extends StatefulWidget {
  const ConfiguracionScreen({super.key});

  @override
  State<ConfiguracionScreen> createState() =>
      _ConfiguracionScreenState();
}

class _ConfiguracionScreenState
    extends State<ConfiguracionScreen> {

  final controller =
      ConfiguracionController();

  final importacionController =
      ImportacionController();

  Widget cardOpcion({

    required IconData icon,
    required String titulo,
    required String subtitulo,
    required VoidCallback onPressed,

  }) {

    return Card(

      elevation: 4,

      margin: const EdgeInsets.only(
        bottom: 15,
      ),

      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(12),
      ),

      child: ListTile(

        contentPadding:
            const EdgeInsets.all(12),

        leading: CircleAvatar(

          radius: 28,

          child: Icon(
            icon,
            size: 30,
          ),
        ),

        title: Text(

          titulo,

          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),

        subtitle: Text(
          subtitulo,
        ),

        trailing: ElevatedButton(

          onPressed: onPressed,

          child: const Text(
            'Abrir',
          ),
        ),
      ),
    );
  }

  Future<void> importarPacientes() async {

    final cantidad =
        await importacionController
            .importarPacientes();

    if (!mounted) return;

    showDialog(

      context: context,

      builder: (_) {

        return AlertDialog(

          title: const Text(
            'Importación Finalizada',
          ),

          content: Text(
            '$cantidad pacientes importados correctamente.',
          ),

          actions: [

            ElevatedButton(

              onPressed: () {

                Navigator.pop(
                  context,
                );
              },

              child: const Text(
                'Aceptar',
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> importarMedicos() async {

    final cantidad =
        await importacionController
            .importarMedicos();

    if (!mounted) return;

    showDialog(

      context: context,

      builder: (_) {

        return AlertDialog(

          title: const Text(
            'Importación Finalizada',
          ),

          content: Text(
            '$cantidad médicos importados correctamente.',
          ),

          actions: [

            ElevatedButton(

              onPressed: () {

                Navigator.pop(
                  context,
                );
              },

              child: const Text(
                'Aceptar',
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'Configuración',
        ),
        centerTitle: true,
      ),

      body: Padding(

        padding:
            const EdgeInsets.all(16),

        child: SingleChildScrollView(

          child: Column(

            children: [

              const Icon(
                Icons.settings,
                size: 90,
                color: Colors.teal,
              ),

              const SizedBox(
                height: 15,
              ),

              const Text(

                'Configuración del Sistema',

                style: TextStyle(
                  fontSize: 24,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 30,
              ),

              cardOpcion(

                icon:
                    Icons.download,

                titulo:
                    'Descargar Plantillas Excel',

                subtitulo:
                    'Abrir carpeta de Google Drive con las plantillas oficiales.',

                onPressed: () async {

                  await controller
                      .abrirPlantillas();
                },
              ),

              cardOpcion(

                icon:
                    Icons.people,

                titulo:
                    'Importar Pacientes',

                subtitulo:
                    'Importar pacientes desde un archivo Excel.',

                onPressed:
                    importarPacientes,
              ),

              cardOpcion(

                icon:
                    Icons.medical_services,

                titulo:
                    'Importar Médicos',

                subtitulo:
                    'Importar médicos desde un archivo Excel.',

                onPressed:
                    importarMedicos,
              ),
            ],
          ),
        ),
      ),
    );
  }
}