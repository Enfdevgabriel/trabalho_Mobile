import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Chrome: http://localhost:8080
// Emulador Android: http://10.0.2.2:8080
const String apiBaseUrl = 'https://trabalho-web-api.onrender.com';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;
  String? _erro;

  Future<void> _enviarLink() async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Por favor, insira seu e-mail.")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _erro = null;
    });

    try {
      final uri = Uri.parse('$apiBaseUrl/password/forgot');

      // O app *espera* aqui até a resposta chegar
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        // Fluxo "clássico": só avisa para checar o e-mail
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Se o e-mail existir, enviaremos um link de redefinição para: $email",
            ),
          ),
        );

        // Se você QUISER navegar direto para a tela de redefinição SEM esperar o link,
        // pode descomentar isso (mas aí seu backend teria que aceitar reset só com email):
        //
        // Navigator.pushNamed(
        //   context,
        //   '/reset_password',
        //   arguments: {'email': email},
        // );

      } else {
        setState(() {
          _erro =
          'Erro ao solicitar redefinição (${response.statusCode}). Tente novamente.';
        });
      }
    } catch (e) {
      setState(() {
        _erro = 'Erro ao conectar com o servidor.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text("Esqueceu a Senha"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_erro != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    _erro!,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _enviarLink,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                  padding:
                  const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
                    : const Text(
                  "Enviar link",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
