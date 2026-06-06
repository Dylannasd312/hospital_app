import 'package:flutter/material.dart';

import '../controllers/turno_hospitalario_controller.dart';
import '../models/turno_hospitalario.dart';
import 'calendario_turnos_screen.dart';
class TurnoScreen extends StatefulWidget {

  const TurnoScreen({super.key});

  @override
  State<TurnoScreen> createState() =>
      _TurnoScreenState();
}

class _TurnoScreenState
    extends State<TurnoScreen> {

  final controller =
      TurnoHospitalarioController();

  List<TurnoHospitalario> turnos = [];
  List<TurnoHospitalario> turnosFiltrados = [];

  String filtroDia = 'Todos';

  String filtroArea = 'Todas';
  String busquedaMedico = '';

  bool loading = false;

  @override
  void initState() {

    super.initState();

    cargarTurnos();
  }

  Future<void> cargarTurnos() async {

  turnos =
      await controller.listarTurnos();

  aplicarFiltros();
}
void aplicarFiltros() {

  turnosFiltrados = turnos.where((turno) {

    final cumpleDia =

        filtroDia == 'Todos'
            ? true
            : turno.fecha == filtroDia;

    final cumpleArea =

        filtroArea == 'Todas'
            ? true
            : turno.area == filtroArea;

    final cumpleBusqueda =

        busquedaMedico.isEmpty

            ? true

            : turno.medicoNombre
                .toLowerCase()
                .contains(
                  busquedaMedico
                      .toLowerCase(),
                );

    return

        cumpleDia &&
        cumpleArea &&
        cumpleBusqueda;

  }).toList();

  setState(() {});
}
  Future<void> generarSemana() async {

    setState(() {
      loading = true;
    });

    await controller.generarSemana();

    await cargarTurnos();

    if (!mounted) return;

    ScaffoldMessenger.of(context)
        .showSnackBar(

      const SnackBar(

        content: Text(
          'Semana generada correctamente',
        ),
      ),
    );

    setState(() {
      loading = false;
    });
  }

  Future<void> limpiarTurnos() async {

    final confirmar =
        await showDialog<bool>(

      context: context,

      builder: (_) {

        return AlertDialog(

          title: const Text(
            'Eliminar Turnos',
          ),

          content: const Text(
            '¿Desea eliminar todos los turnos de la semana?',
          ),

          actions: [

            TextButton(

              onPressed: () {

                Navigator.pop(
                  context,
                  false,
                );
              },

              child: const Text(
                'Cancelar',
              ),
            ),

            ElevatedButton(

              onPressed: () {

                Navigator.pop(
                  context,
                  true,
                );
              },

              child: const Text(
                'Eliminar',
              ),
            ),
          ],
        );
      },
    );

    if (confirmar != true) {
      return;
    }

    await controller.eliminarTurnos();

    await cargarTurnos();

    if (!mounted) return;

    ScaffoldMessenger.of(context)
        .showSnackBar(

      const SnackBar(

        content: Text(
          'Turnos eliminados',
        ),
      ),
    );
  }
  int totalGrupoA() {

  return turnosFiltrados
      .where(
        (t) => t.grupo == 'A',
      )
      .length;
}

int totalGrupoB() {

  return turnosFiltrados
      .where(
        (t) => t.grupo == 'B',
      )
      .length;
}

int totalObservacion() {

  return turnosFiltrados
      .where(
        (t) =>
            t.area ==
            'Observación',
      )
      .length;
}

int totalIntermedia() {

  return turnosFiltrados
      .where(
        (t) =>
            t.area ==
            'Intermedia',
      )
      .length;
}

int totalIntensiva() {

  return turnosFiltrados
      .where(
        (t) =>
            t.area ==
            'Intensiva',
      )
      .length;
}
  Color colorArea(String area) {

    switch (area) {

      case 'Observación':
        return Colors.blue;

      case 'Intermedia':
        return Colors.orange;

      case 'Intensiva':
        return Colors.red;

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,

      appBar: AppBar(

        title: const Text(
          'Turnos Hospitalarios',
        ),

        centerTitle: true,
      ),

      body: Padding(

        padding:
            const EdgeInsets.all(12),

        child: Column(

          children: [

           Row(

  children: [

    Expanded(

      child: ElevatedButton.icon(

        onPressed:
            loading
                ? null
                : generarSemana,

        icon: const Icon(
          Icons.auto_fix_high,
        ),

        label: const Text(
          'Generar',
        ),
      ),
    ),

    const SizedBox(
      width: 8,
    ),

    Expanded(

      child: ElevatedButton.icon(

        onPressed: () {

          Navigator.push(

            context,

            MaterialPageRoute(

              builder: (_) =>
                  const CalendarioTurnosScreen(),
            ),
          );
        },

        icon: const Icon(
          Icons.calendar_month,
        ),

        label: const Text(
          'Calendario',
        ),
      ),
    ),

    const SizedBox(
      width: 8,
    ),

    Expanded(

      child: ElevatedButton.icon(

        onPressed:
            limpiarTurnos,

        icon: const Icon(
          Icons.delete,
        ),

        label: const Text(
          'Limpiar',
        ),
      ),
    ),
  ],
),

const SizedBox(
  height: 15,
),
            Row(

  children: [

    Expanded(

      child: DropdownButtonFormField<String>(

        value: filtroDia,

        decoration:
            const InputDecoration(

          labelText: 'Día',

          border:
              OutlineInputBorder(),
        ),

        items: const [

          DropdownMenuItem(
            value: 'Todos',
            child: Text('Todos'),
          ),

          DropdownMenuItem(
            value: 'Lunes',
            child: Text('Lunes'),
          ),

          DropdownMenuItem(
            value: 'Martes',
            child: Text('Martes'),
          ),

          DropdownMenuItem(
            value: 'Miércoles',
            child: Text('Miércoles'),
          ),

          DropdownMenuItem(
            value: 'Jueves',
            child: Text('Jueves'),
          ),

          DropdownMenuItem(
            value: 'Viernes',
            child: Text('Viernes'),
          ),

          DropdownMenuItem(
            value: 'Sábado',
            child: Text('Sábado'),
          ),
        ],

        onChanged: (value) {

          filtroDia = value!;

          aplicarFiltros();
        },
      ),
    ),

    const SizedBox(
      width: 10,
    ),

    Expanded(

      child: DropdownButtonFormField<String>(

        value: filtroArea,

        decoration:
            const InputDecoration(

          labelText: 'Área',

          border:
              OutlineInputBorder(),
        ),

        items: const [

          DropdownMenuItem(
            value: 'Todas',
            child: Text('Todas'),
          ),

          DropdownMenuItem(
            value: 'Observación',
            child: Text('Observación'),
          ),

          DropdownMenuItem(
            value: 'Intermedia',
            child: Text('Intermedia'),
          ),

          DropdownMenuItem(
            value: 'Intensiva',
            child: Text('Intensiva'),
          ),
        ],

        onChanged: (value) {

          filtroArea = value!;

          aplicarFiltros();
        },
      ),
    ),
  ],
),

            const SizedBox(
              height: 15,
            ),
            TextField(

  decoration:
      const InputDecoration(

    labelText:
        'Buscar Médico',

    prefixIcon:
        Icon(Icons.search),

    border:
        OutlineInputBorder(),
  ),

  onChanged: (value) {

    busquedaMedico = value;

    aplicarFiltros();
  },
),

const SizedBox(
  height: 15,
),
            Row(

  children: [

    Expanded(

      child: Card(

        child: Padding(

          padding:
              const EdgeInsets.all(
            12,
          ),

          child: Column(

            children: [

              const Text(
                'Grupo A',
              ),

              Text(

                '${totalGrupoA()}',

                style:
                    const TextStyle(

                  fontSize: 22,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    ),

    Expanded(

      child: Card(

        child: Padding(

          padding:
              const EdgeInsets.all(
            12,
          ),

          child: Column(

            children: [

              const Text(
                'Grupo B',
              ),

              Text(

                '${totalGrupoB()}',

                style:
                    const TextStyle(

                  fontSize: 22,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  ],
),

Row(

  children: [

    Expanded(

      child: Card(

        child: Padding(

          padding:
              const EdgeInsets.all(
            12,
          ),

          child: Column(

            children: [

              const Text(
                'Observación',
              ),

              Text(

                '${totalObservacion()}',

                style:
                    const TextStyle(

                  fontSize: 20,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    ),

    Expanded(

      child: Card(

        child: Padding(

          padding:
              const EdgeInsets.all(
            12,
          ),

          child: Column(

            children: [

              const Text(
                'Intermedia',
              ),

              Text(

                '${totalIntermedia()}',

                style:
                    const TextStyle(

                  fontSize: 20,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    ),

    Expanded(

      child: Card(

        child: Padding(

          padding:
              const EdgeInsets.all(
            12,
          ),

          child: Column(

            children: [

              const Text(
                'Intensiva',
              ),

              Text(

                '${totalIntensiva()}',

                style:
                    const TextStyle(

                  fontSize: 20,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  ],
),

const SizedBox(
  height: 10,
),
            Card(

              elevation: 3,

              child: ListTile(

                leading: const Icon(
                  Icons.calendar_month,
                ),

                title: const Text(
                  'Total de Turnos',
                ),

                trailing: Text(

                  '${turnosFiltrados.length}',

                  style: const TextStyle(

                    fontSize: 22,

                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            Expanded(

              child: turnos.isEmpty

                  ? const Center(

                      child: Text(

                        'No existen turnos generados',

                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    )

                  : ListView.builder(

                      itemCount:
                           turnosFiltrados.length,

                      itemBuilder:
                          (context, index) {

                        final turno =
                            turnosFiltrados[index];

                        return Card(

                          elevation: 4,

                          margin:
                              const EdgeInsets.symmetric(
                            vertical: 6,
                          ),

                          shape:
                              RoundedRectangleBorder(

                            borderRadius:
                                BorderRadius.circular(
                              12,
                            ),
                          ),

                          child: ListTile(

                            leading:
                                CircleAvatar(

                              backgroundColor:
                                  colorArea(
                                turno.area,
                              ),

                              child: const Icon(
                                Icons.medical_services,
                                color:
                                    Colors.white,
                              ),
                            ),

                            title: Text(

                              turno.medicoNombre,

                              style:
                                  const TextStyle(

                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            subtitle: Column(

                              crossAxisAlignment:
                                  CrossAxisAlignment.start,

                              children: [

                                Text(
                                  turno.fecha,
                                ),

                                Text(
                                  '${turno.horaInicio} - ${turno.horaFin}',
                                ),

                                Text(
                                  turno.area,
                                ),

                                Text(
                                  'Grupo ${turno.grupo}',
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}