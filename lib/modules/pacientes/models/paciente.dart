class Paciente {
  final int? id;
  final String nombre;
  final String apellido;
  final String ci;
  final String fechaNacimiento;
  final String genero;
  final String telefono;
  final String direccion;

  Paciente({
    this.id,
    required this.nombre,
    required this.apellido,
    required this.ci,
    required this.fechaNacimiento,
    required this.genero,
    required this.telefono,
    required this.direccion,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'apellido': apellido,
      'ci': ci,
      'fecha_nacimiento': fechaNacimiento,
      'genero': genero,
      'telefono': telefono,
      'direccion': direccion,
    };
  }

  factory Paciente.fromMap(Map<String, dynamic> map) {
    return Paciente(
      id: map['id'],
      nombre: map['nombre'],
      apellido: map['apellido'],
      ci: map['ci'],
      fechaNacimiento: map['fecha_nacimiento'],
      genero: map['genero'],
      telefono: map['telefono'],
      direccion: map['direccion'],
    );
  }
}