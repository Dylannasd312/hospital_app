import '../../../core/database/database_helper.dart';

import '../models/cama.dart';

class CamaService {

  Future<List<Cama>> obtenerCamas() async {

    final db =
        await DatabaseHelper.instance.database;

    final result = await db.rawQuery('''

      SELECT

        camas.*,

        pacientes.nombre || ' ' ||
        pacientes.apellido
        AS paciente_nombre

      FROM camas

      LEFT JOIN hospitalizacion
      ON camas.id =
         hospitalizacion.cama_id

      LEFT JOIN pacientes
      ON hospitalizacion.paciente_id =
         pacientes.id

      AND hospitalizacion.estado =
          'Activa'

    ''');

    return result
        .map((e) => Cama.fromMap(e))
        .toList();
  }

  // =========================
  // OCUPAR CAMA
  // =========================

  Future<void> ocuparCama(
    int camaId,
  ) async {

    final db =
        await DatabaseHelper.instance.database;

    await db.update(

      'camas',

      {
        'estado': 'Ocupada',
      },

      where: 'id = ?',

      whereArgs: [camaId],
    );
  }

  // =========================
  // LIBERAR CAMA
  // =========================

  Future<void> liberarCama(
    int camaId,
  ) async {

    final db =
        await DatabaseHelper.instance.database;

    await db.update(

      'camas',

      {
        'estado': 'Disponible',
      },

      where: 'id = ?',

      whereArgs: [camaId],
    );
  }
}