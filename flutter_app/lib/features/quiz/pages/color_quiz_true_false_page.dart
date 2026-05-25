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

/// Color Quiz — True or False (grass Q2, banana Q7, coal Q10).
class ColorQuizTrueFalsePage extends StatefulWidget {
  final int questionNumber;
  final String imageAssetPath;
  final double imageWidth;
  final double imageHeight;
  final Widget fallback;
  /// Sentence body only (quotes added in UI).
  final String statement;
  final int nextQuestionNumber;
  /// 0 = True, 1 = False.
  final int correctAnswerIndex;

  const ColorQuizTrueFalsePage._({
    required this.questionNumber,
    required this.imageAssetPath,
    required this.imageWidth,
    required this.imageHeight,
    required this.fallback,
    required this.statement,
    required this.nextQuestionNumber,
    required this.correctAnswerIndex,
  });

  factory ColorQuizTrueFalsePage.grass() {
    return const ColorQuizTrueFalsePage._(
      questionNumber: 2,
      imageAssetPath: AppAssets.quizGrass,
      imageWidth: 236,
      imageHeight: 200,
      fallback: Icon(
        Icons.grass_rounded,
        size: 120,
        color: Color(0xFF43A047),
      ),
      statement: 'Grass is blue.',
      nextQuestionNumber: 3,
      correctAnswerIndex: 1,
    );
  }

  factory ColorQuizTrueFalsePage.banana() {
    return const ColorQuizTrueFalsePage._(
      questionNumber: 7,
      imageAssetPath: AppAssets.quizBanana,
      imageWidth: 236,
      imageHeight: 224,
      fallback: Icon(
        Icons.restaurant_rounded,
        size: 120,
        color: Color(0xFFFFEB3B),
      ),
      statement: 'Bananas are green.',
      nextQuestionNumber: 8,
      correctAnswerIndex: 1,
    );
  }

  factory ColorQuizTrueFalsePage.coal() {
    return const ColorQuizTrueFalsePage._(
      questionNumber: 10,
      imageAssetPath: AppAssets.quizCoal,
      imageWidth: 236,
      imageHeight: 212,
      fallback: Icon(
        Icons.circle_rounded,
        size: 120,
        color: Color(0xFF424242),
      ),
      statement: 'Coal is black.',
      nextQuestionNumber: 11,
      correctAnswerIndex: 0,
    );
  }

  @override
  State<ColorQuizTrueFalsePage> createState() =>
      _ColorQuizTrueFalsePageState();
}

class _ColorQuizTrueFalsePageState extends State<ColorQuizTrueFalsePage> {
  static const _totalQuestions = 11;

  /// 0 = True, 1 = False, null = none.
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    final padH = Breakpoints.horizontalPadding(context);
    final padB = Breakpoints.scrollBottomPadding(context);
    const progressInset = 22.0;

    return Scaffold(
      backgroundColor: Colors.white,
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
                6,
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
                    '${widget.questionNumber}/$_totalQuestions',
                    style: AppTextStyles.titleMedium.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(padH, 0, padH, 4),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      alignment: Alignment.topCenter,
                      clipBehavior: Clip.none,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: constraints.maxWidth, maxWidth: constraints.maxWidth,
                          
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Center(
                              child: AlphabetQuizIllustration(
                                assetPath: widget.imageAssetPath,
                                width: widget.imageWidth,
                                height: widget.imageHeight,
                                fallback: widget.fallback,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '“${widget.statement}”',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.headlineMedium.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                height: 1.3,
                                color: AppColors.textPrimary,
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
                    question: '“${widget.statement}” (True / False)',
                    userAnswer: _selectedIndex == 0 ? 'True' : 'False',
                    correctAnswer: widget.correctAnswerIndex == 0 ? 'True' : 'False',
                    isCorrect: _selectedIndex == widget.correctAnswerIndex,
                  );
                  context.push(
                    AppRoutes.quizColorQuestion(widget.nextQuestionNumber),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
