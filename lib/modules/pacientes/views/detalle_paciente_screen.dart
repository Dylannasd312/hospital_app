import 'package:flutter/material.dart';

import '../models/paciente.dart';
import '../../historia_clinica/views/historias_paciente_screen.dart';
class DetallePacienteScreen extends StatelessWidget {

  final Paciente paciente;

  const DetallePacienteScreen({
    super.key,
    required this.paciente,
  });

  Widget itemDetalle(
    IconData icon,
    String titulo,
    String valor,
  ) {

    return Card(

      elevation: 3,

      margin: const EdgeInsets.only(bottom: 12),

      child: ListTile(

        leading: Icon(
          icon,
          color: Colors.blue,
        ),

        title: Text(
          titulo,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Text(valor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('Detalle Paciente'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: SingleChildScrollView(
          child: Column(
            children: [

              const CircleAvatar(
                radius: 50,
                child: Icon(
                  Icons.person,
                  size: 60,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                '${paciente.nombre} ${paciente.apellido}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 25),

              itemDetalle(
                Icons.badge,
                'CI',
                paciente.ci,
              ),

              itemDetalle(
                Icons.calendar_month,
                'Fecha de Nacimiento',
                paciente.fechaNacimiento,
              ),

              itemDetalle(
                Icons.person_outline,
                'Género',
                paciente.genero,
              ),

              itemDetalle(
                Icons.phone,
                'Teléfono',
                paciente.telefono,
              ),

              itemDetalle(
                Icons.home,
                'Dirección',
                paciente.direccion,
              ),
              const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  height: 55,

                  child: ElevatedButton.icon(

                    icon: const Icon(Icons.medical_services),

                    label: const Text(
                      'Ver Historia Clínica',
                    ),

                    onPressed: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              HistoriasPacienteScreen(
                            paciente: paciente,
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}