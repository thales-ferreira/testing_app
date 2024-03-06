class Question {
  final String question;
  final List<String> answers;
  final int correctAnswerIndex;

  Question(this.question, this.answers, this.correctAnswerIndex);

  bool isCorrect(int chosenAnswerIndex) {
    return chosenAnswerIndex == correctAnswerIndex;
  }
}
