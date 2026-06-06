import 'package:flutter/material.dart';

import '../controllers/cama_controller.dart';

import '../models/cama.dart';

import '../widgets/cama_card.dart';

import 'hospitalizar_screen.dart';
import 'detalle_cama_screen.dart';

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

  List<Cama> camasFiltradas = [];

  String filtroActual = 'Todas';

  @override
  void initState() {
    super.initState();

    cargarCamas();
  }

  Future<void> cargarCamas() async {

    camas =
        await controller.listarCamas();

    aplicarFiltro(filtroActual);
  }

  void aplicarFiltro(
    String tipo,
  ) {

    filtroActual = tipo;

    if (tipo == 'Todas') {

      camasFiltradas = camas;

    } else {

      camasFiltradas =
          camas.where((c) {

        return c.tipo == tipo;

      }).toList();
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title:
            const Text('Gestión de Camas'),
      ),

      body: Column(

        children: [

          Padding(

            padding:
                const EdgeInsets.all(12),

            child: DropdownButtonFormField<String>(

              value: filtroActual,

              decoration:
                  const InputDecoration(

                labelText:
                    'Filtrar Tipo',

                border:
                    OutlineInputBorder(),
              ),

              items: [

                'Todas',

                'Observación',

                'Intermedia',

                'Intensiva',

              ].map((tipo) {

                return DropdownMenuItem(

                  value: tipo,

                  child: Text(tipo),
                );
              }).toList(),

              onChanged: (value) {

                aplicarFiltro(value!);
              },
            ),
          ),

          Expanded(

            child: Padding(

              padding:
                  const EdgeInsets.all(12),

              child: GridView.builder(

                itemCount:
                    camasFiltradas.length,

                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(

                  crossAxisCount: 2,

                  crossAxisSpacing: 10,

                  mainAxisSpacing: 10,
                ),

                itemBuilder:
                    (context, index) {

                  final cama =
                      camasFiltradas[index];

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

                      } else {

                        await Navigator.push(

                          context,

                          MaterialPageRoute(

                            builder: (_) =>
                                DetalleCamaScreen(
                              cama: cama,
                            ),
                          ),
                        );
                      }

                      cargarCamas();
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}