import 'package:flutter/material.dart';

import '../controllers/cama_controller.dart';
import '../models/cama.dart';

import '../widgets/cama_card.dart';

import 'hospitalizar_screen.dart';

class CamasScreen extends StatefulWidget {

  const CamasScreen({super.key});

  @override
  State<CamasScreen> createState() =>
      _CamasScreenState();
}

class _CamasScreenState
    extends State<CamasScreen> {

  final controller =
      CamaController();

  List<Cama> camas = [];

  @override
  void initState() {
    super.initState();

    cargarCamas();
  }

  Future<void> cargarCamas() async {

    camas =
        await controller.listarCamas();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title:
            const Text('Gestión de Camas'),
      ),

      body: Padding(

        padding:
            const EdgeInsets.all(12),

        child: GridView.builder(

          itemCount: camas.length,

          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(

            crossAxisCount: 2,

            crossAxisSpacing: 10,

            mainAxisSpacing: 10,
          ),

          itemBuilder: (context, index) {

            final cama = camas[index];

            return CamaCard(

              cama: cama,

              onTap: () async {

                if (cama.estado ==
                    'Disponible') {

                  await Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder: (_) =>
                          HospitalizarScreen(
                        cama: cama,
                      ),
                    ),
                  );

                  cargarCamas();
                }
              },
            );
          },
        ),
      ),
    );
  }
}