import 'package:app_cross/Telas/Avisos.dart';
import 'package:app_cross/Telas/Horarios.dart';
import 'package:app_cross/Telas/ResetPassword.dart';
import 'package:app_cross/Telas/plano_screen.dart';
import 'package:app_cross/Telas/Treino.dart';
import 'package:app_cross/Telas/senha.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

// Importações das telas
// import 'Telas/Avisos.dart';
// import 'Telas/Horarios.dart';
import 'Telas/Login.dart';
import 'Telas/Menu.dart';
import 'Telas/Cadastro.dart';
// import 'Telas/Treino.dart';
// import 'Telas/WorkoutScreen.dart';
import 'Telas/Recordes.dart';
import 'Telas/historia.dart';
import 'Telas/Treino_feitos.dart';
// import 'Telas/ForgotPasswordScreen.dart';
// import 'Telas/plano_screen.dart';
// import 'Telas/senha.dart'; // tela de esqueceu a senha

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
      onGenerateRoute: (settings) {
        final uri = Uri.parse(settings.name ?? '/login');

        switch (uri.path) {
          case '/login':
            return MaterialPageRoute(
              builder: (_) => const LoginScreen(),
              settings: settings,
            );
          case '/menu':
            return MaterialPageRoute(
              builder: (_) => MenuScreen(),
              settings: settings,
            );
          case '/cadastrar':
            return MaterialPageRoute(
              builder: (_) => CadastroScreen(),
              settings: settings,
            );
          case '/treinos':
            return MaterialPageRoute(
              builder: (_) => const WorkoutScreen(),
              settings: settings,
            );
          case '/horarios':
            return MaterialPageRoute(
              builder: (_) => const CheckInScreen(),
              settings: settings,
            );
          case '/forgot_password':
            return MaterialPageRoute(
              builder: (_) => const ForgotPasswordScreen(),
              settings: settings,
            );
          case '/reset_password':
          // aqui pegamos o token da query string
            final token = uri.queryParameters['token'] ?? '';
            return MaterialPageRoute(
              builder: (_) => ResetPasswordScreen(token: token),
              settings: settings,
            );
          case '/recordes':
            return MaterialPageRoute(
              builder: (_) => const RecordsScreen(),
              settings: settings,
            );
          case '/historias':
            return MaterialPageRoute(
              builder: (_) => const NossaHistoriaScreen(),
              settings: settings,
            );
          case '/avisos':
            return MaterialPageRoute(
              builder: (_) => const AvisosScreen(),
              settings: settings,
            );
          case '/Treinosfeitos':
            return MaterialPageRoute(
              builder: (_) => const TreinosScreen(),
              settings: settings,
            );
          case '/plano':
            return MaterialPageRoute(
              builder: (_) => const PlanoScreen(),
              settings: settings,
            );
          default:
          // fallback: manda pro login
            return MaterialPageRoute(
              builder: (_) => const LoginScreen(),
              settings: settings,
            );
        }
      },
    );
  }
}
