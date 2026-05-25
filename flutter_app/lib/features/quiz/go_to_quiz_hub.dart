import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/app_router.dart';

/// Yellow [QuizHeader] back: leave the current quiz flow and open the quiz hub.
void goToQuizHub(BuildContext context) {
  if (context.canPop()) {
    context.pop();
  } else {
    context.go(AppRoutes.quiz);
  }
}
