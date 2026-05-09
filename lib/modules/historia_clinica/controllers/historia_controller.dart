import '../models/historia_clinica.dart';
import '../services/historia_service.dart';

class HistoriaController {

  final HistoriaService _service =
      HistoriaService();

  Future<int> guardarHistoria(
    HistoriaClinica historia,
  ) async {

    return await _service
        .insertarHistoria(historia);
  }

  Future<List<HistoriaClinica>>
      listarHistorias() async {

    return await _service
        .obtenerHistorias();
  }

  Future<List<HistoriaClinica>>
      listarHistoriasPorPaciente(
    int pacienteId,
  ) async {

    return await _service
        .obtenerHistoriasPorPaciente(
      pacienteId,
    );
  }

  Future<int> actualizarHistoria(
    HistoriaClinica historia,
  ) async {

    return await _service
        .actualizarHistoria(historia);
  }

  Future<int> eliminarHistoria(
    int id,
  ) async {

    return await _service
        .eliminarHistoria(id);
  }
}