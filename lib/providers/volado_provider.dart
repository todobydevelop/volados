import 'package:shared_preferences/shared_preferences.dart';

class VoladoProvider {
  static const _keyResultados = 'resultados_volados';

  static Future<void> guardarResultados(List<String> resultados) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_keyResultados, resultados);
  }

  static Future<List<String>> leerResultados() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_keyResultados) ?? [];
  }
}

// Aquí podrías agregar lógica para guardar o consultar resultados de volados en el futuro.
