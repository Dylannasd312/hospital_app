class Cama {

  final int? id;

  final String numero;
  final String estado;
  final String tipo;

  final String? pacienteNombre;

  Cama({
    this.id,
    required this.numero,
    required this.estado,
    required this.tipo,
    this.pacienteNombre,
  });

  Map<String, dynamic> toMap() {

    return {

      'id': id,
      'numero': numero,
      'estado': estado,
      'tipo': tipo,
    };
  }

  factory Cama.fromMap(
    Map<String, dynamic> map,
  ) {

    return Cama(

      id: map['id'],

      numero: map['numero'],

      estado: map['estado'],

      tipo: map['tipo'],

      pacienteNombre:
          map['paciente_nombre'],
    );
  }
}