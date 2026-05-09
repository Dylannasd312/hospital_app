import 'package:flutter/material.dart';

import '../controllers/paciente_controller.dart';
import '../models/paciente.dart';

class EditPacienteScreen extends StatefulWidget {

  final Paciente paciente;

  const EditPacienteScreen({
    super.key,
    required this.paciente,
  });

  @override
  State<EditPacienteScreen> createState() => _EditPacienteScreenState();
}

class _EditPacienteScreenState extends State<EditPacienteScreen> {

  final controller = PacienteController();

  late TextEditingController nombreCtrl;
  late TextEditingController apellidoCtrl;
  late TextEditingController ciCtrl;
  late TextEditingController fechaCtrl;
  late TextEditingController generoCtrl;
  late TextEditingController telefonoCtrl;
  late TextEditingController direccionCtrl;

  bool loading = false;

  @override
  void initState() {
    super.initState();

    nombreCtrl = TextEditingController(text: widget.paciente.nombre);
    apellidoCtrl = TextEditingController(text: widget.paciente.apellido);
    ciCtrl = TextEditingController(text: widget.paciente.ci);
    fechaCtrl = TextEditingController(text: widget.paciente.fechaNacimiento);
    generoCtrl = TextEditingController(text: widget.paciente.genero);
    telefonoCtrl = TextEditingController(text: widget.paciente.telefono);
    direccionCtrl = TextEditingController(text: widget.paciente.direccion);
  }

  Future<void> actualizar() async {

    setState(() {
      loading = true;
    });

    try {

      final pacienteActualizado = Paciente(
        id: widget.paciente.id,
        nombre: nombreCtrl.text,
        apellido: apellidoCtrl.text,
        ci: ciCtrl.text,
        fechaNacimiento: fechaCtrl.text,
        genero: generoCtrl.text,
        telefono: telefonoCtrl.text,
        direccion: direccionCtrl.text,
      );

      await controller.actualizarPaciente(pacienteActualizado);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Paciente actualizado'),
        ),
      );

      Navigator.pop(context);

    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );

    } finally {

      setState(() {
        loading = false;
      });
    }
  }

  Widget campo(TextEditingController ctrl, String label) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),

      child: TextField(
        controller: ctrl,

        decoration: InputDecoration(
          labelText: label,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('Editar Paciente'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: SingleChildScrollView(
          child: Column(
            children: [

              campo(nombreCtrl, 'Nombre'),
              campo(apellidoCtrl, 'Apellido'),
              campo(ciCtrl, 'CI'),
              campo(fechaCtrl, 'Fecha Nacimiento'),
              campo(generoCtrl, 'Género'),
              campo(telefonoCtrl, 'Teléfono'),
              campo(direccionCtrl, 'Dirección'),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(

                  onPressed: loading ? null : actualizar,

                  child: loading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          'Actualizar Paciente',
                          style: TextStyle(fontSize: 18),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}