import 'package:flutter/material.dart';

import '../controllers/medico_controller.dart';
import '../models/medico.dart';

class AddMedicoScreen extends StatefulWidget {
  const AddMedicoScreen({super.key});

  @override
  State<AddMedicoScreen> createState() =>
      _AddMedicoScreenState();
}

class _AddMedicoScreenState
    extends State<AddMedicoScreen> {

  final controller = MedicoController();

  final nombreCtrl =
      TextEditingController();

  final especialidadCtrl =
      TextEditingController();

  final telefonoCtrl =
      TextEditingController();

  String grupoSeleccionado = '';

  int totalA = 0;
  int totalB = 0;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    cargarCupos();
  }

  Future<void> cargarCupos() async {

    final cupos =
        await controller.obtenerCupos();

    setState(() {

      totalA = cupos['A'] ?? 0;
      totalB = cupos['B'] ?? 0;
    });
  }

  Future<void> guardar() async {

    if (nombreCtrl.text.isEmpty ||
        especialidadCtrl.text.isEmpty) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(
          content: Text(
            'Complete los campos obligatorios',
          ),
        ),
      );

      return;
    }

    setState(() {
      loading = true;
    });

    try {

      if (grupoSeleccionado.isNotEmpty) {

        final disponible =
            await controller.grupoDisponible(
          grupoSeleccionado,
        );

        if (!disponible) {

          ScaffoldMessenger.of(context)
              .showSnackBar(

            SnackBar(
              content: Text(
                'El Grupo $grupoSeleccionado ya tiene 18 médicos.',
              ),
            ),
          );

          setState(() {
            loading = false;
          });

          return;
        }
      }

      final medico = Medico(

        nombre: nombreCtrl.text,

        especialidad:
            especialidadCtrl.text,

        telefono:
            telefonoCtrl.text,

        grupo:
            grupoSeleccionado.isEmpty
                ? null
                : grupoSeleccionado,
      );

      await controller.guardarMedico(
        medico,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(
          content: Text(
            'Médico guardado correctamente',
          ),
        ),
      );

      Navigator.pop(context);

    } catch (e) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(
          content: Text(
            'Error: $e',
          ),
        ),
      );
    }

    finally {

      if (mounted) {

        setState(() {
          loading = false;
        });
      }
    }
  }

  Widget campo(
    TextEditingController controller,
    String label,
  ) {

    return Padding(

      padding:
          const EdgeInsets.only(
        bottom: 14,
      ),

      child: TextField(

        controller: controller,

        decoration:
            InputDecoration(

          labelText: label,

          border:
              OutlineInputBorder(

            borderRadius:
                BorderRadius.circular(
              12,
            ),
          ),

          focusedBorder:
              OutlineInputBorder(

            borderRadius:
                BorderRadius.circular(
              12,
            ),

            borderSide:
                const BorderSide(

              color: Colors.blue,
              width: 2,
            ),
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
            const Text(
          'Nuevo Médico',
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
                Icons.medical_services,
                size: 90,
                color: Colors.blue,
              ),

              const SizedBox(
                height: 20,
              ),

              campo(
                nombreCtrl,
                'Nombre',
              ),

              campo(
                especialidadCtrl,
                'Especialidad',
              ),

              campo(
                telefonoCtrl,
                'Teléfono',
              ),

              DropdownButtonFormField<String>(

                value:
                    grupoSeleccionado,

                decoration:
                    InputDecoration(

                  labelText:
                      'Grupo',

                  border:
                      OutlineInputBorder(

                    borderRadius:
                        BorderRadius.circular(
                      12,
                    ),
                  ),
                ),

                items: [

                  const DropdownMenuItem(

                    value: '',

                    child: Text(
                      'Sin Grupo',
                    ),
                  ),

                  DropdownMenuItem(

                    value: 'A',

                    enabled:
                        totalA < 18,

                    child: Text(
                      'Grupo A ($totalA/18)',
                    ),
                  ),

                  DropdownMenuItem(

                    value: 'B',

                    enabled:
                        totalB < 18,

                    child: Text(
                      'Grupo B ($totalB/18)',
                    ),
                  ),
                ],

                onChanged: (value) {

                  if (value == null) {
                    return;
                  }

                  setState(() {

                    grupoSeleccionado =
                        value;
                  });
                },
              ),

              const SizedBox(
                height: 25,
              ),

              SizedBox(

                width:
                    double.infinity,

                height: 55,

                child: ElevatedButton(

                  onPressed:
                      loading
                          ? null
                          : guardar,

                  style:
                      ElevatedButton.styleFrom(

                    shape:
                        RoundedRectangleBorder(

                      borderRadius:
                          BorderRadius.circular(
                        12,
                      ),
                    ),
                  ),

                  child: loading

                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )

                      : const Text(
                          'Guardar Médico',
                          style: TextStyle(
                            fontSize: 18,
                          ),
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