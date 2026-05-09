import 'package:flutter/material.dart';

import '../../pacientes/models/paciente.dart';

import '../controllers/historia_controller.dart';
import '../models/historia_clinica.dart';
import '../widgets/historia_card.dart';

class HistoriasPacienteScreen
    extends StatefulWidget {

  final Paciente paciente;

  const HistoriasPacienteScreen({
    super.key,
    required this.paciente,
  });

  @override
  State<HistoriasPacienteScreen>
      createState() =>
          _HistoriasPacienteScreenState();
}

class _HistoriasPacienteScreenState
    extends State<HistoriasPacienteScreen> {

  final controller =
      HistoriaController();

  List<HistoriaClinica> historias = [];

  @override
  void initState() {
    super.initState();

    cargarHistorias();
  }

  Future<void> cargarHistorias() async {

    historias =
        await controller
            .listarHistoriasPorPaciente(
      widget.paciente.id!,
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text(
          widget.paciente.nombre,
        ),
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

                  onDelete: () {},

                  onRefresh: cargarHistorias,
                );
                },
              ),
      ),
    );
  }
}