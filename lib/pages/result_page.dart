import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final List<int> selectedAnswers;
  final int timeLeft;

  ResultPage(this.selectedAnswers, this.timeLeft);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Results'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                'Congratulations! Your time was: ${timeLeft ~/ 60}:${(timeLeft % 60).toString().padLeft(2, '0')}'),
            Text('Your answers were: $selectedAnswers'),
          ],
        ),
      ),
    );
  }
}
