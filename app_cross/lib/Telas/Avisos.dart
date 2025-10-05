import 'package:flutter/material.dart';

void main() {
  runApp(const CrossfitApp());
}

class CrossfitApp extends StatelessWidget {
  const CrossfitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AvisosScreen(),
    );
  }
}

class AvisosScreen extends StatefulWidget {
  @override
  State<AvisosScreen> createState() => _AvisosScreenState();
}

class _AvisosScreenState extends State<AvisosScreen> {
  final TextEditingController _controller = TextEditingController(
    text: "Teremos evento sábado dia 29/09/2025",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[900],
        title: const Text(
          "AVISOS",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.cyan),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: TextField(
            controller: _controller,
            maxLines: null, // sem limite de linhas
            textAlign: TextAlign.center, // centralizado
            keyboardType: TextInputType.multiline,
            style: const TextStyle(
              fontSize: 18,
              height: 1.5,
              color: Colors.black,
            ),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          alignLabelWithHint: true,
                        ),
                      ),
                    ),
                  ),
                );
              }
            }