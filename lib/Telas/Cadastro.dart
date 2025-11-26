import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController confirmaSenhaController = TextEditingController();

  bool _isLoading = false;

  static const String baseUrl = 'https://trabalho-web-api.onrender.com';

  Future<void> _registrarUsuario() async {
    final nome = nomeController.text.trim();
    final email = emailController.text.trim();
    final senha = senhaController.text.trim();
    final confirmaSenha = confirmaSenhaController.text.trim();

    // Validações básicas no cliente
    if (nome.isEmpty || email.isEmpty || senha.isEmpty || confirmaSenha.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Preencha todos os campos."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (senha != confirmaSenha) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("As senhas não conferem."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final url = Uri.parse('$baseUrl/register');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'senha': senha,
          // o backend só espera email/senha; nome está só no app por enquanto
        }),
      );

      if (response.statusCode == 201) {
        // Sucesso: backend retorna LoginResponse com token
        final json = jsonDecode(response.body);
        final token = json['token']; // se o campo no LoginResponse for "token"

        // aqui você pode salvar o token (SharedPreferences, etc.)
        // por enquanto só mostra o sucesso
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Usuário cadastrado com sucesso!"),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pop(context);
      } else if (response.statusCode == 409) {
        // conflito (e-mail já em uso) - backend devolve mensagem em texto
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.body),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Erro ao cadastrar (${response.statusCode}): ${response.body}",
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erro de conexão: $e"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CADASTRO"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            _buildTextField(
              controller: nomeController,
              hintText: "Nome Completo",
              icon: Icons.person_outline,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: emailController,
              hintText: "E-mail",
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: senhaController,
              hintText: "Senha",
              icon: Icons.lock_outline,
              isPassword: true,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: confirmaSenhaController,
              hintText: "Confirme sua senha",
              icon: Icons.lock_outline,
              isPassword: true,
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: _isLoading ? null : _registrarUsuario,
              child: _isLoading
                  ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
                  : const Text("Cadastrar"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon, color: Colors.grey[600]),
      ),
    );
  }
}
