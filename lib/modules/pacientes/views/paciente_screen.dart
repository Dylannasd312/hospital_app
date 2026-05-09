import 'package:flutter/material.dart';

import '../controllers/paciente_controller.dart';
import '../models/paciente.dart';
import '../widgets/paciente_card.dart';

import 'add_paciente_screen.dart';
import 'edit_paciente_screen.dart';

class PacienteScreen extends StatefulWidget {
  const PacienteScreen({super.key});

  @override
  State<PacienteScreen> createState() => _PacienteScreenState();
}

class _PacienteScreenState extends State<PacienteScreen> {

  final controller = PacienteController();

  List<Paciente> pacientes = [];
  List<Paciente> pacientesFiltrados = [];

  final buscarCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    cargarPacientes();
  }

  Future<void> cargarPacientes() async {

    pacientes = await controller.listarPacientes();

    pacientesFiltrados = pacientes;

    setState(() {});
  }

  void eliminar(int id) async {

  final confirmar = await showDialog(

    context: context,

    builder: (context) {

      return AlertDialog(

        title: const Text('Eliminar Paciente'),

        content: const Text(
          '¿Desea eliminar este paciente?',
        ),

        actions: [

          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text('Cancelar'),
          ),

          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: const Text('Eliminar'),
          ),
        ],
      );
    },
  );

  if (confirmar == true) {

    await controller.eliminarPaciente(id);

    cargarPacientes();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Paciente eliminado'),
      ),
    );
  }
}
  void buscarPaciente(String texto) {

    pacientesFiltrados = pacientes.where((p) {

      final nombreCompleto =
          '${p.nombre} ${p.apellido}'.toLowerCase();

      final ci = p.ci.toLowerCase();

      return nombreCompleto.contains(texto.toLowerCase()) ||
          ci.contains(texto.toLowerCase());

    }).toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('Pacientes'),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),

        child: Column(
          children: [

            TextField(
              controller: buscarCtrl,
              onChanged: buscarPaciente,

              decoration: InputDecoration(
                hintText: 'Buscar paciente...',
                prefixIcon: const Icon(Icons.search),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 15),

            Expanded(
              child: pacientesFiltrados.isEmpty

                  ? const Center(
                      child: Text(
                        'No existen pacientes',
                        style: TextStyle(fontSize: 18),
                      ),
                    )

                  : ListView.builder(

                      itemCount: pacientesFiltrados.length,

                      itemBuilder: (context, index) {

                        final paciente =
                            pacientesFiltrados[index];

                        return PacienteCard(

                          paciente: paciente,

                          onDelete: () => eliminar(
                            paciente.id!,
                          ),

                          onEdit: () async {

                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    EditPacienteScreen(
                                  paciente: paciente,
                                ),
                              ),
                            );

                            cargarPacientes();
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),

        onPressed: () async {

          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const AddPacienteScreen(),
            ),
          );

          cargarPacientes();
        },
      ),
    );
  }
}