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

              DropdownButtonFormField<int>(

                value: pacienteSeleccionado,

                decoration: InputDecoration(

                  labelText: 'Paciente',

                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(
                      12,
                    ),
                  ),
                ),

                items: pacientes.map((p) {

                  return DropdownMenuItem<int>(

                    value: p.id,

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