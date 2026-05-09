import '../models/cama.dart';
import '../services/cama_service.dart';

class CamaController {

  final CamaService _service =
      CamaService();

  Future<List<Cama>> listarCamas() async {

    return await _service.obtenerCamas();
  }

  Future<void> ocuparCama(
    int camaId,
  ) async {

    await _service.ocuparCama(camaId);
  }

  Future<void> liberarCama(
    int camaId,
  ) async {

    await _service.liberarCama(camaId);
  }
}