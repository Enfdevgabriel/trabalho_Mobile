import 'package:app_cross/Telas/Avisos.dart';
import 'package:app_cross/Telas/Horarios.dart';
import 'package:app_cross/Telas/plano_screen.dart';
import 'package:app_cross/Telas/Treino.dart';
import 'package:app_cross/Telas/senha.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

// Importações das telas
import 'Telas/Avisos.dart';
import 'Telas/Horarios.dart';
import 'Telas/Login.dart';
import 'Telas/Menu.dart';
import 'Telas/Cadastro.dart';
import 'Telas/Treino.dart';
import 'Telas/WorkoutScreen.dart';
import 'Telas/CheckInScreen.dart';
import 'Telas/Recordes.dart';
import 'Telas/historia.dart';
import 'Telas/avisos_screen.dart';
import 'Telas/Treino_feitos.dart';
import 'Telas/ForgotPasswordScreen.dart';
import 'Telas/plano_screen.dart';
import 'Telas/senha.dart'; // tela de esqueceu a senha

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const CrossfitApp(),
    ),
  );
}

class CrossfitApp extends StatelessWidget {
  const CrossfitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crossfit App',
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/menu': (context) => MenuScreen(),
        '/cadastrar': (context) => CadastroScreen(),
        '/treinos': (context) => const WorkoutScreen(), // Tela de treino
        '/horarios': (context) => const CheckInScreen(), // Tela de horários
        '/forgot_password': (context) => const ForgotPasswordScreen(), // Tela de redefinição
        '/recordes': (context) => const RecordsScreen(),
        '/historias': (context) => const NossaHistoriaScreen(),
        '/avisos': (context) => const AvisosScreen(),
        '/Treinosfeitos': (context) => const TreinosScreen(),

        //  nova rota para a tela de "Meu Plano"
        '/plano': (context) => const PlanoScreen(),
      },
    );
  }
}
