import 'package:flutter/material.dart';

import '../controllers/turno_hospitalario_controller.dart';
import '../models/turno_hospitalario.dart';

class CalendarioTurnosScreen
    extends StatefulWidget {

  const CalendarioTurnosScreen({
    super.key,
  });

  @override
  State<CalendarioTurnosScreen>
      createState() =>
          _CalendarioTurnosScreenState();
}

class _CalendarioTurnosScreenState
    extends State<
        CalendarioTurnosScreen> {

  final controller =
      TurnoHospitalarioController();

  List<TurnoHospitalario> turnos = [];

  bool loading = true;

  @override
  void initState() {

    super.initState();

    cargar();
  }

  Future<void> cargar() async {

    turnos =
        await controller.listarTurnos();

    setState(() {
      loading = false;
    });
  }

  List<TurnoHospitalario>
      obtenerPorDia(
    String dia,
  ) {

    return turnos.where((t) {

      return t.fecha == dia;

    }).toList();
  }

  Widget bloqueDia(
    String dia,
  ) {

    final lista =
        obtenerPorDia(dia);

    return Card(

      elevation: 4,

      margin:
          const EdgeInsets.only(
        bottom: 15,
      ),

      child: Padding(

        padding:
            const EdgeInsets.all(12),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Text(

              dia,

              style:
                  const TextStyle(

                fontSize: 22,

                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const Divider(),

            ...lista.map((turno) {

              return ListTile(

                dense: true,

                leading:
                    const Icon(
                  Icons.schedule,
                ),

                title: Text(
                  turno.medicoNombre,
                ),

                subtitle: Text(
                  '${turno.area} | ${turno.horaInicio} - ${turno.horaFin}',
                ),

                trailing: Text(
                  'Grupo ${turno.grupo}',
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          'Calendario Semanal',
        ),
      ),

      body: loading

          ? const Center(
              child:
                  CircularProgressIndicator(),
            )

          : ListView(

              padding:
                  const EdgeInsets.all(
                12,
              ),

              children: [

                bloqueDia('Lunes'),

                bloqueDia('Martes'),

                bloqueDia('Miércoles'),

                bloqueDia('Jueves'),

                bloqueDia('Viernes'),

                bloqueDia('Sábado'),
              ],
            ),
    );
  }
}