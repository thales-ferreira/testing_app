import 'package:flutter/material.dart';
import 'package:testing/pages/quiz_app.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Take Test'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QuizApp()),
            );
          },
        ),
      ),
    );
  }
}
