import 'package:flutter/material.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({super.key});

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  String? selectedTime;
  final List<String> times = ["06:00","07:00","12:00","16:30","17:30","18:30","19:30"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 40, left: 10, bottom: 20),
            width: double.infinity,
            decoration: const BoxDecoration(color: Color(0xFF0A0A88)),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(width: 20),
                const Expanded(
                  child: Center(
                    child: Text(
                      "Check-in",
                      style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(width: 40),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9F9F9),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 6, offset: const Offset(0, 4))],
                ),
                child: Column(
                  children: [
                    const Text("Horarios", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: times.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 3, offset: Offset(0,2))],
                            ),
                            child: RadioListTile<String>(
                              value: times[index],
                              groupValue: selectedTime,
                              onChanged: (value) => setState(() => selectedTime = value),
                              title: Center(child: Text(times[index], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                              controlAffinity: ListTileControlAffinity.leading,
                              activeColor: const Color(0xFF0A0A88),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0A0A88),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                        elevation: 5,
                      ),
                      onPressed: () {
                        if (selectedTime != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Horário selecionado: $selectedTime")),
                          );
                        }
                      },
                      child: const Text("Confirmar", style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
