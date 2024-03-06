import 'package:flutter/material.dart';
import 'package:testing/models/question.dart';

class ResultPage extends StatelessWidget {
  final List<int> selectedAnswers;
  final int timeLeft;
  final List<Question> questions;

  ResultPage(this.selectedAnswers, this.timeLeft, this.questions);

  @override
  Widget build(BuildContext context) {
    int score = 0;
    List<String> wrongAnswers = [];

    for (int i = 0; i < questions.length; i++) {
      if (questions[i].isCorrect(selectedAnswers[i])) {
        score++;
      } else {
        wrongAnswers.add(questions[i].question);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Results'),
        backgroundColor: Color(0xff38979a),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Congratulations!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Your time was: ${timeLeft ~/ 60}:${(timeLeft % 60).toString().padLeft(2, '0')}',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Your score is: $score/${questions.length}',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Your wrong answers were:',
              style: TextStyle(fontSize: 20),
            ),
            ...wrongAnswers.map((question) => Text(question)).toList(),
          ],
        ),
      ),
    );
  }
}
