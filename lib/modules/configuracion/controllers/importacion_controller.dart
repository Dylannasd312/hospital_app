import '../services/importacion_service.dart';

class ImportacionController {

  final ImportacionService _service =
      ImportacionService();

  Future<int> importarPacientes() async {

    return await _service
        .importarPacientes();
  }
  Future<int> importarMedicos() async {

  return await _service
      .importarMedicos();
}
}