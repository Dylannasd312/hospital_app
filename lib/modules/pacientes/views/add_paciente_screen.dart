import 'package:flutter/material.dart';

import '../controllers/paciente_controller.dart';
import '../models/paciente.dart';

class AddPacienteScreen extends StatefulWidget {
  const AddPacienteScreen({super.key});

  @override
  State<AddPacienteScreen> createState() => _AddPacienteScreenState();
}

class _AddPacienteScreenState extends State<AddPacienteScreen> {

  final controller = PacienteController();

  final nombreCtrl = TextEditingController();
  final apellidoCtrl = TextEditingController();
  final ciCtrl = TextEditingController();
  final fechaCtrl = TextEditingController();
  final generoCtrl = TextEditingController();
  final telefonoCtrl = TextEditingController();
  final direccionCtrl = TextEditingController();

  bool loading = false;

  Future<void> guardar() async {

    if (
      nombreCtrl.text.isEmpty ||
      apellidoCtrl.text.isEmpty ||
      ciCtrl.text.isEmpty
    ) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Complete los campos obligatorios'),
        ),
      );

      return;
    }

    setState(() {
      loading = true;
    });

    try {

      final paciente = Paciente(
        nombre: nombreCtrl.text,
        apellido: apellidoCtrl.text,
        ci: ciCtrl.text,
        fechaNacimiento: fechaCtrl.text,
        genero: generoCtrl.text,
        telefono: telefonoCtrl.text,
        direccion: direccionCtrl.text,
      );

      print('Guardando paciente...');
      print(paciente.toMap());

      await controller.guardarPaciente(paciente);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Paciente guardado correctamente'),
        ),
      );

      Navigator.pop(context);

    } catch (e) {

      print('ERROR: $e');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al guardar: $e'),
        ),
      );

    } finally {

      setState(() {
        loading = false;
      });
    }
  }

  Widget campo(
    TextEditingController ctrl,
    String label, {
    TextInputType keyboard = TextInputType.text,
  }) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),

      child: TextField(
        controller: ctrl,
        keyboardType: keyboard,

        decoration: InputDecoration(
          labelText: label,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
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
        title: const Text('Nuevo Paciente'),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: SingleChildScrollView(
          child: Column(
            children: [

              const Icon(
                Icons.person_add,
                size: 90,
                color: Colors.blue,
              ),

              const SizedBox(height: 20),

              campo(nombreCtrl, 'Nombre'),
              campo(apellidoCtrl, 'Apellido'),
              campo(ciCtrl, 'CI'),
              campo(fechaCtrl, 'Fecha de Nacimiento'),
              campo(generoCtrl, 'Género'),
              campo(
                telefonoCtrl,
                'Teléfono',
                keyboard: TextInputType.phone,
              ),
              campo(direccionCtrl, 'Dirección'),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(

                  onPressed: loading ? null : guardar,

                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                  child: loading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          'Guardar Paciente',
                          style: TextStyle(fontSize: 18),
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