import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/utils/breakpoints.dart';
import '../../../shared/widgets/quiz_header.dart';
import '../data/color_quiz_layout.dart';
import '../data/color_quiz_questions.dart';
import '../go_to_quiz_hub.dart';
import '../go_to_quiz_result.dart';
import '../quiz_answer_tracker.dart';
import '../quiz_feedback.dart';
import '../widgets/alphabet_quiz_fill_blank_widgets.dart';

/// Color Quiz — fill-in-the-blank questions (`/quiz/colors/:n`).
class ColorQuizQuestionPage extends StatefulWidget {
  final int questionNumber;

  const ColorQuizQuestionPage({
    super.key,
    required this.questionNumber,
  });

  @override
  State<ColorQuizQuestionPage> createState() => _ColorQuizQuestionPageState();
}

class _ColorQuizQuestionPageState extends State<ColorQuizQuestionPage> {
  static const _totalQuestions = 11;
  static const _progressInset = 22.0;

  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    if (widget.questionNumber == 1) {
      QuizAnswerTracker.reset();
    }
  }

  ColorQuizQuestionData get _data {
    final i = colorQuizFillInIndex(widget.questionNumber);
    return kColorQuizQuestions[i];
  }

  void _submit() {
    final data = _data;
    if (_selectedIndex == null) {
      showQuizSelectAnswer(context);
      return;
    }
    final isCorrect = _selectedIndex == data.correctOptionIndex;
    final userAnswer = (_selectedIndex != null && _selectedIndex! < data.options.length)
        ? data.options[_selectedIndex!]
        : '';
    final correctAnswer = data.correctOptionIndex < data.options.length
        ? data.options[data.correctOptionIndex]
        : '';
    QuizAnswerTracker.record(
      question: data.prompt,
      userAnswer: userAnswer,
      correctAnswer: correctAnswer,
      isCorrect: isCorrect,
    );
    if (widget.questionNumber < _totalQuestions) {
      context.push(
        AppRoutes.quizColorQuestion(widget.questionNumber + 1),
      );
    } else {
      goToQuizResult(
        context,
        quizTitle: 'Color Quiz',
        totalQuestions: _totalQuestions,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final padH = Breakpoints.horizontalPadding(context);
    final padB = Breakpoints.scrollBottomPadding(context);
    final data = _data;

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
                padH + _progressInset,
                6,
                padH + _progressInset,
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
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  padH,
                  ColorQuizLayout.scrollContentTopPadding,
                  padH,
                  20,
                ),
                child: Container(
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
                          assetPath: data.imageAssetPath,
                          width: data.imageWidth,
                          height: data.imageHeight,
                          fallback: data.fallback,
                        ),
                      ),
                      const SizedBox(height: ColorQuizLayout.imageToPromptGap),
                      Text(
                        data.prompt,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.headlineMedium.copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: ColorQuizLayout.promptToOptionsGap),
                      AlphabetQuizOptionGrid(
                        labels: data.options,
                        selectedIndex: _selectedIndex,
                        onSelect: (i) => setState(() => _selectedIndex = i),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(padH, 0, padH, 8 + padB),
              child: widget.questionNumber == 1
                  ? AlphabetQuizSubmitButton(onPressed: _submit)
                  : AlphabetQuizBackSubmitBar(
                      onBack: () => context.pop(),
                      onSubmit: _submit,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
