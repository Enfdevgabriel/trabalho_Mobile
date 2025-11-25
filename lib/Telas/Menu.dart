import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MenuScreen extends StatelessWidget {
  final Color primaryColor = const Color(0xFF1A237E);

  MenuScreen({super.key});

final List<Map<String, dynamic>> menuItems = [
  {
    'icon': 'lib/Assets/check.png',
    'text': 'CHECK IN',
    'route': '/treinos',
  },
  {
    'icon': 'lib/Assets/mao.png',
    'text': 'MEU PLANO',
    'route': '/plano',
  },
  {
    'icon': 'lib/Assets/Halter.png',
    'text': 'RECORDS - PR',
    'route': '/recordes',
  },
  {
    'icon': 'lib/Assets/calendario.png',
    'text': 'MEUS TREINOS',
    'route': '/Treinosfeitos',
  },
  {
    'icon': 'lib/Assets/avisos.png',
    'text': 'AVISOS',
    'route': '/avisos',
  },
  {
    'icon': 'lib/Assets/Lion.jpg',
    'text': 'SOBRE NÓS',
    'route': '/historias',
  },
];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('MENU'),
        automaticallyImplyLeading: false, // Remove o botão de voltar
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 1.1,
        ),
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return _MenuCard(
            icon: item['icon'],
            text: item['text'],
            onTap: () => Navigator.pushNamed(context, item['route']),
          );
        },
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final dynamic icon; // Can be IconData or String
  final String text;
  final VoidCallback onTap;

  const _MenuCard({
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget leadingWidget;

    if (icon is IconData) {
      leadingWidget = Icon(icon, size: 48, color: theme.colorScheme.primary);
    } else if (icon is String) {
      leadingWidget = Image.asset(
        icon,
        width: 48,
        height: 48,
        fit: BoxFit.contain,
      );
    } else {
      leadingWidget = const SizedBox.shrink();
    }

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            leadingWidget,
            const SizedBox(height: 16),
            Text(
              text,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
