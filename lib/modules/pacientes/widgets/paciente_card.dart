import 'package:flutter/material.dart';

import '../models/paciente.dart';
import '../views/detalle_paciente_screen.dart';

class PacienteCard extends StatelessWidget {

  final Paciente paciente;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const PacienteCard({
    super.key,
    required this.paciente,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {

    return InkWell(

      borderRadius: BorderRadius.circular(12),

      onTap: () {

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetallePacienteScreen(
              paciente: paciente,
            ),
          ),
        );
      },

      child: Card(

        elevation: 4,

        margin: const EdgeInsets.symmetric(
          vertical: 8,
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),

        child: ListTile(

          leading: const CircleAvatar(
            radius: 25,
            child: Icon(Icons.person),
          ),

          title: Text(
            '${paciente.nombre} ${paciente.apellido}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 5),

              Text('CI: ${paciente.ci}'),

              Text('Teléfono: ${paciente.telefono}'),
            ],
          ),

          trailing: Row(
            mainAxisSize: MainAxisSize.min,

            children: [

              IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: Colors.blue,
                ),
                onPressed: onEdit,
              ),

              IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}