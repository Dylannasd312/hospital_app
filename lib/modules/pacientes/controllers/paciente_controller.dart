import '../models/paciente.dart';
import '../services/paciente_service.dart';

class PacienteController {

  final PacienteService _service = PacienteService();

  Future<int> guardarPaciente(Paciente paciente) async {
    return await _service.insertarPaciente(paciente);
  }

  Future<List<Paciente>> listarPacientes() async {
    return await _service.obtenerPacientes();
  }

  Future<int> eliminarPaciente(int id) async {
    return await _service.eliminarPaciente(id);
  }

  Future<int> actualizarPaciente(Paciente paciente) async {
    return await _service.actualizarPaciente(paciente);
  }
}