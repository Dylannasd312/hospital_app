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
}