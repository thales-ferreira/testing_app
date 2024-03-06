import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:testing/models/question.dart';
import 'package:testing/pages/result_page.dart';

class QuizApp extends StatefulWidget {
  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
    );
  }

  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  late Timer _timer;
  int _start = 20 * 60; // 20 minutes in seconds
  List<int> selectedAnswers =
      List.filled(30, -1); // Initialize with -1 for no answer selected
  List<Question> questions = [];

  void startTimer() {
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
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
      appBar: AppBar(
        title: Text('Quiz App'),
        backgroundColor: Color(0xff5a97a9),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: _start / (20 * 60),
              semanticsLabel: 'Timer progress',
            ),
            SizedBox(height: 20),
            Text(
              'Time left: ${_start ~/ 60}:${(_start % 60).toString().padLeft(2, '0')}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, questionIndex) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            questions[questionIndex].question,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          ...questions[questionIndex]
                              .answers
                              .asMap()
                              .entries
                              .map((entry) {
                            int answerIndex = entry.key;
                            String answer = entry.value;

                            return RadioListTile<int>(
                              title: Text(answer),
                              value: answerIndex,
                              groupValue: selectedAnswers[questionIndex],
                              onChanged: (int? value) {
                                setState(() {
                                  selectedAnswers[questionIndex] = value!;
                                });
                              },
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              child: Text('Submit'),
              onPressed: () {
                _timer.cancel();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ResultPage(selectedAnswers, _start)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
