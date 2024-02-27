import 'package:flutter/material.dart';
import 'quiz.dart'; // Asegúrate de que este import sea correcto y corresponda a tus archivos.
import 'package:audioplayers/audioplayers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                Container(
                  child: argumentos.image,
                  width: 200,
                  height: 200,
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 201, 150, 233),
                    ),
                    child: SizedBox(
                      width: 300,
                      height:
                          150,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize
                              .min, 
                          children: [
                            Text(
                              'Tu puntaje es:',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.purple[800],
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),                            
                            Text(
                              argumentos.resultadonumerico.toString(),
                              style: TextStyle(
                                  fontSize: 50,
                                  color: Colors.purple[800],
                                  fontWeight: FontWeight.bold),
                            ),                            
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              argumentos.resultado,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: argumentos.color,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  'Resumen',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(FontAwesomeIcons.circleCheck,
                              color: Colors.white), // Icono
                          Text(
                            'Correctas: ' +
                                argumentos.puntos.toString(), // Texto
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(FontAwesomeIcons.circleXmark,
                              color: Colors.white), // Icono
                          Text(
                            'Malas: ' + argumentos.malas.toString(), // Texto
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(FontAwesomeIcons.circleQuestion,
                              color: Colors.white), // Icono
                          Text(
                            'Vacías: ' + argumentos.vacias.toString(), // Texto
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ],
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
      ),
    );
  }
}
