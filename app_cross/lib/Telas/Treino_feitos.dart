import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class TreinosScreen extends StatefulWidget {
  const TreinosScreen({super.key});

  @override
  State<TreinosScreen> createState() => _TreinosScreenState();
}

class _TreinosScreenState extends State<TreinosScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Simulação de treinos registrados (em produção você buscaria do banco/local storage)
  Set<DateTime> _treinos = {
    DateTime.utc(2025, 9, 1),
    DateTime.utc(2025, 9, 3),
    DateTime.utc(2025, 9, 5),
    DateTime.utc(2025, 9, 7),
    DateTime.utc(2025, 9, 8),
    DateTime.utc(2025, 9, 11),
  };

  @override
  Widget build(BuildContext context) {
    // Filtra só os treinos do mês atual
    int totalTreinosMes = _treinos
        .where((d) => d.month == _focusedDay.month && d.year == _focusedDay.year)
        .length;

    return Scaffold(
      backgroundColor: Colors.grey[400],
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              color: Colors.blue[900],
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              child: const Center(
                child: Text(
                  'Treinos',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
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
                child: Column(
                  children: [
                    Text(
                      DateFormat.MMMM('pt_BR').format(_focusedDay).toUpperCase(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Calendário
                    Expanded(
                      child: TableCalendar(
                        locale: 'pt_BR',
                        firstDay: DateTime.utc(2020, 1, 1),
                        lastDay: DateTime.utc(2030, 12, 31),
                        focusedDay: _focusedDay,
                        selectedDayPredicate: (day) {
                          return isSameDay(_selectedDay, day);
                        },
                        calendarFormat: CalendarFormat.month,
                        startingDayOfWeek: StartingDayOfWeek.sunday,
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            _selectedDay = selectedDay;
                            _focusedDay = focusedDay;
                          });
                        },
                        calendarStyle: CalendarStyle(
                          todayDecoration: BoxDecoration(
                            color: Colors.blue[300],
                            shape: BoxShape.circle,
                          ),
                          selectedDecoration: BoxDecoration(
                            color: Colors.blue[900],
                            shape: BoxShape.circle,
                          ),
                          markerDecoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                        eventLoader: (day) {
                          // Marca os dias que tem treino
                          return _treinos
                                  .any((d) => isSameDay(d, day))
                              ? ['Treino']
                              : [];
                        },
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Total de treinos
                    Text(
                      "Total de treinos no mês: $totalTreinosMes",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  bool isSameDay(DateTime? d, DateTime? day) {
    if (d == null || day == null) return false;
    return d.year == day.year && d.month == day.month && d.day == day.day;
  }
}





