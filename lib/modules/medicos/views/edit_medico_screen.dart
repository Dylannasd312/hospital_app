import 'package:flutter/material.dart';

import '../controllers/medico_controller.dart';
import '../models/medico.dart';

class EditMedicoScreen extends StatefulWidget {

  final Medico medico;

  const EditMedicoScreen({
    super.key,
    required this.medico,
  });

  @override
  State<EditMedicoScreen> createState() =>
      _EditMedicoScreenState();
}

class _EditMedicoScreenState
    extends State<EditMedicoScreen> {

  final controller =
      MedicoController();

  late TextEditingController
      nombreCtrl;

  late TextEditingController
      especialidadCtrl;

  late TextEditingController
      telefonoCtrl;

  late String grupoSeleccionado;

  int totalA = 0;
  int totalB = 0;

  bool loading = false;

  @override
  void initState() {

    super.initState();

    nombreCtrl =
        TextEditingController(
      text: widget.medico.nombre,
    );

    especialidadCtrl =
        TextEditingController(
      text:
          widget.medico.especialidad,
    );

    telefonoCtrl =
        TextEditingController(
      text:
          widget.medico.telefono,
    );

    grupoSeleccionado =
        widget.medico.grupo ?? '';

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

      if (grupoSeleccionado.isNotEmpty &&
          grupoSeleccionado != widget.medico.grupo) {

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

      await controller.actualizarMedico(

        Medico(

          id: widget.medico.id,

          nombre:
              nombreCtrl.text,

          especialidad:
              especialidadCtrl.text,

          telefono:
              telefonoCtrl.text,

          grupo:
              grupoSeleccionado.isEmpty
                  ? null
                  : grupoSeleccionado,
        ),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(
          content: Text(
            'Médico actualizado correctamente',
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
          'Editar Médico',
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
                        totalA < 18 ||
                        widget.medico.grupo == 'A',

                    child: Text(
                      'Grupo A ($totalA/18)',
                    ),
                  ),

                  DropdownMenuItem(

                    value: 'B',

                    enabled:
                        totalB < 18 ||
                        widget.medico.grupo == 'B',

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
                          'Actualizar Médico',
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