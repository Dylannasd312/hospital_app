import 'package:flutter/material.dart';

import '../../pacientes/controllers/paciente_controller.dart';
import '../../pacientes/models/paciente.dart';

import '../controllers/historia_controller.dart';
import '../models/historia_clinica.dart';

class AddHistoriaScreen
    extends StatefulWidget {

  const AddHistoriaScreen({
    super.key,
  });

  @override
  State<AddHistoriaScreen> createState() =>
      _AddHistoriaScreenState();
}

class _AddHistoriaScreenState
    extends State<AddHistoriaScreen> {

  final historiaController =
      HistoriaController();

  final pacienteController =
      PacienteController();

  List<Paciente> pacientes = [];

  int? pacienteSeleccionado;

  final diagnosticoCtrl =
      TextEditingController();

  final tratamientoCtrl =
      TextEditingController();

  final fechaCtrl =
      TextEditingController();

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

  Future<void> guardar() async {

    if (pacienteSeleccionado == null) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content:
              Text('Seleccione un paciente'),
        ),
      );

      return;
    }

    final historia = HistoriaClinica(

      pacienteId: pacienteSeleccionado!,

      diagnostico:
          diagnosticoCtrl.text,

      tratamiento:
          tratamientoCtrl.text,

      fecha: fechaCtrl.text,
    );

    await historiaController
        .guardarHistoria(historia);

    if (!mounted) return;

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content:
            Text('Historia guardada'),
      ),
    );

    Navigator.pop(context);
  }

  Widget campo(
    TextEditingController ctrl,
    String label,
  ) {

    return Padding(
      padding:
          const EdgeInsets.only(bottom: 14),

      child: TextField(
        controller: ctrl,

        decoration: InputDecoration(
          labelText: label,

          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title:
            const Text('Nueva Historia'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: SingleChildScrollView(
          child: Column(
            children: [

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
          paciente.id;
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

      decoration: InputDecoration(

        labelText:
            'Buscar Paciente',

        prefixIcon:
            const Icon(
          Icons.search,
        ),

        border:
            OutlineInputBorder(

          borderRadius:
              BorderRadius.circular(
            12,
          ),
        ),
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

              const SizedBox(height: 15),

              campo(
                diagnosticoCtrl,
                'Diagnóstico',
              ),

              campo(
                tratamientoCtrl,
                'Tratamiento',
              ),

              campo(
                fechaCtrl,
                'Fecha',
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(

                  onPressed: guardar,

                  child: const Text(
                    'Guardar Historia',
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