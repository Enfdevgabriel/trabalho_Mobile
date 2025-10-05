import 'package:flutter/material.dart';

class RecordsScreen extends StatefulWidget {
  const RecordsScreen({super.key});

  @override
  State<RecordsScreen> createState() => _RecordsScreenState();
}

class _RecordsScreenState extends State<RecordsScreen> {
  final List<String> exercises = [
    "Snatch",
    "Back Squat",
    "Clean",
    "Deadlift",
    "Front Squat",
    "Bench Press",
  ];

  late List<TextEditingController> controllers;

  @override
  void initState() {
    super.initState();
    // Inicializa os controllers já com 100 KG
    controllers = List.generate(
      exercises.length,
      (index) => TextEditingController(text: "100 KG"),
    );
  }

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // HEADER AZUL
          Container(
            padding: const EdgeInsets.only(top: 50, bottom: 20),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF0A0A88),
            ),
            child: const Center(
              child: Text(
                "Meus recordes",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // BOTÃO PEDIR
          ElevatedButton(
            onPressed: () {
              // Aqui você pode salvar no banco ou enviar para API
              for (int i = 0; i < exercises.length; i++) {
                debugPrint(
                    "${exercises[i]}: ${controllers[i].text}"); // imprime os valores
              }
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Recordes salvos!")),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0A0A88),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
              elevation: 5,
            ),
            child: const Text(
              "Pedir",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // LISTA DE RECORDES EDITÁVEIS
          Expanded(
            child: ListView.builder(
              itemCount: exercises.length,
              itemBuilder: (context, index) {
                return Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        exercises[index],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        child: TextField(
                          controller: controllers[index],
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
