import 'package:flutter/material.dart';
import 'quiz.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
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
              FlutterLogo(size: 300),
              ElevatedButton(
                onPressed: (){
                  Navigator.pushNamed(context, Quiz.routeName);
                },
                child: Text(
                  "Jugar",
                  style: TextStyle(fontSize: 50, color: Colors.blue),
                ),
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.fromLTRB(100, 20, 100, 20),
                    backgroundColor: Colors.blue[50]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
