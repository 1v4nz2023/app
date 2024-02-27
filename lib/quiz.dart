import 'package:flutter/material.dart';
import 'resultado.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'quiz_datos.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Argumentos {
  final int puntos;
  final int malas;
  double resultadonumerico;
  final int vacias;
  String resultado;
  Color color;
  Image image;

  Argumentos(
      this.puntos,
      this.resultado,
      this.color,
      this.image,
      this.malas,
      this.vacias,
      this.resultadonumerico); // Constructor para la clase Argumentos.
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
  int malas = 0;
  int vacias = 0;
  double resultadonumerico = 0;
  String resultado = "";
  Color color = Colors.black;
  Image image = Image.asset("");

  void verificarResultado() {
    if (puntos >= 7) {
      resultado = "Felicidades, lo lograste";
      color = Colors.green;
      image = Image.asset("assets/images/win.gif");
    } else {
      resultado = "Debes de estudiar más";
      color = Colors.red;
      image = Image.asset("assets/images/fail.gif");
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
            vacias++;
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
        nextPage();
      }
    });
  }

  void nextPage() {
    Navigator.pushNamed(context, Resultado.routeName,
        arguments: Argumentos(
            puntos, resultado, color, image, malas, vacias, resultadonumerico));
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

  void correctAnswer(int i) {
    if (quiz[preguntaNumero - 1]["respuestas"][i]
        .toString()
        .contains(quiz[preguntaNumero - 1]["alternativa correcta"])) {
      playCorrect();
      puntos++;
    } else {
      playWrong();
      malas++;
    }
    resultadonumerico = puntos.toDouble() * 2 - malas * 0.5;

    if (resultadonumerico < 0.0) {
      resultadonumerico = 0.0;
    }
    Pasar();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              FlutterLogo(size: 40),
              Text("Flutter Quiz",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold))
            ],
          ),
          backgroundColor: Colors.purple,
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/bg.jpg"),
                  fit: BoxFit.cover)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    "Pregunta $preguntaNumero de 10  ",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.clock,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Tiempo restante: $tiempo  ",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.purple[800],
                  ),
                  child: SizedBox(
                    height: 120,
                    child: Center(
                      // Asegura que el contenido (Text) se centre en el SizedBox
                      child: Text(
                        quiz[preguntaNumero - 1]["pregunta"],
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),

                        textAlign:
                            TextAlign.center, // Centra el texto horizontalmente
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      correctAnswer(0);
                    },
                    child: Text(
                      quiz[preguntaNumero - 1]["respuestas"][0],
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.purple[800],
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        backgroundColor: Color.fromARGB(255, 201, 150, 233)),
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
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.purple[800],
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        backgroundColor: Color.fromARGB(255, 201, 150, 233)),
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
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.purple[800],
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        backgroundColor: Color.fromARGB(255, 201, 150, 233)),
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
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.purple[800],
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        backgroundColor: Color.fromARGB(255, 201, 150, 233)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
