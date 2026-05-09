import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget buildCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    String route,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              blurRadius: 6,
              color: Colors.black12,
              offset: Offset(2, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Icon(
              icon,
              size: 50,
              color: Colors.white,
            ),

            SizedBox(height: 15),

            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('Sistema Hospitalario'),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              'Panel Principal',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Seleccione un módulo',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,

                children: [

                  buildCard(
                    context,
                    'Pacientes',
                    Icons.people,
                    Colors.blue,
                    '/pacientes',
                  ),

                  buildCard(
                    context,
                    'Inventario',
                    Icons.inventory,
                    Colors.orange,
                    '/inventario',
                  ),

                  buildCard(
                    context,
                    'Turnos',
                    Icons.calendar_month,
                    Colors.green,
                    '/turnos',
                  ),

                  buildCard(
                    context,
                    'Camas',
                    Icons.bed,
                    Colors.purple,
                    '/camas',
                  ),

                  buildCard(
                    context,
                    'Historia Clínica',
                    Icons.medical_information,
                    Colors.red,
                    '/historia',
                  ),

                  buildCard(
                    context,
                    'Cerrar Sesión',
                    Icons.logout,
                    Colors.black87,
                    '/',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}