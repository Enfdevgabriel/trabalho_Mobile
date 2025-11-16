import 'package:flutter/material.dart';

class PlanoScreen extends StatefulWidget {
  const PlanoScreen({super.key});

  @override
  State<PlanoScreen> createState() => _PlanoScreenState();
}

class _PlanoScreenState extends State<PlanoScreen> {
  int parcelasSelecionadas = 1;
  String tipoPagamento = "Crédito";

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color(0xFF1A237E); // Azul escuro

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
                const SizedBox(height: 15),

                // Ativo até
                buildTextField(label: "Ativo até:", hint: "00/00/0000"),

                const SizedBox(height: 8),

                // Plano
                buildTextField(label: "Plano", hint: "Ex: Premium Mensal"),

                const SizedBox(height: 8),

                // Número do cartão
                buildTextField(label: "Número do cartão", hint: "0000 0000 0000 0000"),

                const SizedBox(height: 8),

                // Validade
                const Text("Validade (MM/AAAA):",
                    style: TextStyle(fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(child: buildSmallField(hint: "MM")),
                    const SizedBox(width: 10),
                    Flexible(child: buildSmallField(hint: "AAAA")),
                  ],
                ),

                const SizedBox(height: 8),

                // Nome no cartão
                buildTextField(label: "Nome no cartão:", hint: "Nome completo"),

                const SizedBox(height: 8),

                // CVV
                buildTextField(label: "CVV", hint: "123", width: 100),

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
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
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

  Widget buildTextField({
    required String label,
    String? hint,
    double? width,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 4),
        SizedBox(
          width: width ?? double.infinity,
          child: TextField(
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

  Widget buildSmallField({String? hint}) {
    return TextField(
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
