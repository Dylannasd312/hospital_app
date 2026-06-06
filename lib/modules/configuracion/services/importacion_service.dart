import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';

import '../../pacientes/models/paciente.dart';
import '../../pacientes/services/paciente_service.dart';

import '../../medicos/models/medico.dart';
import '../../medicos/services/medico_service.dart';

class ImportacionService {

  final PacienteService _pacienteService =
      PacienteService();

  final MedicoService _medicoService =
      MedicoService();

  // ==========================
  // IMPORTAR PACIENTES
  // ==========================

  Future<int> importarPacientes() async {

    final resultado =
        await FilePicker.platform.pickFiles(

      type: FileType.custom,

      allowedExtensions: ['xlsx'],
    );

    if (resultado == null) {
      return 0;
    }

    final archivo =
        File(resultado.files.single.path!);

    final bytes =
        archivo.readAsBytesSync();

    final excel =
        Excel.decodeBytes(bytes);

    int importados = 0;

    final hoja =
        excel.tables.values.first;

    if (hoja == null) {
      return 0;
    }

    for (int i = 1; i < hoja.rows.length; i++) {

      final fila =
          hoja.rows[i];

      try {

        final paciente = Paciente(

          nombre:
              fila[0]?.value
                      ?.toString() ??
                  '',

          apellido:
              fila[1]?.value
                      ?.toString() ??
                  '',

          ci:
              fila[2]?.value
                      ?.toString() ??
                  '',

          fechaNacimiento:
              fila[3]?.value
                      ?.toString() ??
                  '',

          genero:
              fila[4]?.value
                      ?.toString() ??
                  '',

          telefono:
              fila[5]?.value
                      ?.toString() ??
                  '',

          direccion:
              fila[6]?.value
                      ?.toString() ??
                  '',
        );

        await _pacienteService
            .insertarPaciente(
          paciente,
        );

        importados++;

      } catch (e) {

        print(
          'Error importando paciente: $e',
        );
      }
    }

    return importados;
  }

  // ==========================
  // IMPORTAR MEDICOS
  // ==========================

  Future<int> importarMedicos() async {

    final resultado =
        await FilePicker.platform.pickFiles(

      type: FileType.custom,

      allowedExtensions: ['xlsx'],
    );

    if (resultado == null) {
      return 0;
    }

    final archivo =
        File(resultado.files.single.path!);

    final bytes =
        archivo.readAsBytesSync();

    final excel =
        Excel.decodeBytes(bytes);

    int importados = 0;

    final hoja =
        excel.tables.values.first;

    if (hoja == null) {
      return 0;
    }

    for (int i = 1; i < hoja.rows.length; i++) {

      final fila =
          hoja.rows[i];

      try {

        String? grupo;

        final valorGrupo =
            fila[3]?.value
                    ?.toString()
                    .trim() ??
                '';

        if (valorGrupo == 'A') {

          grupo = 'A';

        } else if (valorGrupo == 'B') {

          grupo = 'B';

        } else {

          grupo = null;
        }

        final medico = Medico(

          nombre:
              fila[0]?.value
                      ?.toString() ??
                  '',

          especialidad:
              fila[1]?.value
                      ?.toString() ??
                  '',

          telefono:
              fila[2]?.value
                      ?.toString() ??
                  '',

          grupo:
              grupo,
        );

        await _medicoService
            .insertarMedico(
          medico,
        );

        importados++;

      } catch (e) {

        print(
          'Error importando médico: $e',
        );
      }
    }

    return importados;
  }
}