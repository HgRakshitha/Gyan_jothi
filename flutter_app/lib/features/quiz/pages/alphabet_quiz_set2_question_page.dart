import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/utils/breakpoints.dart';
import '../../../shared/widgets/quiz_header.dart';
import '../go_to_quiz_hub.dart';
import '../quiz_answer_tracker.dart';
import '../quiz_feedback.dart';
import '../widgets/alphabet_quiz_fill_blank_widgets.dart';

/// First screen of the English Alphabet Quiz Set 2 (fill-in-the-blank style).
class AlphabetQuizSet2QuestionPage extends StatefulWidget {
  const AlphabetQuizSet2QuestionPage({super.key});

  @override
  State<AlphabetQuizSet2QuestionPage> createState() =>
      _AlphabetQuizSet2QuestionPageState();
}

class _AlphabetQuizSet2QuestionPageState
    extends State<AlphabetQuizSet2QuestionPage> {
  static const _totalQuestions = 8;
  static const _options = ['Who', 'What', 'Where', 'When'];
  static const _correctIndex = 0;

  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    QuizAnswerTracker.reset();
  }

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
                    'Fill in the Blank',
                    style: AppTextStyles.titleMedium.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    '1/$_totalQuestions',
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
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(padH, 0, padH, 8),
                child: Column(
                  children: [
                    const SizedBox(height: 2),
                    const Center(
                      child: AlphabetQuizIllustration(
                        assetPath: 'assets/icons/quiz/set1/king.webp',
                        width: 182,
                        height: 152,
                        fallback: Icon(
                          Icons.pets_rounded,
                          size: 120,
                          color: Color(0xFFF9A825),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      '____ is the king of the jungle?',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.headlineMedium.copyWith(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 20),
                    AlphabetQuizOptionGrid(
                      labels: _options,
                      selectedIndex: _selectedIndex,
                      onSelect: (i) => setState(() => _selectedIndex = i),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(padH, 0, padH, 8 + padB),
              child: AlphabetQuizSubmitButton(
                onPressed: () {
                  if (_selectedIndex == null) {
                    showQuizSelectAnswer(context);
                    return;
                  }
                  QuizAnswerTracker.record(
                    question: '____ is the king of the jungle? (Who)',
                    userAnswer: _selectedIndex != null ? _options[_selectedIndex!] : '',
                    correctAnswer: _options[_correctIndex],
                    isCorrect: _selectedIndex == _correctIndex,
                  );
                  context.push(AppRoutes.quizAlphabetSet2_2);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
