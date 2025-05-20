import 'package:flutter/material.dart';
import '../providers/volado_provider.dart';

class ResultadosScreen extends StatelessWidget {
  const ResultadosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(title: const Text('Historial de Volados')),
      body: Center(
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 12)]),
          child: FutureBuilder<List<String>>(
            future: VoladoProvider.leerResultados(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final resultados = snapshot.data!;
              if (resultados.isEmpty) {
                return const Center(child: Text('No hay resultados guardados', style: TextStyle(fontSize: 18)));
              }
              return ListView.separated(
                shrinkWrap: true,
                itemCount: resultados.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder:
                    (context, index) => Container(
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      decoration: BoxDecoration(color: Theme.of(context).colorScheme.background.withOpacity(0.7), borderRadius: BorderRadius.circular(12)),
                      child: Text(resultados[index], style: const TextStyle(fontSize: 18)),
                    ),
              );
            },
          ),
        ),
      ),
    );
  }
}
