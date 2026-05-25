import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/utils/breakpoints.dart';
import '../../../shared/widgets/quiz_header.dart';
import '../go_to_quiz_hub.dart';
import '../quiz_answer_tracker.dart';
import '../quiz_feedback.dart';
import '../widgets/alphabet_quiz_fill_blank_widgets.dart';

class AlphabetQuizSet2TrueFalsePage extends StatefulWidget {
  const AlphabetQuizSet2TrueFalsePage({super.key});

  @override
  State<AlphabetQuizSet2TrueFalsePage> createState() =>
      _AlphabetQuizSet2TrueFalsePageState();
}

class _AlphabetQuizSet2TrueFalsePageState
    extends State<AlphabetQuizSet2TrueFalsePage> {
  static const _totalQuestions = 8;

  /// 0 = True, 1 = False, null = none.
  int? _selectedIndex;
  static const _correctIndex = 0; // True

  @override
  Widget build(BuildContext context) {
    final padH = Breakpoints.horizontalPadding(context);
    final padB = Breakpoints.scrollBottomPadding(context);
    const progressInset = 22.0;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            QuizHeader(
              title: 'F to J Jungle',
              onBack: () => goToQuizHub(context),
              margin: const EdgeInsets.only(bottom: 8),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                padH + progressInset,
                8,
                padH + progressInset,
                0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'True or False',
                    style: AppTextStyles.titleMedium.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    '3/$_totalQuestions',
                    style: AppTextStyles.titleMedium.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(padH, 0, padH, 4),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      alignment: Alignment.topCenter,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: constraints.maxWidth,
                          maxWidth: constraints.maxWidth,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Center(
                              child: AlphabetQuizIllustration(
                                assetPath: 'assets/icons/quiz/set1/frog.png',
                                width: 214,
                                height: 168,
                                fallback: Icon(
                                  Icons.pest_control_rounded,
                                  size: 120,
                                  color: Color(0xFF43A047),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '“A frog can jump high.”',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.headlineMedium.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 14),
                            AlphabetQuizTrueFalseStack(
                              selectedIndex: _selectedIndex,
                              onSelect: (i) =>
                                  setState(() => _selectedIndex = i),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(padH, 0, padH, 8 + padB),
              child: AlphabetQuizBackSubmitBar(
                onBack: () => context.pop(),
                onSubmit: () {
                  if (_selectedIndex == null) {
                    showQuizSelectAnswer(context);
                    return;
                  }
                  QuizAnswerTracker.record(
                    question: '“A frog can jump high.” (True / False)',
                    userAnswer: _selectedIndex == 0 ? 'True' : 'False',
                    correctAnswer: 'True',
                    isCorrect: _selectedIndex == _correctIndex,
                  );
                  context.push(AppRoutes.quizAlphabetSet2_4);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
