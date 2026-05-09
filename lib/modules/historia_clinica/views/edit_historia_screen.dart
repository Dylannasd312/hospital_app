import 'package:flutter/material.dart';

import '../controllers/historia_controller.dart';
import '../models/historia_clinica.dart';

class EditHistoriaScreen
    extends StatefulWidget {

  final HistoriaClinica historia;

  const EditHistoriaScreen({
    super.key,
    required this.historia,
  });

  @override
  State<EditHistoriaScreen> createState() =>
      _EditHistoriaScreenState();
}

class _EditHistoriaScreenState
    extends State<EditHistoriaScreen> {

  final controller =
      HistoriaController();

  late TextEditingController
      diagnosticoCtrl;

  late TextEditingController
      tratamientoCtrl;

  late TextEditingController
      fechaCtrl;

  @override
  void initState() {
    super.initState();

    diagnosticoCtrl =
        TextEditingController(
      text: widget.historia.diagnostico,
    );

    tratamientoCtrl =
        TextEditingController(
      text: widget.historia.tratamiento,
    );

    fechaCtrl = TextEditingController(
      text: widget.historia.fecha,
    );
  }

  Future<void> actualizar() async {

    final historiaActualizada =
        HistoriaClinica(

      id: widget.historia.id,

      pacienteId:
          widget.historia.pacienteId,

      diagnostico:
          diagnosticoCtrl.text,

      tratamiento:
          tratamientoCtrl.text,

      fecha: fechaCtrl.text,
    );

    await controller.actualizarHistoria(
      historiaActualizada,
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content:
            Text('Historia actualizada'),
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
            const Text('Editar Historia'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: SingleChildScrollView(
          child: Column(
            children: [

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

                  onPressed: actualizar,

                  child: const Text(
                    'Actualizar Historia',
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