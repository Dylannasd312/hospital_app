import 'package:flutter/material.dart';

import '../models/historia_clinica.dart';

class DetalleHistoriaScreen
    extends StatelessWidget {

  final HistoriaClinica historia;

  const DetalleHistoriaScreen({
    super.key,
    required this.historia,
  });

  Widget item(
    IconData icon,
    String titulo,
    String valor,
  ) {

    return Card(

      elevation: 3,

      margin: const EdgeInsets.only(
        bottom: 12,
      ),

      child: ListTile(

        leading: Icon(
          icon,
          color: Colors.blue,
        ),

        title: Text(
          titulo,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Text(valor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title:
            const Text('Detalle Historia'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: SingleChildScrollView(
          child: Column(
            children: [

              const CircleAvatar(
                radius: 50,
                child: Icon(
                  Icons.medical_services,
                  size: 50,
                ),
              ),

              const SizedBox(height: 25),

              item(
                Icons.description,
                'Diagnóstico',
                historia.diagnostico,
              ),

              item(
                Icons.healing,
                'Tratamiento',
                historia.tratamiento,
              ),

              item(
                Icons.calendar_month,
                'Fecha',
                historia.fecha,
              ),
            ],
          ),
        ),
      ),
    );
  }
}