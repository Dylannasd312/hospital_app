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

            Autocomplete<Paciente>(

  displayStringForOption:
      (Paciente p) =>
          '${p.nombre} ${p.apellido}',

  optionsBuilder:

      (TextEditingValue textValue) {

    if (textValue.text.isEmpty) {

      return pacientes;
    }

    return pacientes.where((p) {

      final nombreCompleto =

          '${p.nombre} ${p.apellido}'
              .toLowerCase();

      return nombreCompleto.contains(
        textValue.text.toLowerCase(),
      );
    });
  },

  onSelected: (Paciente paciente) {

    setState(() {

      pacienteSeleccionado =
          paciente;
    });
  },

  fieldViewBuilder: (

    context,

    controller,

    focusNode,

    onFieldSubmitted,

  ) {

    return TextField(

      controller: controller,

      focusNode: focusNode,

      decoration: const InputDecoration(

        labelText:
            'Buscar Paciente',

        prefixIcon:
            Icon(Icons.search),

        border:
            OutlineInputBorder(),
      ),
    );
  },

  optionsViewBuilder: (

    context,

    onSelected,

    options,

  ) {

    return Align(

      alignment:
          Alignment.topLeft,

      child: Material(

        elevation: 4,

        borderRadius:
            BorderRadius.circular(
          12,
        ),

        child: SizedBox(

          width: 350,

          height: 250,

          child: ListView.builder(

            padding:
                EdgeInsets.zero,

            itemCount:
                options.length,

            itemBuilder:
                (context, index) {

              final paciente =
                  options.elementAt(
                index,
              );

              return ListTile(

                leading:
                    const Icon(
                  Icons.person,
                ),

                title: Text(
                  '${paciente.nombre} ${paciente.apellido}',
                ),

                subtitle: Text(
                  'CI: ${paciente.ci}',
                ),

                onTap: () {

                  onSelected(
                    paciente,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
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