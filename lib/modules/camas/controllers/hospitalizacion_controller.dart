import '../models/hospitalizacion.dart';

import '../services/hospitalizacion_service.dart';

class HospitalizacionController {

  final HospitalizacionService _service =
      HospitalizacionService();

  Future<void> hospitalizarPaciente(
    Hospitalizacion hospitalizacion,
  ) async {

    await _service.hospitalizarPaciente(
      hospitalizacion,
    );
  }

  Future<void> finalizarHospitalizacion(
    int camaId,
  ) async {

    await _service
        .finalizarHospitalizacion(
      camaId,
    );
  }
}