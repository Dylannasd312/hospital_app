import 'package:flutter/material.dart';

import '../controllers/historia_controller.dart';
import '../models/historia_clinica.dart';
import '../widgets/historia_card.dart';

import 'add_historia_screen.dart';

class HistoriaScreen extends StatefulWidget {
  const HistoriaScreen({super.key});

  @override
  State<HistoriaScreen> createState() =>
      _HistoriaScreenState();
}

class _HistoriaScreenState
    extends State<HistoriaScreen> {

  final controller = HistoriaController();

  List<HistoriaClinica> historias = [];

  @override
  void initState() {
    super.initState();
    cargarHistorias();
  }

  Future<void> cargarHistorias() async {

    historias =
        await controller.listarHistorias();

    setState(() {});
  }

  void eliminar(int id) async {

    await controller.eliminarHistoria(id);

    cargarHistorias();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title:
            const Text('Historia Clínica'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),

        child: historias.isEmpty

            ? const Center(
                child: Text(
                  'No existen historias clínicas',
                ),
              )

            : ListView.builder(

                itemCount: historias.length,

                itemBuilder: (context, index) {

                  final historia =
                      historias[index];

                  return HistoriaCard(

                  historia: historia,

                  onDelete: () =>
                      eliminar(
                    historia.id!,
                  ),

                  onRefresh: cargarHistorias,
                );
                },
              ),
      ),

      floatingActionButton:
          FloatingActionButton(

        child: const Icon(Icons.add),

        onPressed: () async {

          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const AddHistoriaScreen(),
            ),
          );

          cargarHistorias();
        },
      ),
    );
  }
}