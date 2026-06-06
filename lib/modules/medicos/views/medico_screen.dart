import 'package:flutter/material.dart';

import '../controllers/medico_controller.dart';
import '../models/medico.dart';

import '../widgets/medico_card.dart';

import 'add_medico_screen.dart';
import 'edit_medico_screen.dart';

class MedicoScreen extends StatefulWidget {
  const MedicoScreen({super.key});

  @override
  State<MedicoScreen> createState() =>
      _MedicoScreenState();
}

class _MedicoScreenState
    extends State<MedicoScreen> {

  final controller =
      MedicoController();

  List<Medico> medicos = [];
  List<Medico> medicosFiltrados = [];

  final buscarCtrl =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    cargarMedicos();
  }

  Future<void> cargarMedicos() async {

    medicos =
        await controller.listarMedicos();

    medicosFiltrados = medicos;

    setState(() {});
  }

  Future<void> eliminar(
    int id,
  ) async {

    final confirmar =
        await showDialog(

      context: context,

      builder: (context) {

        return AlertDialog(

          title: const Text(
            'Eliminar Médico',
          ),

          content: const Text(
            '¿Desea eliminar este médico?',
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

    if (confirmar == true) {

      await controller
          .eliminarMedico(id);

      cargarMedicos();

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(
          content:
              Text('Médico eliminado'),
        ),
      );
    }
  }

  void buscar(String texto) {

    medicosFiltrados =
        medicos.where((m) {

      return m.nombre
              .toLowerCase()
              .contains(
                texto.toLowerCase(),
              ) ||
          m.especialidad
              .toLowerCase()
              .contains(
                texto.toLowerCase(),
              );

    }).toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('Médicos'),
        centerTitle: true,
      ),

      body: Padding(

        padding:
            const EdgeInsets.all(12),

        child: Column(

          children: [

            TextField(

              controller:
                  buscarCtrl,

              onChanged: buscar,

              decoration:
                  InputDecoration(

                hintText:
                    'Buscar médico...',

                prefixIcon:
                    const Icon(
                  Icons.search,
                ),

                border:
                    OutlineInputBorder(

                  borderRadius:
                      BorderRadius
                          .circular(
                    12,
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            Expanded(

              child:
                  medicosFiltrados.isEmpty

                      ? const Center(
                          child: Text(
                            'No existen médicos',
                            style:
                                TextStyle(
                              fontSize:
                                  18,
                            ),
                          ),
                        )

                      : ListView.builder(

                          itemCount:
                              medicosFiltrados
                                  .length,

                          itemBuilder:
                              (context,
                                  index) {

                            final medico =
                                medicosFiltrados[
                                    index];

                            return MedicoCard(

                              medico:
                                  medico,

                              onDelete:
                                  () =>
                                      eliminar(
                                medico.id!,
                              ),

                              onEdit:
                                  () async {

                                await Navigator
                                    .push(

                                  context,

                                  MaterialPageRoute(

                                    builder:
                                        (_) =>
                                            EditMedicoScreen(
                                      medico:
                                          medico,
                                    ),
                                  ),
                                );

                                cargarMedicos();
                              },
                            );
                          },
                        ),
            ),
          ],
        ),
      ),

      floatingActionButton:
          FloatingActionButton(

        child:
            const Icon(Icons.add),

        onPressed: () async {

          await Navigator.push(

            context,

            MaterialPageRoute(

              builder: (_) =>
                  const AddMedicoScreen(),
            ),
          );

          cargarMedicos();
        },
      ),
    );
  }
}