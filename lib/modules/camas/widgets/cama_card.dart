import 'package:flutter/material.dart';

import '../models/cama.dart';

class CamaCard extends StatelessWidget {

  final Cama cama;

  final VoidCallback onTap;

  const CamaCard({
    super.key,
    required this.cama,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    final ocupada =
        cama.estado == 'Ocupada';

    return InkWell(

      onTap: onTap,

      child: Container(

        decoration: BoxDecoration(

          color:
              ocupada
                  ? Colors.red
                  : Colors.green,

          borderRadius:
              BorderRadius.circular(16),
        ),

        child: Column(

          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            const Icon(
              Icons.bed,
              size: 50,
              color: Colors.white,
            ),

            const SizedBox(height: 10),

            Text(

              cama.numero,

              style: const TextStyle(

                color: Colors.white,

                fontWeight: FontWeight.bold,

                fontSize: 18,
              ),
            ),

            const SizedBox(height: 5),

            Text(

              cama.tipo,

              style: const TextStyle(
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 5),

            Text(

              ocupada
                  ? cama.pacienteNombre ??
                      'Paciente'
                  : 'Disponible',

              textAlign: TextAlign.center,

              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}