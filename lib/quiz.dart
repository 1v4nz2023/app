import 'package:flutter/material.dart';
import 'resultado.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'quiz_datos.dart';

class Argumentos {
  final int puntos;
  String resultado;
  Color color;

  Argumentos(this.puntos, this.resultado,
      this.color); // Constructor para la clase Argumentos.
}

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  static const routeName = '/quiz';

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  Timer? timer;
  int tiempo = 10;
  int preguntaNumero = 1;
  int puntos = 0;
  String resultado = "";
  Color color = Colors.black;

  void verificarResultado() {
    if (puntos >= 7) {
      resultado = "Felicidades, lo lograste";
      color = Colors.green;
    } else {
      resultado = "Debes de estudiar más";
      color = Colors.red;
    }
  }

  void playCorrect() async {
    final player = AudioPlayer();
    await player.play(AssetSource('music/good.mp3'));
  }

  void playWrong() async {
    final player = AudioPlayer();
    await player.play(AssetSource('music/wrong.mp3'));
  }

  void Temporizador() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (tiempo > 0) {
        setState(() {
          tiempo--;
          if (tiempo == 0) {
            Pasar();
            playWrong();
          }
        });
      } else {
        timer.cancel();
      }
    });
  }

  void Pasar() {
    setState(() {
      preguntaNumero++;
      tiempo = 10;
      if (preguntaNumero == 11) {
        verificarResultado();
        Reiniciar();
      }
    });
  }

  void Reiniciar() {
    Navigator.pushNamed(context, Resultado.routeName,
        arguments: Argumentos(puntos, resultado, color));

    dispose();
    preguntaNumero = 1;
  }

  @override
  void initState() {
    super.initState();
    quiz.shuffle();
    Temporizador();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void correctAnswer(int i) {
      if (quiz[preguntaNumero - 1]["respuestas"][i]
          .toString()
          .contains(quiz[preguntaNumero - 1]["alternativa correcta"])) {
        playCorrect();
        puntos++;
      } else {
        playWrong();
      }
      Pasar();
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Quiz")),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  "Pregunta $preguntaNumero de 10  ",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  "Tiempo restante: $tiempo  ",
                  style: TextStyle(fontSize: 20, color: Colors.red),
                ),
              ),
              Text(
                "Pregunta: " + quiz[preguntaNumero - 1]["pregunta"],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    correctAnswer(0);
                  },
                  child: Text(
                    quiz[preguntaNumero - 1]["respuestas"][0],
                    style: TextStyle(fontSize: 20, color: Colors.blue),
                  ),
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                      backgroundColor: Colors.blue[50]),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    correctAnswer(1);
                  },
                  child: Text(
                    quiz[preguntaNumero - 1]["respuestas"][1],
                    style: TextStyle(fontSize: 20, color: Colors.blue),
                  ),
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                      backgroundColor: Colors.blue[50]),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    correctAnswer(2);
                  },
                  child: Text(
                    quiz[preguntaNumero - 1]["respuestas"][2],
                    style: TextStyle(fontSize: 20, color: Colors.blue),
                  ),
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                      backgroundColor: Colors.blue[50]),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    correctAnswer(3);
                  },
                  child: Text(
                    quiz[preguntaNumero - 1]["respuestas"][3],
                    style: TextStyle(fontSize: 20, color: Colors.blue),
                  ),
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                      backgroundColor: Colors.blue[50]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
