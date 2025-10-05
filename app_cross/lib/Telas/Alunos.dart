import 'package:flutter/material.dart';

class CadastroAlunoScreen extends StatefulWidget {
  const CadastroAlunoScreen({super.key});

  @override
  State<CadastroAlunoScreen> createState() => _CadastroAlunoScreenState();
}

class _CadastroAlunoScreenState extends State<CadastroAlunoScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _vencimentoController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _objetivoController = TextEditingController();
  final TextEditingController _obsController = TextEditingController();

  InputDecoration _inputDecoration() {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      filled: true,
      fillColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Container(
              color: Colors.blue[900],
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              child: const Center(
                child: Text(
                  'CADASTRO DE ALUNO',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            // FORM
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Vencimento
                        Row(
                          children: [
                            const Text("Vencimento:"),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                controller: _vencimentoController,
                                decoration: _inputDecoration(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),

                        // Nome
                        const Text("Nome do aluno:"),
                        TextField(
                          controller: _nomeController,
                          decoration: _inputDecoration(),
                        ),
                        const SizedBox(height: 15),

                        // CPF
                        const Text("CPF:"),
                        TextField(
                          controller: _cpfController,
                          decoration: _inputDecoration(),
                        ),
                        const SizedBox(height: 15),

                        // Peso + Telefone
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Peso Inicial"),
                                  TextField(
                                    controller: _pesoController,
                                    decoration: _inputDecoration(),
                                    keyboardType: TextInputType.number,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Telefone"),
                                  TextField(
                                    controller: _telefoneController,
                                    decoration: _inputDecoration(),
                                    keyboardType: TextInputType.phone,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),

                        // Objetivo
                        const Text("Objetivo:"),
                        TextField(
                          controller: _objetivoController,
                          decoration: _inputDecoration(),
                        ),
                        const SizedBox(height: 15),

                        // Observações
                        const Text("Observações:"),
                        TextField(
                          controller: _obsController,
                          maxLines: 4,
                          decoration: _inputDecoration(),
                        ),
                        const SizedBox(height: 25),

                                                // Botão
                                                Center(
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      if (_formKey.currentState!.validate()) {
                                                        ScaffoldMessenger.of(context).showSnackBar(
                                                          const SnackBar(content: Text('Cadastro realizado!')),
                                                        );
                                                      }
                                                    },
                                                    child: const Text('Salvar'),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        }