import 'package:flutter/material.dart';
import 'package:testing/models/question.dart';

class QuizWidget extends StatelessWidget {
  final int selectedAnswer;
  final ValueChanged<int?> onAnswerSelected;
  final Question question;

  const QuizWidget({
    Key? key,
    required this.selectedAnswer,
    required this.onAnswerSelected,
    required this.question,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question.question,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...question.answers.asMap().entries.map((entry) {
              int answerIndex = entry.key;
              String answer = entry.value;

              return RadioListTile<int>(
                title: Text(answer),
                value: answerIndex,
                groupValue: selectedAnswer,
                onChanged: onAnswerSelected,
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
