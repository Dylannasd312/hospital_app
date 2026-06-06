import '../models/turno_hospitalario.dart';
import '../services/turno_hospitalario_service.dart';

class TurnoHospitalarioController {

  final TurnoHospitalarioService _service =
      TurnoHospitalarioService();

  Future<void> generarSemana() async {

    await _service.generarSemana();
  }

  Future<void> eliminarTurnos() async {

    await _service.eliminarTurnos();
  }

  Future<List<TurnoHospitalario>>
      listarTurnos() async {

    return await _service.obtenerTurnos();
  }
}