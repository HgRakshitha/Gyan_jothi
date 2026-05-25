import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/utils/breakpoints.dart';
import '../../../shared/widgets/quiz_header.dart';
import '../go_to_quiz_hub.dart';
import '../quiz_answer_tracker.dart';
import '../quiz_feedback.dart';
import '../widgets/alphabet_quiz_fill_blank_widgets.dart';

/// First screen of the English Alphabet Quiz (fill-in-the-blank style).
class AlphabetQuizQuestionPage extends StatefulWidget {
  const AlphabetQuizQuestionPage({super.key});

  @override
  State<AlphabetQuizQuestionPage> createState() =>
      _AlphabetQuizQuestionPageState();
}

class _AlphabetQuizQuestionPageState extends State<AlphabetQuizQuestionPage> {
  static const _totalQuestions = 8;
  static const _options = ['What', 'Which', 'How', 'Where'];
  static const _correctIndex = 2;

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
    // Pull “Fill in…” and “1/8” toward center / nearer the illustration.
    const progressInset = 22.0;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            QuizHeader(
              title: 'Quiz',
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
                        assetPath: AppAssets.quizVan,
                        width: 182,
                        height: 152,
                        fallback: Icon(
                          Icons.directions_bus_filled_rounded,
                          size: 120,
                          color: Color(0xFFE9C400),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      '____ do you get to school?',
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
                    question: '____ do you get to school? (How)',
                    userAnswer: _selectedIndex != null ? _options[_selectedIndex!] : '',
                    correctAnswer: _options[_correctIndex],
                    isCorrect: _selectedIndex == _correctIndex,
                  );
                  context.push(AppRoutes.quizAlphabet2);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
