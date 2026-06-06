import 'dart:math';

import '../../../core/database/database_helper.dart';

import '../../medicos/models/medico.dart';
import '../../medicos/services/medico_service.dart';

import '../models/turno_hospitalario.dart';

class TurnoHospitalarioService {

  final MedicoService _medicoService =
      MedicoService();

  final Random _random =
      Random();

  final List<String> horarios = [

    '00:00',
    '04:00',
    '08:00',
    '12:00',
    '16:00',
    '20:00',
  ];

  final List<String> horariosFin = [

    '04:00',
    '08:00',
    '12:00',
    '16:00',
    '20:00',
    '00:00',
  ];

  Future<void> insertarTurno(
    TurnoHospitalario turno,
  ) async {

    final db =
        await DatabaseHelper.instance.database;

    await db.insert(
      'turnos_hospitalarios',
      turno.toMap(),
    );
  }

  Future<List<TurnoHospitalario>>
      obtenerTurnos() async {

    final db =
        await DatabaseHelper.instance.database;

    final result =
        await db.query(
      'turnos_hospitalarios',
      orderBy: 'fecha ASC',
    );

    return result

        .map(
          (e) =>
              TurnoHospitalario.fromMap(e),
        )

        .toList();
  }

  Future<void> eliminarTurnos() async {

    final db =
        await DatabaseHelper.instance.database;

    await db.delete(
      'turnos_hospitalarios',
    );
  }

  Future<List<Medico>>
      obtenerGrupo(
    String grupo,
  ) async {

    final medicos =
        await _medicoService
            .obtenerMedicos();

    return medicos.where((m) {

      return m.grupo == grupo;

    }).toList();
  }

  Future<void> generarSemana() async {

    await eliminarTurnos();

    await generarDia(
      'Lunes',
      'A',
    );

    await generarDia(
      'Martes',
      'B',
    );

    await generarDia(
      'Miércoles',
      'A',
    );

    await generarDia(
      'Jueves',
      'B',
    );

    await generarDia(
      'Viernes',
      'A',
    );

    await generarDia(
      'Sábado',
      'B',
    );
  }

  Future<void> generarDia(

    String fecha,

    String grupo,

  ) async {

    final medicos =
        await obtenerGrupo(
      grupo,
    );

    if (medicos.length < 18) {
      return;
    }

    medicos.shuffle();

    final observacion =
        medicos.sublist(0, 6);

    final intermedia =
        medicos.sublist(6, 12);

    final intensiva =
        medicos.sublist(12, 18);

    await generarArea(
      fecha,
      grupo,
      'Observación',
      observacion,
    );

    await generarArea(
      fecha,
      grupo,
      'Intermedia',
      intermedia,
    );

    await generarArea(
      fecha,
      grupo,
      'Intensiva',
      intensiva,
    );
  }

  Future<void> generarArea(

    String fecha,

    String grupo,

    String area,

    List<Medico> medicos,

  ) async {

    medicos.shuffle();

    for (

      int i = 0;

      i < 6;

      i++

    ) {

      final medico =
          medicos[i];

      final turno =
          TurnoHospitalario(

        medicoId:
            medico.id!,

        medicoNombre:
            medico.nombre,

        fecha:
            fecha,

        horaInicio:
            horarios[i],

        horaFin:
            horariosFin[i],

        area:
            area,

        grupo:
            grupo,
      );

      await insertarTurno(
        turno,
      );
    }
  }
}