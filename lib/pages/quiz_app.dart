// File: lib/pages/quiz_app.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:testing/models/question.dart';
import 'package:testing/pages/result_page.dart';
import 'package:testing/widgets/options_widget.dart'; // Import QuizWidget
import 'package:testing/widgets/question_widget.dart'; // Import QuestionWidget

class QuizApp extends StatefulWidget {
  const QuizApp({Key? key}) : super(key: key);
  @override
  QuizAppState createState() => QuizAppState();
}

class QuizAppState extends State<QuizApp> {
  late Timer _timer;
  int _start = 20 * 60; // 20 minutes in seconds
  List<int> selectedAnswers =
      List.filled(30, -1); // Initialize with -1 for no answer selected
  List<Question> questions = [];

  int get timeLeft => _start;

  void startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (_start == 0) {
          timer.cancel();
          // Navigate to ResultPage or show an alert
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  Future<void> loadQuestions() async {
    String jsonString = await rootBundle.loadString('assets/questions.json');
    List<dynamic> json = jsonDecode(jsonString);
    questions = json.map((question) {
      List<String> answers = List<String>.from(question['answers']);
      return Question(
          question['question'], answers, question['correctAnswerIndex']);
    }).toList();
    questions.shuffle();
    startTimer();
  }

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Quiz App'),
      //   backgroundColor: const Color(0xff15A4C2),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: _start / (20 * 60),
              semanticsLabel: 'Timer progress',
            ),
            const SizedBox(height: 20),
            Text(
              'Time left: ${_start ~/ 60}:${(_start % 60).toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, questionIndex) {
                  return Column(
                    children: [
                      QuestionWidget(
                        question: questions[questionIndex].question,
                        category: 'Law', // Replace with your category
                        points: 1, // Replace with your points
                        questionNumber: questionIndex + 1,
                      ),
                      OptionsWidget(
                        question: questions[questionIndex],
                        selectedAnswer: selectedAnswers[questionIndex],
                        onAnswerSelected: (int? value) {
                          setState(() {
                            selectedAnswers[questionIndex] = value!;
                          });
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
            ElevatedButton(
              child: const Text('Submit'),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ResultPage(
                            selectedAnswers: selectedAnswers,
                            timeLeft: timeLeft,
                            questions: questions,
                          )),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
