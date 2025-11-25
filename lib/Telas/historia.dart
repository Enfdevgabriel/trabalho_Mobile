import 'package:flutter/material.dart';

class NossaHistoriaScreen extends StatefulWidget {
  const NossaHistoriaScreen({super.key});

  @override
  State<NossaHistoriaScreen> createState() => _NossaHistoriaScreenState();
}

class _NossaHistoriaScreenState extends State<NossaHistoriaScreen> {
  final TextEditingController _controller = TextEditingController(
      text:
          "O CrossFit é um programa de treinamento que enfatiza a força e o condicionamento físico por meio de uma variedade de exercícios funcionais, realizados em alta intensidade. "
          "A metodologia é projetada para melhorar a aptidão geral, englobando aspectos como resistência cardiovascular, força, flexibilidade, potência, velocidade, coordenação, "
          "agilidade, equilíbrio e precisão.");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[900],
        title: const Text("Nossa História", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.cyan), onPressed: () => Navigator.pop(context)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: TextField(
            controller: _controller,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            style: const TextStyle(fontSize: 16, height: 1.5),
            decoration: const InputDecoration(border: OutlineInputBorder(), alignLabelWithHint: true),
          ),
        ),
      ),
    );
  }
}
