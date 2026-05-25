class QuizQuestionResult {
  final String question;
  final String userAnswer;
  final String correctAnswer;
  final bool isCorrect;

  const QuizQuestionResult({
    required this.question,
    required this.userAnswer,
    required this.correctAnswer,
    required this.isCorrect,
  });
}

/// Running list of question results for the current quiz attempt.
/// Reset when the first question of a quiz loads; consumed when showing the result screen.
class QuizAnswerTracker {
  QuizAnswerTracker._();

  static final List<QuizQuestionResult> _results = [];

  static void reset() => _results.clear();

  /// Records a quiz question answer.
  static void record({
    required String question,
    required String userAnswer,
    required String correctAnswer,
    required bool isCorrect,
  }) {
    _results.add(QuizQuestionResult(
      question: question,
      userAnswer: userAnswer,
      correctAnswer: correctAnswer,
      isCorrect: isCorrect,
    ));
  }

  /// Legacy method for backward compatibility: increments correct count if we only pass a boolean.
  static void recordSimple(bool isCorrect, {String? question}) {
    record(
      question: question ?? 'Question',
      userAnswer: isCorrect ? 'Correct' : 'Incorrect',
      correctAnswer: 'Correct',
      isCorrect: isCorrect,
    );
  }

  /// Returns the score (number of correct answers).
  static int get correctCount => _results.where((r) => r.isCorrect).length;

  /// Returns the score and clears the tracker.
  static int takeScore() {
    final s = correctCount;
    _results.clear();
    return s;
  }

  /// Returns the results and clears the tracker (call when opening the result screen).
  static List<QuizQuestionResult> takeResults() {
    final copy = List<QuizQuestionResult>.from(_results);
    _results.clear();
    return copy;
  }
}
