import 'package:flutter/material.dart';
import 'package:testing/models/question.dart';
import 'package:testing/pages/quiz_app.dart';
import 'package:testing/pages/home_page.dart';

class ResultPage extends StatelessWidget {
  final List<int> selectedAnswers;
  final int timeLeft;
  final List<Question> questions;

  const ResultPage({
    Key? key,
    required this.selectedAnswers,
    required this.timeLeft,
    required this.questions,
  }) : super(key: key);

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
        title: const Text('Quiz Results'),
        backgroundColor: const Color(0xff38979a),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Congratulations!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Icon(Icons.star, size: 50, color: Color(0xff3d8784)),
            Text(
              'Your time was: ${timeLeft ~/ 60}:${(timeLeft % 60).toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              'Your score is: $score/${questions.length}',
              style: const TextStyle(fontSize: 20),
            ),
            const Text(
              'Your wrong answers were:',
              style: TextStyle(fontSize: 20),
            ),
            ...wrongAnswers.map((question) => Text(question)).toList(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to homepage
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },
                      child: const Text('Home'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue, // background
                        onPrimary: Colors.white, // foreground
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const QuizApp()),
                        );
                      },
                      child: const Text('Study More'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white, // background
                        onPrimary: Colors.blue, // foreground
                        side:
                            BorderSide(color: Colors.blue, width: 2), // border
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
