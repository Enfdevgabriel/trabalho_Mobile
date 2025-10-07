import 'package:flutter/material.dart';

class AvisosScreen extends StatefulWidget {
  const AvisosScreen({super.key});

  @override
  State<AvisosScreen> createState() => _AvisosScreenState();
}

class _AvisosScreenState extends State<AvisosScreen> {
  final TextEditingController _controller = TextEditingController(
      text: "Teremos evento sábado dia 29/09/2025");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[900],
        title: const Text("AVISOS", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.cyan), onPressed: () => Navigator.pop(context)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: TextField(
            controller: _controller,
            maxLines: null,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.multiline,
            style: const TextStyle(fontSize: 18, height: 1.5, color: Colors.black),
            decoration: const InputDecoration(border: OutlineInputBorder(), alignLabelWithHint: true),
          ),
        ),
      ),
    );
  }
}
