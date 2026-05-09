import 'package:flutter/material.dart';

import '../../pacientes/controllers/paciente_controller.dart';
import '../../pacientes/models/paciente.dart';

import '../controllers/cama_controller.dart';
import '../controllers/hospitalizacion_controller.dart';

import '../models/cama.dart';
import '../models/hospitalizacion.dart';

class HospitalizarScreen
    extends StatefulWidget {

  final Cama cama;

  const HospitalizarScreen({
    super.key,
    required this.cama,
  });

  @override
  State<HospitalizarScreen>
      createState() =>
          _HospitalizarScreenState();
}

class _HospitalizarScreenState
    extends State<HospitalizarScreen> {

  final pacienteController =
      PacienteController();

  final camaController =
      CamaController();

  final hospitalizacionController =
      HospitalizacionController();

  List<Paciente> pacientes = [];

  Paciente? pacienteSeleccionado;

  @override
  void initState() {
    super.initState();

    cargarPacientes();
  }

  Future<void> cargarPacientes() async {

    pacientes =
        await pacienteController
            .listarPacientes();

    setState(() {});
  }

  Future<void> hospitalizar() async {

    if (pacienteSeleccionado == null) {
      return;
    }

    final hospitalizacion =
        Hospitalizacion(

      pacienteId:
          pacienteSeleccionado!.id!,

      camaId: widget.cama.id!,

      fechaIngreso:
          DateTime.now().toString(),

      estado: 'Activa',
    );

    await hospitalizacionController
        .hospitalizarPaciente(
      hospitalizacion,
    );

    await camaController.ocuparCama(
      widget.cama.id!,
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title:
            const Text('Hospitalizar'),
      ),

      body: Padding(

        padding:
            const EdgeInsets.all(16),

        child: Column(

          children: [

            Text(
              'Cama: ${widget.cama.numero}',
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<Paciente>(

              value:
                  pacienteSeleccionado,

              decoration:
                  const InputDecoration(
                labelText: 'Paciente',
                border:
                    OutlineInputBorder(),
              ),

              items:
                  pacientes.map((p) {

                return DropdownMenuItem(

                  value: p,

                  child: Text(
                    '${p.nombre} ${p.apellido}',
                  ),
                );
              }).toList(),

              onChanged: (value) {

                setState(() {

                  pacienteSeleccionado =
                      value;
                });
              },
            ),

            const SizedBox(height: 20),

            ElevatedButton(

              onPressed: hospitalizar,

              child: const Text(
                'Hospitalizar Paciente',
              ),
            )
          ],
        ),
      ),
    );
  }
}