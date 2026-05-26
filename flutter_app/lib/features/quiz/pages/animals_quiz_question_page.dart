import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/utils/breakpoints.dart';
import '../../../shared/widgets/quiz_header.dart';
import '../data/animals_quiz_questions.dart';
import '../data/color_quiz_layout.dart';
import '../go_to_quiz_hub.dart';
import '../go_to_quiz_result.dart';
import '../quiz_answer_tracker.dart';
import '../quiz_feedback.dart';
import '../widgets/alphabet_quiz_fill_blank_widgets.dart';

/// Animals Quiz — `/quiz/animals/1` … `/quiz/animals/11`.
class AnimalsQuizQuestionPage extends StatefulWidget {
  final int questionNumber;
  final int coinsReward;

  const AnimalsQuizQuestionPage({
    super.key,
    required this.questionNumber,
    this.coinsReward = 50,
  });

  @override
  State<AnimalsQuizQuestionPage> createState() =>
      _AnimalsQuizQuestionPageState();
}

class _AnimalsQuizQuestionPageState extends State<AnimalsQuizQuestionPage> {
  static const _progressInset = 22.0;

  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    if (widget.questionNumber == 1) {
      QuizAnswerTracker.reset();
    }
  }

  @override
  void didUpdateWidget(covariant AnimalsQuizQuestionPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.questionNumber != widget.questionNumber) {
      _selectedIndex = null;
    }
  }

  AnimalsQuizStep get _step => animalsQuizStepFor(widget.questionNumber);

  void _goNext() {
    final step = _step;
    if (_selectedIndex == null) {
      showQuizSelectAnswer(context);
      return;
    }
    final isCorrect = _selectedIndex == step.correctIndex;
    String userAnswer = '';
    String correctAnswer = '';
    if (step.kind == AnimalsQuizQuestionKind.trueFalse) {
      userAnswer = _selectedIndex == 0 ? 'True' : 'False';
      correctAnswer = step.correctIndex == 0 ? 'True' : 'False';
    } else {
      userAnswer = (_selectedIndex != null && _selectedIndex! < step.options.length) 
          ? step.options[_selectedIndex!] 
          : '';
      correctAnswer = step.correctIndex < step.options.length 
          ? step.options[step.correctIndex] 
          : '';
    }
    QuizAnswerTracker.record(
      question: step.prompt,
      userAnswer: userAnswer,
      correctAnswer: correctAnswer,
      isCorrect: isCorrect,
    );
    if (widget.questionNumber < kAnimalsQuizTotal) {
      context.push(AppRoutes.quizAnimalsQuestion(widget.questionNumber + 1));
    } else {
      goToQuizResult(
        context,
        quizTitle: 'Animals Quiz',
        totalQuestions: kAnimalsQuizTotal,
        coinsReward: widget.coinsReward,
      );
    }
  }

  void _goPrevious() {
    if (widget.questionNumber > 1) {
      if (context.canPop()) {
        context.pop();
      } else {
        context.go(AppRoutes.quizAnimalsQuestion(widget.questionNumber - 1));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final padH = Breakpoints.horizontalPadding(context);
    final padB = Breakpoints.scrollBottomPadding(context);
    final step = _step;

    final answers = step.kind == AnimalsQuizQuestionKind.trueFalse
        ? AlphabetQuizTrueFalseStack(
            selectedIndex: _selectedIndex,
            onSelect: (i) => setState(() => _selectedIndex = i),
          )
        : AlphabetQuizOptionGrid(
            labels: step.options,
            selectedIndex: _selectedIndex,
            onSelect: (i) => setState(() => _selectedIndex = i),
          );

    final card = Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        ColorQuizLayout.cardHorizontalPadding,
        ColorQuizLayout.cardTopPadding,
        ColorQuizLayout.cardHorizontalPadding,
        ColorQuizLayout.cardBottomPadding,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: AlphabetQuizIllustration(
              assetPath: step.imageAssetPath,
              width: step.imageWidth,
              height: step.imageHeight,
              showGroundGlow: true,
              fallback: const Icon(
                Icons.pets_rounded,
                size: 120,
                color: Color(0xFF8D6E63),
              ),
            ),
          ),
          const SizedBox(height: ColorQuizLayout.imageToPromptGap),
          Text(
            '“${step.prompt}”',
            textAlign: TextAlign.center,
            style: AppTextStyles.headlineMedium.copyWith(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              height: 1.35,
            ),
          ),
          const SizedBox(height: ColorQuizLayout.promptToOptionsGap),
          answers,
        ],
      ),
    );

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
              gradientColors: step.headerGradientColors,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                padH + _progressInset,
                6,
                padH + _progressInset,
                0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      step.progressLabel,
                      style: AppTextStyles.titleMedium.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  Text(
                    '${widget.questionNumber}/$kAnimalsQuizTotal',
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
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  padH,
                  ColorQuizLayout.scrollContentTopPadding,
                  padH,
                  20,
                ),
                child: card,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(padH, 0, padH, 8 + padB),
              child: step.showBackWithSubmit
                  ? AlphabetQuizBackSubmitBar(
                      onBack: _goPrevious,
                      onSubmit: _goNext,
                    )
                  : AlphabetQuizSubmitButton(onPressed: _goNext),
            ),
          ],
        ),
      ),
    );
  }
}
