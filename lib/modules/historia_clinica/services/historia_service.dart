import '../../../core/database/database_helper.dart';

import '../models/historia_clinica.dart';

class HistoriaService {

  Future<int> insertarHistoria(
    HistoriaClinica historia,
  ) async {

    final db =
        await DatabaseHelper.instance.database;

    return await db.insert(
      'historia_clinica',
      historia.toMap(),
    );
  }

  Future<List<HistoriaClinica>>
      obtenerHistorias() async {

    final db =
        await DatabaseHelper.instance.database;

    final result =
        await db.query(
      'historia_clinica',
      orderBy: 'id DESC',
    );

    return result
        .map((e) =>
            HistoriaClinica.fromMap(e))
        .toList();
  }

  Future<List<HistoriaClinica>>
      obtenerHistoriasPorPaciente(
    int pacienteId,
  ) async {

    final db =
        await DatabaseHelper.instance.database;

    final result = await db.query(
      'historia_clinica',
      where: 'paciente_id = ?',
      whereArgs: [pacienteId],
      orderBy: 'id DESC',
    );

    return result
        .map((e) =>
            HistoriaClinica.fromMap(e))
        .toList();
  }

  Future<int> actualizarHistoria(
    HistoriaClinica historia,
  ) async {

    final db =
        await DatabaseHelper.instance.database;

    return await db.update(
      'historia_clinica',
      historia.toMap(),
      where: 'id = ?',
      whereArgs: [historia.id],
    );
  }

  Future<int> eliminarHistoria(
    int id,
  ) async {

    final db =
        await DatabaseHelper.instance.database;

    return await db.delete(
      'historia_clinica',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}