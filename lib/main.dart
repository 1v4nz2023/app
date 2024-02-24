import 'package:flutter/material.dart';
import 'homepage.dart';
import 'quiz.dart';
import 'resultado.dart';



void main() {
  runApp(MiAplicacion());
}


class MiAplicacion extends StatelessWidget {
  const MiAplicacion({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: '/', routes: {
      '/': (context) => Homepage(),
      Quiz.routeName: (context) => Quiz(),
      Resultado.routeName: (context) => Resultado(),
    });
  }
}
