import 'package:flutter/material.dart';
import 'package:testing/pages/quiz_app.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to the Quiz App!'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            QuizPrompt(),
            SizedBox(height: 20),
            QuizButton(),
          ],
        ),
      ),
    );
  }
}

class QuizPrompt extends StatelessWidget {
  const QuizPrompt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Ready to test your knowledge?',
      style: TextStyle(fontSize: 24),
    );
  }
}

class QuizButton extends StatelessWidget {
  const QuizButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        backgroundColor: const Color(0xff458193),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => QuizApp()),
        );
      },
      child: const Padding(
        padding: EdgeInsets.all(52.0),
        child: Text(
          'Take Test',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
