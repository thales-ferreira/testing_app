import 'package:flutter/material.dart';
import 'package:testing/pages/quiz_app.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QuizPrompt(),
            SizedBox(height: 20),
            QuizButton(),
            SizedBox(height: 20),
            Text(
              'Good luck!',
              style: TextStyle(color: Color(0xff090808), fontSize: 16),
            ),
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
    return Text(
      'Ready to practice?',
      style: TextStyle(color: Color(0xff2e2b2b), fontSize: 24),
    );
  }
}

class QuizButton extends StatelessWidget {
  const QuizButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        primary: Color(0xff15A4C2), // Change the button color to blue
        padding: EdgeInsets.all(52.0),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const QuizApp()),
        );
      },
      child: Text(
        'Do Quiz',
        style: TextStyle(color: Color(0xfffbfbfb), fontSize: 20),
      ),
    );
  }
}
