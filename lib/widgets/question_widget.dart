// File: lib/widgets/question_widget.dart

import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  final String question;
  final String category;
  final double points;
  final int questionNumber;

  const QuestionWidget({
    Key? key,
    required this.question,
    required this.category,
    required this.points,
    required this.questionNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xf413153d),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Question $questionNumber',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    '$points points',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  Text(
                    category,
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                  SizedBox(height: 20),
                  Text(
                    question,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                  // Add your image here
                  // Image.asset('assets/images/your_image.png'),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
