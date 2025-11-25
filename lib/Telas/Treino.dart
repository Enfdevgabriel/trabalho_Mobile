import 'package:flutter/material.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  final TextEditingController _controller = TextEditingController(
    text: '''
AMRAP 8 MIN
10 Air Squats
8 Push-ups
6 Sit-ups
100m Run

SKILL
5 séries de 3 reps Snatch técnico (leve, 50–60% da carga máxima)
• Entre as séries: 30s de Hollow Rock

WOD – For Time
“12 min Time Cap”
3 Rounds for Time:
12 Deadlifts
9 Burpees over the bar
6 Pull-ups
200m Run
''',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.blue[900],
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              width: double.infinity,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pushNamed(context, '/menu'),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Check - in',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
            Container(
              color: Colors.grey[300],
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              child: const Center(
                child: Text(
                  'Workout Of The Day',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SingleChildScrollView(
                  child: TextField(
                    controller: _controller,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  print("Treino: ${_controller.text}");
                  Navigator.pushNamed(context, '/horarios');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                  padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
                child: const Text('Check-in'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
