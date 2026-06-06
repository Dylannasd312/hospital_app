import 'dart:io';

import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';

class ExcelService {

  Future<String> generarPlantillaPacientes() async {

    final excel = Excel.createExcel();

    final sheet = excel['Pacientes'];

    sheet.appendRow([
      TextCellValue('nombre'),
      TextCellValue('apellido'),
      TextCellValue('ci'),
      TextCellValue('fecha_nacimiento'),
      TextCellValue('genero'),
      TextCellValue('telefono'),
      TextCellValue('direccion'),
    ]);

    final carpeta =
        await getApplicationDocumentsDirectory();

    final ruta =
        '${carpeta.path}/plantilla_pacientes.xlsx';

    final bytes = excel.encode();

    File(ruta)
      ..createSync(recursive: true)
      ..writeAsBytesSync(bytes!);

    return ruta;
  }

  Future<String> generarPlantillaMedicos() async {

    final excel = Excel.createExcel();

    final sheet = excel['Medicos'];

    sheet.appendRow([
      TextCellValue('nombre'),
      TextCellValue('especialidad'),
      TextCellValue('telefono'),
      TextCellValue('grupo'),
    ]);

    final carpeta =
        await getApplicationDocumentsDirectory();

    final ruta =
        '${carpeta.path}/plantilla_medicos.xlsx';

    final bytes = excel.encode();

    File(ruta)
      ..createSync(recursive: true)
      ..writeAsBytesSync(bytes!);

    return ruta;
  }
}