import 'package:flutter/material.dart';

import '../controllers/cama_controller.dart';

import '../controllers/hospitalizacion_controller.dart';

import '../models/cama.dart';

class DetalleCamaScreen
    extends StatefulWidget {

  final Cama cama;

  const DetalleCamaScreen({
    super.key,
    required this.cama,
  });

  @override
  State<DetalleCamaScreen>
      createState() =>
          _DetalleCamaScreenState();
}

class _DetalleCamaScreenState
    extends State<DetalleCamaScreen> {

  final camaController =
      CamaController();

  final hospitalizacionController =
      HospitalizacionController();

  Future<void> liberarCama() async {

    await hospitalizacionController
        .finalizarHospitalizacion(
      widget.cama.id!,
    );

    await camaController.liberarCama(
      widget.cama.id!,
    );

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {

    final ocupada =
        widget.cama.estado ==
            'Ocupada';

    return Scaffold(

      appBar: AppBar(
        title:
            const Text('Detalle Cama'),
      ),

      body: Padding(

        padding:
            const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Center(

              child: Icon(

                Icons.bed,

                size: 100,

                color:
                    ocupada
                        ? Colors.red
                        : Colors.green,
              ),
            ),

            const SizedBox(height: 30),

            Text(
              'Número: ${widget.cama.numero}',
              style:
                  const TextStyle(
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              'Tipo: ${widget.cama.tipo}',
              style:
                  const TextStyle(
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              'Estado: ${widget.cama.estado}',
              style:
                  const TextStyle(
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              'Paciente: ${widget.cama.pacienteNombre ?? 'Ninguno'}',
              style:
                  const TextStyle(
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 40),

            if (ocupada)

              SizedBox(

                width: double.infinity,

                child: ElevatedButton(

                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.red,
                  ),

                  onPressed: liberarCama,

                  child: const Text(
                    'Dar Alta / Liberar Cama',
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}