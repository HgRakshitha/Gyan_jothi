import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/app_router.dart';
import 'quiz_answer_tracker.dart';

/// Replaces the quiz navigation stack with the score screen using [QuizAnswerTracker.takeResults].
void goToQuizResult(
  BuildContext context, {
  required String quizTitle,
  required int totalQuestions,
}) {
  final results = QuizAnswerTracker.takeResults();
  final score = results.where((r) => r.isCorrect).length;
  final total = results.isNotEmpty ? results.length : totalQuestions;
  final uri = Uri(
    path: AppRoutes.quizResult,
    queryParameters: {
      'title': quizTitle,
      'score': '$score',
      'total': '$total',
    },
  );
  context.go(uri.toString(), extra: results);
}
