import '../models/medico.dart';
import '../services/medico_service.dart';

class MedicoController {

  final MedicoService _service =
      MedicoService();

  Future<void> guardarMedico(
    Medico medico,
  ) async {

    await _service.insertarMedico(
      medico,
    );
  }

  Future<List<Medico>> listarMedicos() async {

    return await _service.obtenerMedicos();
  }

  Future<bool> grupoDisponible(
    String grupo,
  ) async {

    if (grupo.isEmpty) {
      return true;
    }

    final total =
        await _service.contarGrupo(
      grupo,
    );

    return total < 18;
  }

  Future<Map<String, int>> obtenerCupos() async {

    return await _service.obtenerCupos();
  }

  Future<void> actualizarMedico(
    Medico medico,
  ) async {

    await _service.actualizarMedico(
      medico,
    );
  }

  Future<void> eliminarMedico(
    int id,
  ) async {

    await _service.eliminarMedico(
      id,
    );
  }
}