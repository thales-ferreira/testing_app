import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:testing/models/question.dart';
import 'package:testing/widgets/custom_button.dart';
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

    double percent = score / questions.length;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularPercentIndicator(
              radius: 90.0,
              lineWidth: 60.0,
              animation: true,
              percent: percent,
              center: Text(
                "${(percent * 100).round()}%",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              circularStrokeCap: CircularStrokeCap.butt,
              progressColor: Colors.blue,
            ),
            const Text(
              'Congratulations!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Icon(Icons.star, size: 50, color: Color(0xff3d8784)),
            Text(
              '$score/${questions.length}',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              '${(timeLeft ~/ 60)}:${(timeLeft % 60).toString().padLeft(2, '0')} mins left',
              style: const TextStyle(fontSize: 20),
            ),
            const Text(
              'Incorrect answers:',
              style: TextStyle(fontSize: 20),
            ),
            Expanded(
              child: Card(
                margin: const EdgeInsets.all(8.0),
                child: ListView(
                  padding: const EdgeInsets.all(8.0),
                  children: wrongAnswers
                      .map((question) => ListTile(
                            contentPadding: const EdgeInsets.all(8.0),
                            title: Container(
                              color: const Color(0xff813631),
                              child: Text(question,
                                  style: const TextStyle(color: Colors.white)),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Home',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },
                    backgroundColor: const Color(0xff15A4C2),
                    foregroundColor: Colors.white,
                  ),
                ),
                Expanded(
                  child: CustomButton(
                    text: 'Study More',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const QuizApp()),
                      );
                    },
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xff15A4C2),
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
