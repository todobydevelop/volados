import 'dart:math';
import 'package:flutter/material.dart';

class MonedaAnimada extends StatefulWidget {
  final String resultado;
  final bool girar;
  final VoidCallback onAnimacionFin;
  const MonedaAnimada({super.key, required this.resultado, required this.girar, required this.onAnimacionFin});

  @override
  State<MonedaAnimada> createState() => _MonedaAnimadaState();
}

class _MonedaAnimadaState extends State<MonedaAnimada> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int vueltas = 12;

  @override
  void initState() {
    super.initState();
    vueltas = 10 + Random().nextInt(11); // 10 a 20 vueltas
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _controller, curve: Curves.linear))..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onAnimacionFin();
      }
    });
    if (widget.girar) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant MonedaAnimada oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.girar && !oldWidget.girar) {
      vueltas = 10 + Random().nextInt(11); // 10 a 20 vueltas
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double totalGiro = vueltas * 2 * pi;
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final giro = _animation.value * totalGiro;
        // El último frame SIEMPRE debe mostrar el resultado real
        final esUltimaVuelta = _animation.value > 0.97;
        final mostrarAguila = esUltimaVuelta ? widget.resultado == 'Águila' : ((giro ~/ pi) % 2 == 0);
        return Transform(
          alignment: Alignment.center,
          transform:
              Matrix4.identity()
                ..setEntry(3, 2, 0.002)
                ..rotateY(giro),
          child: Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.amber[300], boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 12)]),
            alignment: Alignment.center,
            child: Text(mostrarAguila ? '🦅' : '🌞', style: const TextStyle(fontSize: 90)),
          ),
        );
      },
    );
  }
}
