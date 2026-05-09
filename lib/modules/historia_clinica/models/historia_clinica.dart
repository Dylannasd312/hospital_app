class HistoriaClinica {

  final int? id;
  final int pacienteId;
  final int? medicoId;

  final String diagnostico;
  final String tratamiento;
  final String fecha;

  HistoriaClinica({
    this.id,
    required this.pacienteId,
    this.medicoId,
    required this.diagnostico,
    required this.tratamiento,
    required this.fecha,
  });

  Map<String, dynamic> toMap() {

    return {
      'id': id,
      'paciente_id': pacienteId,
      'medico_id': medicoId,
      'diagnostico': diagnostico,
      'tratamiento': tratamiento,
      'fecha': fecha,
    };
  }

  factory HistoriaClinica.fromMap(
    Map<String, dynamic> map,
  ) {

    return HistoriaClinica(
      id: map['id'],
      pacienteId: map['paciente_id'],
      medicoId: map['medico_id'],
      diagnostico: map['diagnostico'],
      tratamiento: map['tratamiento'],
      fecha: map['fecha'],
    );
  }
}