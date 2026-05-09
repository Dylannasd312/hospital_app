import 'package:flutter/material.dart';

import '../models/historia_clinica.dart';

import '../views/detalle_historia_screen.dart';
import '../views/edit_historia_screen.dart';

class HistoriaCard extends StatelessWidget {

  final HistoriaClinica historia;

  final VoidCallback onDelete;
  final VoidCallback onRefresh;

  const HistoriaCard({
    super.key,
    required this.historia,
    required this.onDelete,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {

    return InkWell(

      borderRadius: BorderRadius.circular(12),

      onTap: () {

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                DetalleHistoriaScreen(
              historia: historia,
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
          borderRadius:
              BorderRadius.circular(12),
        ),

        child: ListTile(

          leading: const CircleAvatar(
            child: Icon(
              Icons.medical_services,
            ),
          ),

          title: Text(
            historia.diagnostico,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          subtitle: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              const SizedBox(height: 5),

              Text(
                'Tratamiento: ${historia.tratamiento}',
              ),

              Text(
                'Fecha: ${historia.fecha}',
              ),
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

                onPressed: () async {

                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          EditHistoriaScreen(
                        historia: historia,
                      ),
                    ),
                  );

                  onRefresh();
                },
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