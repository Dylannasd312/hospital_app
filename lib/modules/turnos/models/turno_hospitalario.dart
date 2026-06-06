class TurnoHospitalario {

  final int? id;

  final int medicoId;

  final String medicoNombre;

  final String fecha;

  final String horaInicio;

  final String horaFin;

  final String area;

  final String grupo;

  TurnoHospitalario({

    this.id,

    required this.medicoId,

    required this.medicoNombre,

    required this.fecha,

    required this.horaInicio,

    required this.horaFin,

    required this.area,

    required this.grupo,
  });

  Map<String, dynamic> toMap() {

    return {

      'id': id,

      'medico_id': medicoId,

      'medico_nombre': medicoNombre,

      'fecha': fecha,

      'hora_inicio': horaInicio,

      'hora_fin': horaFin,

      'area': area,

      'grupo': grupo,
    };
  }

  factory TurnoHospitalario.fromMap(
    Map<String, dynamic> map,
  ) {

    return TurnoHospitalario(

      id: map['id'],

      medicoId: map['medico_id'],

      medicoNombre:
          map['medico_nombre'] ?? '',

      fecha:
          map['fecha'] ?? '',

      horaInicio:
          map['hora_inicio'] ?? '',

      horaFin:
          map['hora_fin'] ?? '',

      area:
          map['area'] ?? '',

      grupo:
          map['grupo'] ?? '',
    );
  }
}