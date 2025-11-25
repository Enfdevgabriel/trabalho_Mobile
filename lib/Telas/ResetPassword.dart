// lib/Telas/ResetPassword.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String apiBaseUrl = 'http://localhost:8080';

class ResetPasswordScreen extends StatefulWidget {
  final String token;

  const ResetPasswordScreen({
    super.key,
    required this.token,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _senhaController = TextEditingController();
  final _confirmaController = TextEditingController();
  bool _loading = false;
  String? _erro;
  String? _ok;

  Future<void> _resetarSenha() async {
    final senha = _senhaController.text.trim();
    final confirmar = _confirmaController.text.trim();

    if (senha.isEmpty || confirmar.isEmpty) {
      setState(() => _erro = 'Preencha todos os campos.');
      return;
    }

    if (senha != confirmar) {
      setState(() => _erro = 'As senhas não conferem.');
      return;
    }

    if (widget.token.isEmpty) {
      setState(() => _erro = 'Token não encontrado. Abra o link do e-mail novamente.');
      return;
    }

    setState(() {
      _erro = null;
      _ok = null;
      _loading = true;
    });

    try {
      final uri = Uri.parse('$apiBaseUrl/password/reset');

      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'token': widget.token,
          'novaSenha': senha,
        }),
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        // 👉 Em vez de só mostrar texto aqui, vamos voltar pro login
        //    e mandar um "sinal" dizendo que deu certo.
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/login',
              (route) => false, // limpa a pilha de navegação
          arguments: {'resetSuccess': true},
        );
      } else {
        setState(() {
          _erro = 'Token inválido ou expirado.';
        });
      }
    } catch (_) {
      setState(() {
        _erro = 'Erro ao conectar com o servidor.';
      });
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  void dispose() {
    _senhaController.dispose();
    _confirmaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text('Redefinir senha'),
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
              if (_ok != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    _ok!,
                    style: const TextStyle(color: Colors.green),
                    textAlign: TextAlign.center,
                  ),
                ),
              TextField(
                controller: _senhaController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Nova senha',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _confirmaController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirmar senha',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _loading ? null : _resetarSenha,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                  padding:
                  const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: _loading
                    ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
                    : const Text(
                  "Salvar nova senha",
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
