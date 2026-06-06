import '../../../core/database/database_helper.dart';

import '../models/medico.dart';

class MedicoService {

  Future<int> insertarMedico(
    Medico medico,
  ) async {

    final db =
        await DatabaseHelper.instance.database;

    return await db.insert(
      'medicos',
      medico.toMap(),
    );
  }

  Future<List<Medico>> obtenerMedicos() async {

    final db =
        await DatabaseHelper.instance.database;

    final result =
        await db.query('medicos');

    return result
        .map((e) => Medico.fromMap(e))
        .toList();
  }

  Future<int> actualizarMedico(
    Medico medico,
  ) async {

    final db =
        await DatabaseHelper.instance.database;

    return await db.update(

      'medicos',

      medico.toMap(),

      where: 'id = ?',

      whereArgs: [medico.id],
    );
  }

  Future<int> eliminarMedico(
    int id,
  ) async {

    final db =
        await DatabaseHelper.instance.database;

    return await db.delete(

      'medicos',

      where: 'id = ?',

      whereArgs: [id],
    );
  }

  Future<int> contarGrupo(
    String grupo,
  ) async {

    final db =
        await DatabaseHelper.instance.database;

    final resultado =
        await db.rawQuery(
      '''
      SELECT COUNT(*) total
      FROM medicos
      WHERE grupo = ?
      ''',
      [grupo],
    );

    return resultado.first['total']
        as int;
  }

  Future<Map<String, int>> obtenerCupos() async {

    final grupoA =
        await contarGrupo('A');

    final grupoB =
        await contarGrupo('B');

    return {

      'A': grupoA,

      'B': grupoB,
    };
  }
}