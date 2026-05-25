import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/utils/breakpoints.dart';
import '../../../shared/widgets/quiz_header.dart';
import '../go_to_quiz_hub.dart';
import '../go_to_quiz_result.dart';
import '../quiz_answer_tracker.dart';
import '../quiz_feedback.dart';
import '../widgets/alphabet_quiz_fill_blank_widgets.dart';

/// Shared Multiple Choice layout for alphabet quiz rounds.
class AlphabetQuizMultipleChoiceRoundPage extends StatefulWidget {
  final int questionNumber;
  final String questionText;
  final String imageAssetPath;
  final double imageWidth;
  final double imageHeight;
  final Widget fallback;
  
  /// Exactly 4 string options
  final List<String> options;
  
  /// Index (0 to 3) of the correct option
  final int correctAnswerIndex;
  
  /// When set, Submit pushes this route; otherwise Submit pops the quiz.
  final String? submitNextRoute;

  const AlphabetQuizMultipleChoiceRoundPage({
    super.key,
    required this.questionNumber,
    required this.questionText,
    required this.imageAssetPath,
    required this.imageWidth,
    required this.imageHeight,
    required this.fallback,
    required this.options,
    required this.correctAnswerIndex,
    this.submitNextRoute,
  });

  @override
  State<AlphabetQuizMultipleChoiceRoundPage> createState() =>
      _AlphabetQuizMultipleChoiceRoundPageState();
}

class _AlphabetQuizMultipleChoiceRoundPageState
    extends State<AlphabetQuizMultipleChoiceRoundPage> {
  static const _totalQuestions = 8;
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
                    'Multiple Choice',
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
            const SizedBox(height: 4),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(padH, 0, padH, 8),
                child: Column(
                  children: [
                    const SizedBox(height: 2),
                    Center(
                      child: AlphabetQuizIllustration(
                        assetPath: widget.imageAssetPath,
                        width: widget.imageWidth,
                        height: widget.imageHeight,
                        fallback: widget.fallback,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      widget.questionText,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.headlineMedium.copyWith(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 20),
                    AlphabetQuizOptionGrid(
                      labels: widget.options,
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
                    question: widget.questionText,
                    userAnswer: widget.options[_selectedIndex!],
                    correctAnswer: widget.options[widget.correctAnswerIndex],
                    isCorrect: _selectedIndex == widget.correctAnswerIndex,
                  );
                  final next = widget.submitNextRoute;
                  if (next != null) {
                    context.push(next);
                  } else {
                    goToQuizResult(
                      context,
                      quizTitle: 'Alphabet Quiz',
                      totalQuestions: _totalQuestions,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
