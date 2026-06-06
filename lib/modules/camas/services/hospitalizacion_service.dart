import '../../../core/database/database_helper.dart';

import '../models/hospitalizacion.dart';

class HospitalizacionService {

  Future<void> hospitalizarPaciente(
    Hospitalizacion hospitalizacion,
  ) async {

    final db =
        await DatabaseHelper.instance.database;

    await db.insert(
      'hospitalizacion',
      hospitalizacion.toMap(),
    );
  }

  // =========================
  // FINALIZAR HOSPITALIZACION
  // =========================

  Future<void> finalizarHospitalizacion(
    int camaId,
  ) async {

    final db =
        await DatabaseHelper.instance.database;

    await db.update(

      'hospitalizacion',

      {

        'estado': 'Finalizada',

        'fecha_salida':
            DateTime.now().toString(),
      },

      where:
          'cama_id = ? AND estado = ?',

      whereArgs: [
        camaId,
        'Activa',
      ],
    );
  }
}