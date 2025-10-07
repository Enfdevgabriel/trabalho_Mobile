import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  final Color primaryColor = const Color(0xFF1A237E);

  MenuScreen({super.key});

  Widget menuButton(BuildContext context, String text, String route) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/login'); // volta para login
          },
        ),
        title: const Center(
          child: Text(
            'MENU',
            style: TextStyle(
              fontSize: 24,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            menuButton(context, 'CHECK IN', '/treinos'),
            menuButton(context, 'RECORDS - PR', '/recordes'),
            menuButton(context, 'MEUS TREINOS','/Treinosfeitos'),
            menuButton(context, 'AVISOS', '/avisos'),
            menuButton(context, 'HISTORIA', '/historias'),
          ],
        ),
      ),
    );
  }
}
