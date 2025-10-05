import 'package:app_cross/Telas/Avisos.dart';
import 'package:app_cross/Telas/Cadastro.dart';
import 'package:app_cross/Telas/Recordes.Dart';
import 'package:app_cross/Telas/Treino.dart';
import 'package:app_cross/Telas/Treino_feitos.dart';
import 'package:app_cross/Telas/historia.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'Telas/Menu.dart';
import 'Telas/Horarios.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const CrossLionApp(),
    ),
  );  MaterialApp(
    routes: {
      '/': (context) => LoginScreen(),
      '/menu': (context) => MenuScreen(),
      '/horarios': (context) => CheckInScreen(),
      '/recordes': (context) => RecordesScreen(),
      '/avisos': (context) => AvisosScreen(),
      // Adicione outras telas aqui
    },
    initialRoute: '/',
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CrossLionApp();
  }
}

class CrossLionApp extends StatelessWidget {
  const CrossLionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cross Lion',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/menu': (context) => MenuScreen(),
        '/horarios': (context) => const CheckInScreen(),
        '/recordes': (context) => const RecordsScreen(), 
        '/avisos': (context) => AvisosScreen(),
        '/Cadastrar': (context) =>  CadastroScreen(),
        '/checkin': (context) => const WorkoutScreen(),
        '/treinos': (context) => const TreinosScreen(),
        '/historias': (context) => NossaHistoriaScreen(),
        '/Treinosfeitos': (context) => const TreinosScreen(),
      },
    );
  }
}

class RecordesScreen extends StatelessWidget {
  const RecordesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recordes'),
      ),
      body: const Center(
        child: Text('Conteúdo da tela de recordes'),
      ),
    );
  }
}

// ------------------- LOGIN SCREEN -------------------

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Cross\nLion',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                    shadows: const [
                      Shadow(
                        blurRadius: 3.0,
                        color: Colors.black26,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Bem-Vindo',
                  style: TextStyle(fontSize: 20),
                ),
                const Text(
                  'sobre',
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 30),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // ação para recuperar senha
                    },
                    child: const Text('Esqueceu sua senha?'),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/menu');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50.0, vertical: 15.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0)),
                  ),
                  child: const Text('Entrar'),
                ),
                const SizedBox(height: 15),
                const Text('Ainda não tem conta?'),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 15.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0)),
                  ),
                  child: const Text('Cadastrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
