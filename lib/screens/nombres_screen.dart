import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/volado_controller.dart';
import 'volado_screen.dart';

class NombresScreen extends StatelessWidget {
  NombresScreen({super.key});
  final TextEditingController persona1Controller = TextEditingController();
  final TextEditingController persona2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Volados'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 0,
              ),
              child: const Text('REGISTRARSE'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(foregroundColor: Colors.white, side: const BorderSide(color: Colors.white), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
              child: const Text('INICIAR SESIÓN'),
            ),
          ),
        ],
      ),
      body: Center(
        child: Container(
          width: 370,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 12)]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Ingresa los nombres de los jugadores', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              TextField(controller: persona1Controller, decoration: const InputDecoration(labelText: 'Nombre persona 1')),
              const SizedBox(height: 16),
              TextField(controller: persona2Controller, decoration: const InputDecoration(labelText: 'Nombre persona 2')),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (persona1Controller.text.isNotEmpty && persona2Controller.text.isNotEmpty) {
                      Get.put(VoladoController()).setNombres(persona1Controller.text, persona2Controller.text);
                      Get.off(() => const VoladoScreen());
                    }
                  },
                  child: const Text('Comenzar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
