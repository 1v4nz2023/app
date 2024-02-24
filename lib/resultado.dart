import 'package:flutter/material.dart';
import 'quiz.dart'; // Asegúrate de que este import sea correcto y corresponda a tus archivos.
import 'package:audioplayers/audioplayers.dart';

class Resultado extends StatelessWidget {
  const Resultado({super.key});
  static const routeName = '/resultado';
  @override
  Widget build(BuildContext context) {
    final argumentos = ModalRoute.of(context)?.settings.arguments as Argumentos;
    final player = AudioPlayer();

    void playWin() async {
      await player.play(AssetSource('music/win.mp3'));
    }

    void playLoose() async {
      await player.play(AssetSource('music/lose.mp3'));
    }

    if (argumentos.puntos >= 7) {
      Future.delayed(Duration(seconds: 1), () {
        playWin();
      });
    } else {
      Future.delayed(Duration(seconds: 1), () {
        playLoose();
      });
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Padding(
              padding: EdgeInsets.all(20.0),
              child: Center(child: Text("Quiz"))),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Resultado',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                argumentos.resultado,
                style: TextStyle(fontSize: 20, color: argumentos.color),
              ),
              Text(
                'Usted acertó ${argumentos.puntos} de 10 Preguntas',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    player.stop();

                    Navigator.pushNamed(context, Quiz.routeName);
                  },
                  child: Text(
                    "Jugar nuevamente",
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 20)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
