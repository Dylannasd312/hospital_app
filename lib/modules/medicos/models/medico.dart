class Medico {

  final int? id;

  final String nombre;
  final String especialidad;
  final String telefono;
  final String? grupo;

  Medico({
    this.id,
    required this.nombre,
    required this.especialidad,
    required this.telefono,
    this.grupo,
  });

  Map<String, dynamic> toMap() {

    return {

      'id': id,

      'nombre': nombre,

      'especialidad': especialidad,

      'telefono': telefono,

      'grupo': grupo,
    };
  }

  factory Medico.fromMap(
    Map<String, dynamic> map,
  ) {

    return Medico(

      id: map['id'],

      nombre: map['nombre'] ?? '',

      especialidad:
          map['especialidad'] ?? '',

      telefono:
          map['telefono'] ?? '',

      grupo:
          map['grupo'],
    );
  }
}