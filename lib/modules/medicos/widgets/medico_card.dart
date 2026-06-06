import 'package:flutter/material.dart';

import '../models/medico.dart';
import '../views/detalle_medico_screen.dart';

class MedicoCard extends StatelessWidget {

  final Medico medico;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const MedicoCard({
    super.key,
    required this.medico,
    required this.onDelete,
    required this.onEdit,
  });

  Color getColorGrupo() {

    if (medico.grupo == 'A') {
      return Colors.green.shade100;
    }

    if (medico.grupo == 'B') {
      return Colors.orange.shade100;
    }

    return Colors.grey.shade200;
  }

  Color getTextColorGrupo() {

    if (medico.grupo == 'A') {
      return Colors.green;
    }

    if (medico.grupo == 'B') {
      return Colors.orange;
    }

    return Colors.grey.shade700;
  }

  String getNombreGrupo() {

    if (medico.grupo == 'A') {
      return 'Grupo A (Lun-Mie-Vie)';
    }

    if (medico.grupo == 'B') {
      return 'Grupo B (Mar-Jue-Sab)';
    }

    return 'Sin Grupo';
  }

  @override
  Widget build(BuildContext context) {

    return InkWell(

      borderRadius:
          BorderRadius.circular(12),

      onTap: () {

        Navigator.push(

          context,

          MaterialPageRoute(

            builder: (_) =>
                DetalleMedicoScreen(
              medico: medico,
            ),
          ),
        );
      },

      child: Card(

        elevation: 4,

        margin:
            const EdgeInsets.symmetric(
          vertical: 8,
        ),

        shape:
            RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(12),
        ),

        child: ListTile(

          leading: CircleAvatar(

            radius: 25,

            backgroundColor:
                Colors.blue.shade100,

            child: const Icon(
              Icons.medical_services,
              color: Colors.blue,
            ),
          ),

          title: Text(

            medico.nombre,

            style: const TextStyle(
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          subtitle: Column(

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              const SizedBox(
                height: 5,
              ),

              Text(
                'Especialidad: ${medico.especialidad}',
              ),

              const SizedBox(
                height: 3,
              ),

              Container(

                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ),

                decoration:
                    BoxDecoration(

                  color:
                      getColorGrupo(),

                  borderRadius:
                      BorderRadius.circular(
                    20,
                  ),
                ),

                child: Text(

                  getNombreGrupo(),

                  style: TextStyle(

                    color:
                        getTextColorGrupo(),

                    fontWeight:
                        FontWeight.bold,

                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),

          trailing: Row(

            mainAxisSize:
                MainAxisSize.min,

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

                onPressed: () {

                  showDialog(

                    context: context,

                    builder: (_) {

                      return AlertDialog(

                        title: const Text(
                          'Eliminar Médico',
                        ),

                        content:
                            Text(
                          '¿Desea eliminar al médico ${medico.nombre}?',
                        ),

                        actions: [

                          TextButton(

                            onPressed: () {

                              Navigator.pop(
                                context,
                              );
                            },

                            child: const Text(
                              'Cancelar',
                            ),
                          ),

                          ElevatedButton(

                            onPressed: () {

                              Navigator.pop(
                                context,
                              );

                              onDelete();
                            },

                            child: const Text(
                              'Eliminar',
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}