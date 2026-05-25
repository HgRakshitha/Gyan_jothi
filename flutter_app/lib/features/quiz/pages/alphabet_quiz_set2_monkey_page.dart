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

class AlphabetQuizSet2MonkeyPage extends StatefulWidget {
  const AlphabetQuizSet2MonkeyPage({super.key});

  @override
  State<AlphabetQuizSet2MonkeyPage> createState() => _AlphabetQuizSet2MonkeyPageState();
}

class _AlphabetQuizSet2MonkeyPageState extends State<AlphabetQuizSet2MonkeyPage> {
  static const _totalQuestions = 8;
  static const _options = ['h', 'd', 'f', 'b'];
  static const _correctIndex = 2;

  int? _selectedIndex;

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
                    'Find the Letter',
                    style: AppTextStyles.titleMedium.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    '2/$_totalQuestions',
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
                        assetPath: 'assets/icons/quiz/set1/monkey.png',
                        width: 184,
                        height: 176,
                        fallback: Icon(
                          Icons.cruelty_free_rounded,
                          size: 120,
                          color: Color(0xFF8D6E63),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Can you help the monkey find the letter \'f\'?',
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
              child: AlphabetQuizBackSubmitBar(
                onBack: () => context.pop(),
                onSubmit: () {
                  if (_selectedIndex == null) {
                    showQuizSelectAnswer(context);
                    return;
                  }
                  QuizAnswerTracker.record(
                    question: 'Find the letter f',
                    userAnswer: _selectedIndex != null ? _options[_selectedIndex!] : '',
                    correctAnswer: _options[_correctIndex],
                    isCorrect: _selectedIndex == _correctIndex,
                  );
                  context.push(AppRoutes.quizAlphabetSet2_3);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
