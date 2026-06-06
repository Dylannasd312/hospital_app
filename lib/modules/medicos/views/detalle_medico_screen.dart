import 'package:flutter/material.dart';

import '../models/medico.dart';

class DetalleMedicoScreen extends StatelessWidget {

  final Medico medico;

  const DetalleMedicoScreen({
    super.key,
    required this.medico,
  });

  Widget itemDetalle(
    IconData icon,
    String titulo,
    String valor,
  ) {

    return Card(

      elevation: 3,

      margin: const EdgeInsets.only(
        bottom: 12,
      ),

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

  Color getColorGrupo() {

    if (medico.grupo == 'A') {
      return Colors.green;
    }

    if (medico.grupo == 'B') {
      return Colors.orange;
    }

    return Colors.grey;
  }

  String getNombreGrupo() {

    if (medico.grupo == 'A') {
      return 'Grupo A (Lunes - Miércoles - Viernes)';
    }

    if (medico.grupo == 'B') {
      return 'Grupo B (Martes - Jueves - Sábado)';
    }

    return 'Sin Grupo';
  }

  String getDescripcionGrupo() {

    if (medico.grupo == 'A') {
      return 'Este médico pertenece al Grupo A y trabaja los días Lunes, Miércoles y Viernes.';
    }

    if (medico.grupo == 'B') {
      return 'Este médico pertenece al Grupo B y trabaja los días Martes, Jueves y Sábado.';
    }

    return 'Este médico se encuentra registrado en el sistema pero no participa en la planificación automática de turnos.';
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'Detalle Médico',
        ),
        centerTitle: true,
      ),

      body: Padding(

        padding: const EdgeInsets.all(16),

        child: SingleChildScrollView(

          child: Column(

            children: [

              CircleAvatar(

                radius: 50,

                backgroundColor:
                    Colors.blue.shade100,

                child: const Icon(
                  Icons.medical_services,
                  size: 60,
                  color: Colors.blue,
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              Text(

                medico.nombre,

                textAlign: TextAlign.center,

                style: const TextStyle(

                  fontSize: 24,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 25,
              ),

              itemDetalle(
                Icons.person,
                'Nombre',
                medico.nombre,
              ),

              itemDetalle(
                Icons.medical_services,
                'Especialidad',
                medico.especialidad,
              ),

              itemDetalle(
                Icons.phone,
                'Teléfono',
                medico.telefono,
              ),

              Card(

                elevation: 3,

                child: ListTile(

                  leading: Icon(
                    Icons.groups,
                    color: getColorGrupo(),
                  ),

                  title: const Text(

                    'Grupo',

                    style: TextStyle(
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  subtitle: Text(
                    getNombreGrupo(),
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              Container(

                width: double.infinity,

                padding:
                    const EdgeInsets.all(
                  15,
                ),

                decoration: BoxDecoration(

                  color:
                      getColorGrupo()
                          .withValues(
                            alpha: 0.10,
                          ),

                  borderRadius:
                      BorderRadius.circular(
                    12,
                  ),
                ),

                child: Text(

                  getDescripcionGrupo(),

                  textAlign: TextAlign.center,

                  style: TextStyle(

                    color:
                        getColorGrupo(),

                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}