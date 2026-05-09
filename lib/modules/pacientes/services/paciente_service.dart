import '../../../core/database/database_helper.dart';
import '../models/paciente.dart';

class PacienteService {

  Future<int> insertarPaciente(Paciente paciente) async {
    final db = await DatabaseHelper.instance.database;

    return await db.insert(
      'pacientes',
      paciente.toMap(),
    );
  }

  Future<List<Paciente>> obtenerPacientes() async {
    final db = await DatabaseHelper.instance.database;

    final result = await db.query('pacientes');

    return result.map((e) => Paciente.fromMap(e)).toList();
  }

  Future<int> eliminarPaciente(int id) async {
    final db = await DatabaseHelper.instance.database;

    return await db.delete(
      'pacientes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> actualizarPaciente(Paciente paciente) async {
    final db = await DatabaseHelper.instance.database;

    return await db.update(
      'pacientes',
      paciente.toMap(),
      where: 'id = ?',
      whereArgs: [paciente.id],
    );
  }
}