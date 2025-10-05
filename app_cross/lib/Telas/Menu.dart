import 'package:flutter/material.dart';

void main() {
  runApp(CrossLionApp());
}

class CrossLionApp extends StatelessWidget {
  const CrossLionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MenuScreen(),
    );
  }
}

class MenuScreen extends StatelessWidget {
  final Color primaryColor = Color(0xFF1A237E);

  MenuScreen({super.key}); 

  Widget menuButton(BuildContext context, String text, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          padding: EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Center(
          child: Text(
            'MENU',
            style: TextStyle(
              fontSize: 24,
              letterSpacing: 2,
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // ação de voltar
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            menuButton(context, 'CHECK IN', () 
            {Navigator.pushNamed(context, '/checkin');}),

            menuButton(context, 'MEU PLANO', () {
              Navigator.pushNamed(context, '/Meu Plano');}),

            menuButton(context, 'RECORDS - PR', () {
              Navigator.pushNamed(context, '/recordes');
            }),
            menuButton(context, 'MEUS TREINOS', () {
             Navigator.pushNamed(context, '/Treinosfeitos');
            }),          
            menuButton(context, 'AVISOS', () {
            Navigator.pushNamed(context, '/avisos');
}),
            menuButton(context, 'historia', () {
              Navigator.pushNamed(context, '/historias');}),
          ],
        ),
      ),
    );
  }
}
