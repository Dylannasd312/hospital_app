import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  Widget buildButton(BuildContext context, String title, String route) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 60),
      ),
      child: Text(title, style: TextStyle(fontSize: 18)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Panel Principal'),
      ),
      body: Padding(
      padding: EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            buildButton(context, 'Inventario', '/inventario'),
            buildButton(context, 'Turnos Médicos', '/turnos'),
            buildButton(context, 'Gestión de Camas', '/camas'),
            buildButton(context, 'Historia Clínica', '/historia'),
          ],
        ),
      ),
    );
  }
}