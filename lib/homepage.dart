import 'package:flutter/material.dart';
import 'quiz.dart';
import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              FlutterLogo(size:40),
              Text("Flutter Quiz", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
            ],
          ),
          backgroundColor: Colors.purple,
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/bg.jpg"),
            fit: BoxFit.cover)
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                Bounce(child: Image.asset("assets/images/quiz.png"), infinite: true,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                 Pulse(child: Text("Juega ahora",style: TextStyle(fontSize: 20,fontWeight:FontWeight.w600 ,color: const Color.fromARGB(255, 255, 255, 255))), infinite: true,),
                 SizedBox(height: 20,),
                 FloatingActionButton(onPressed: ()=>{Navigator.pushNamed(context, Quiz.routeName)},
                  child: 
                  FaIcon(FontAwesomeIcons.play)),
                  ],
          
                ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
