class Hospitalizacion {

  final int? id;

  final int pacienteId;
  final int camaId;

  final String fechaIngreso;

  final String? fechaSalida;

  final String estado;

  Hospitalizacion({
    this.id,
    required this.pacienteId,
    required this.camaId,
    required this.fechaIngreso,
    this.fechaSalida,
    required this.estado,
  });

  Map<String, dynamic> toMap() {

    return {

      'id': id,

      'paciente_id': pacienteId,

      'cama_id': camaId,

      'fecha_ingreso': fechaIngreso,

      'fecha_salida': fechaSalida,

      'estado': estado,
    };
  }
}