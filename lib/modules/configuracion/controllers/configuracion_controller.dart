import 'package:url_launcher/url_launcher.dart';

class ConfiguracionController {

  Future<void> abrirPlantillas() async {

    final url = Uri.parse(
      'https://drive.google.com/drive/folders/1_hQouE6A5fYsrns4RKMFcWgtr_T7dKo6?usp=sharing',
    );

    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {

      throw Exception(
        'No se pudo abrir Drive',
      );
    }
  }
}