import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/volado_controller.dart';
import 'resultados_screen.dart';
import 'widgets/moneda_animada.dart';

class VoladoScreen extends StatefulWidget {
  const VoladoScreen({super.key});

  @override
  State<VoladoScreen> createState() => _VoladoScreenState();
}

class _VoladoScreenState extends State<VoladoScreen> {
  final VoladoController controller = Get.find();
  bool girando = false;
  String resultadoAnimado = '';

  void lanzarAnimado() {
    setState(() {
      girando = true;
      resultadoAnimado = controller.opciones[Random().nextInt(2)];
    });
  }

  void onAnimacionFin() {
    setState(() {
      girando = false;
      controller.lanzarVolado();
      resultadoAnimado = controller.resultado.value;
    });
  }

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
          width: 400,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 12)]),
          child: Obx(() {
            final jugador = controller.turno.value == 0 ? controller.persona1.value : controller.persona2.value;
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Turno de $jugador', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                MonedaAnimada(resultado: girando ? resultadoAnimado : controller.resultado.value, girar: girando, onAnimacionFin: onAnimacionFin),
                const SizedBox(height: 20),
                if (controller.seleccion.value.isEmpty && !girando)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(onPressed: () => controller.seleccionar('Águila'), child: const Text('Águila')),
                      const SizedBox(width: 20),
                      ElevatedButton(onPressed: () => controller.seleccionar('Sol'), child: const Text('Sol')),
                    ],
                  ),
                if (controller.seleccion.value.isNotEmpty && !girando)
                  Column(
                    children: [
                      Text('Elegiste: ${controller.seleccion.value}', style: const TextStyle(fontSize: 18)),
                      const SizedBox(height: 10),
                      SizedBox(width: double.infinity, child: ElevatedButton(onPressed: girando ? null : lanzarAnimado, child: const Text('Lanzar Volado'))),
                    ],
                  ),
                if (controller.feedback.value.isNotEmpty)
                  Padding(padding: const EdgeInsets.symmetric(vertical: 16.0), child: Text(controller.feedback.value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(foregroundColor: Colors.white, side: const BorderSide(color: Colors.white)),
                    onPressed: () async {
                      await controller.guardarResultados();
                      Get.to(() => const ResultadosScreen());
                    },
                    child: const Text('Ver historial', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
