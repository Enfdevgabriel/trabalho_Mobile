import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

const String apiBaseUrl = 'https://trabalho-web-api.onrender.com'; // ajuste para emulador/device se precisar

class Plano {
  final int id;
  final String nome;
  final double precoMensal;
  final bool ativo;
  final String? descricao;

  Plano({
    required this.id,
    required this.nome,
    required this.precoMensal,
    required this.ativo,
    this.descricao,
  });

  factory Plano.fromJson(Map<String, dynamic> json) {
    return Plano(
      id: json['id'],
      nome: json['nome'],
      precoMensal: (json['precoMensal'] as num).toDouble(),
      ativo: json['ativo'],
      descricao: json['descricao'],
    );
  }
}

class PlanoScreen extends StatefulWidget {
  const PlanoScreen({super.key});

  @override
  State<PlanoScreen> createState() => _PlanoScreenState();
}

class _PlanoScreenState extends State<PlanoScreen> {
  int parcelasSelecionadas = 1;
  String tipoPagamento = "Crédito";

  // Controllers para os campos
  final TextEditingController _ativoAteController = TextEditingController();
  final TextEditingController _numeroCartaoController = TextEditingController();
  final TextEditingController _validadeMesController = TextEditingController();
  final TextEditingController _validadeAnoController = TextEditingController();
  final TextEditingController _nomeNoCartaoController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  List<Plano> _planos = [];
  Plano? _planoSelecionado;

  bool _carregandoPlanos = true;
  bool _enviando = false;
  String? _erro;

  @override
  void initState() {
    super.initState();
    _carregarPlanos();
    _carregarPlanoAtivo();
  }

  Future<void> _carregarPlanos() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('jwt_token');

      if (token == null) {
        setState(() {
          _erro = 'Usuário não autenticado.';
          _carregandoPlanos = false;
        });
        return;
      }

      final uri = Uri.parse('$apiBaseUrl/planos');
      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      print('GET /planos => ${response.statusCode} ${response.body}'); // debug

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final planos = data.map((e) => Plano.fromJson(e)).toList();

        setState(() {
          _planos = planos.where((p) => p.ativo).toList();
          if (_planos.isNotEmpty) {
            _planoSelecionado = _planos.first;
          }
          _carregandoPlanos = false;
        });
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        setState(() {
          _erro = 'Sessão expirada. Faça login novamente.';
          _carregandoPlanos = false;
        });
      } else {
        setState(() {
          _erro = 'Erro ao carregar planos (${response.statusCode})';
          _carregandoPlanos = false;
        });
      }
    } catch (e) {
      print('ERRO /planos: $e');
      setState(() {
        _erro = 'Erro ao carregar planos.';
        _carregandoPlanos = false;
      });
    }
  }

  Future<void> _carregarPlanoAtivo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('jwt_token');

      if (token == null) return;

      final uri = Uri.parse('$apiBaseUrl/me/plano');
      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final planoNome = data['planoNome'];
        final ativoAte = data['ativoAte']; // formato ISO yyyy-MM-dd

        setState(() {
          _ativoAteController.text = ativoAte.toString().split('T').first;
          // Se o plano retornado estiver na lista, seleciona ele
          final existente = _planos.firstWhere(
                  (p) => p.nome == planoNome,
              orElse: () => _planoSelecionado ?? (_planos.isNotEmpty ? _planos.first : Plano(id: -1, nome: 'N/A', precoMensal: 0, ativo: false)));
          if (existente.id != -1) {
            _planoSelecionado = existente;
          }
        });
      } else {
        // 204 ou sem plano ativo -> apenas ignora
      }
    } catch (_) {
      // silencioso
    }
  }

  Future<void> _renovarPlano() async {
    if (_planoSelecionado == null) {
      setState(() {
        _erro = 'Selecione um plano.';
      });
      return;
    }

    if (_numeroCartaoController.text.trim().length < 4 ||
        _validadeMesController.text.trim().isEmpty ||
        _validadeAnoController.text.trim().isEmpty ||
        _nomeNoCartaoController.text.trim().isEmpty ||
        _cvvController.text.trim().isEmpty) {
      setState(() {
        _erro = 'Preencha todos os dados do cartão.';
      });
      return;
    }

    setState(() {
      _erro = null;
      _enviando = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('jwt_token');

      if (token == null) {
        setState(() {
          _erro = 'Usuário não autenticado.';
          _enviando = false;
        });
        return;
      }

      final uri = Uri.parse('$apiBaseUrl/assinaturas');

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'planoId': _planoSelecionado!.id,
          'numeroCartao': _numeroCartaoController.text.trim(),
          'validadeMes': _validadeMesController.text.trim(),
          'validadeAno': _validadeAnoController.text.trim(),
          'nomeNoCartao': _nomeNoCartaoController.text.trim(),
          'cvv': _cvvController.text.trim(),
          'tipoPagamento': tipoPagamento,
          'parcelas': parcelasSelecionadas,
        }),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _ativoAteController.text = data['ativoAte']?.toString().split('T').first ?? '';
        });

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Plano renovado com sucesso!')),
        );
      } else if (response.statusCode == 409) {
        setState(() {
          _erro = 'Você já possui um plano ativo.';
        });
      } else {
        setState(() {
          _erro = 'Erro ao renovar plano (${response.statusCode}).';
        });
      }
    } catch (e) {
      setState(() {
        _erro = 'Erro ao conectar com o servidor.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _enviando = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _ativoAteController.dispose();
    _numeroCartaoController.dispose();
    _validadeMesController.dispose();
    _validadeAnoController.dispose();
    _nomeNoCartaoController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color(0xFF1A237E);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'PLANO',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Center(
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 400),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(
                  child: Text(
                    "Meu Plano",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                if (_erro != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      _erro!,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),

                const SizedBox(height: 5),

                // Ativo até
                _buildTextField(
                  label: "Ativo até:",
                  controller: _ativoAteController,
                  enabled: false,
                ),

                const SizedBox(height: 8),

                // Plano - AGORA COMO DROPDOWN COM DADOS DO BACKEND
                const Text("Plano", style: TextStyle(fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                _carregandoPlanos
                    ? const Center(child: CircularProgressIndicator())
                    : DropdownButton<Plano>(
                  isExpanded: true,
                  value: _planoSelecionado,
                  hint: const Text("Selecione um plano"),
                  items: _planos
                      .map(
                        (p) => DropdownMenuItem(
                      value: p,
                      child: Text("${p.nome} - R\$ ${p.precoMensal.toStringAsFixed(2)}"),
                    ),
                  )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _planoSelecionado = value;
                    });
                  },
                ),

                const SizedBox(height: 8),

                // Número do cartão
                _buildTextField(
                  label: "Número do cartão",
                  hint: "0000 0000 0000 0000",
                  controller: _numeroCartaoController,
                  keyboardType: TextInputType.number,
                ),

                const SizedBox(height: 8),

                // Validade
                const Text("Validade (MM/AAAA):",
                    style: TextStyle(fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: _buildSmallField(
                        hint: "MM",
                        controller: _validadeMesController,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: _buildSmallField(
                        hint: "AAAA",
                        controller: _validadeAnoController,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Nome no cartão
                _buildTextField(
                  label: "Nome no cartão:",
                  hint: "Nome completo",
                  controller: _nomeNoCartaoController,
                ),

                const SizedBox(height: 8),

                // CVV
                _buildTextField(
                  label: "CVV",
                  hint: "123",
                  controller: _cvvController,
                  width: 100,
                  keyboardType: TextInputType.number,
                ),

                const SizedBox(height: 10),

                // Número de parcelas
                const Text("Número de parcelas",
                    style: TextStyle(fontWeight: FontWeight.w500)),
                DropdownButton<int>(
                  isExpanded: true,
                  value: parcelasSelecionadas,
                  items: List.generate(
                    12,
                        (index) => DropdownMenuItem(
                      value: index + 1,
                      child: Text("${index + 1}"),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      parcelasSelecionadas = value!;
                    });
                  },
                ),

                const SizedBox(height: 10),

                // Crédito / Débito
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio<String>(
                        value: "Crédito",
                        groupValue: tipoPagamento,
                        onChanged: (value) {
                          setState(() {
                            tipoPagamento = value!;
                          });
                        },
                      ),
                      const Text("Crédito"),
                      const SizedBox(width: 20),
                      Radio<String>(
                        value: "Débito",
                        groupValue: tipoPagamento,
                        onChanged: (value) {
                          setState(() {
                            tipoPagamento = value!;
                          });
                        },
                      ),
                      const Text("Débito"),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Botão Renovar
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _enviando ? null : _renovarPlano,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: _enviando
                        ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                        : const Text(
                      "Renovar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    String? hint,
    double? width,
    TextEditingController? controller,
    bool enabled = true,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 4),
        SizedBox(
          width: width ?? double.infinity,
          child: TextField(
            controller: controller,
            enabled: enabled,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: Colors.white,
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSmallField({
    String? hint,
    required TextEditingController controller,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      keyboardType: TextInputType.number,
    );
  }
}
