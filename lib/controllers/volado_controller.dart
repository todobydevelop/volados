import 'package:get/get.dart';
import 'dart:math';
import '../providers/volado_provider.dart';

class VoladoController extends GetxController {
  var resultado = ''.obs;
  final opciones = ['Águila', 'Sol'];
  var persona1 = ''.obs;
  var persona2 = ''.obs;
  var resultados = <String>[].obs;
  var turno = 0.obs; // 0: persona1, 1: persona2
  var seleccion = ''.obs;
  var feedback = ''.obs;

  void setNombres(String p1, String p2) {
    persona1.value = p1;
    persona2.value = p2;
    resultados.clear();
    turno.value = 0;
    seleccion.value = '';
    feedback.value = '';
    resultado.value = '';
  }

  void seleccionar(String opcion) {
    seleccion.value = opcion;
    feedback.value = '';
    resultado.value = '';
  }

  void lanzarVolado() {
    resultado.value = opciones[Random().nextInt(2)];
    final jugador = turno.value == 0 ? persona1.value : persona2.value;
    final acierto = seleccion.value == resultado.value;
    feedback.value = acierto ? '¡$jugador acertó y ganó!' : '$jugador falló y perdió';
    resultados.add('$jugador eligió ${seleccion.value}, salió ${resultado.value}: ${acierto ? 'GANÓ' : 'PERDIÓ'}');
    // Alternar turno
    turno.value = 1 - turno.value;
    seleccion.value = '';
  }

  Future<void> guardarResultados() async {
    await VoladoProvider.guardarResultados(resultados);
  }
}
