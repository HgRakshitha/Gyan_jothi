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

/// Shared True/False layout for alphabet quiz rounds (e.g. fish, sun).
class AlphabetQuizTrueFalseRoundPage extends StatefulWidget {
  final int questionNumber;
  final String imageAssetPath;
  final double imageWidth;
  final double imageHeight;
  final Widget fallback;
  final String statement;
  final bool statementBlueUnderline;

  /// When set, Submit pushes this route; otherwise Submit pops the quiz.
  final String? submitNextRoute;

  /// Tighter glow frame (e.g. fish) so True/False options fit better.
  final bool compactIllustration;

  /// 0 = True, 1 = False.
  final int correctAnswerIndex;
  
  final int coinsReward;

  const AlphabetQuizTrueFalseRoundPage({
    super.key,
    required this.questionNumber,
    required this.imageAssetPath,
    required this.imageWidth,
    required this.imageHeight,
    required this.fallback,
    required this.statement,
    this.statementBlueUnderline = false,
    this.submitNextRoute,
    this.compactIllustration = false,
    required this.correctAnswerIndex,
    this.coinsReward = 50,
  });

  @override
  State<AlphabetQuizTrueFalseRoundPage> createState() =>
      _AlphabetQuizTrueFalseRoundPageState();
}

class _AlphabetQuizTrueFalseRoundPageState
    extends State<AlphabetQuizTrueFalseRoundPage> {
  static const _totalQuestions = 8;

  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    final padH = Breakpoints.horizontalPadding(context);
    final padB = Breakpoints.scrollBottomPadding(context);
    const progressInset = 22.0;

    final baseStyle = AppTextStyles.headlineMedium.copyWith(
      fontSize: 17,
      fontWeight: FontWeight.w800,
      height: 1.35,
    );

    final statementStyle = widget.statementBlueUnderline
        ? baseStyle.copyWith(
            decoration: TextDecoration.underline,
            decorationColor: const Color(0xFF42A5F5),
            decorationThickness: 2.5,
          )
        : baseStyle;

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
                                compact: widget.compactIllustration,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              widget.statement,
                              textAlign: TextAlign.center,
                              style: statementStyle.copyWith(fontSize: 16),
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
                    question: '${widget.statement} (True / False)',
                    userAnswer: _selectedIndex == 0 ? 'True' : 'False',
                    correctAnswer: widget.correctAnswerIndex == 0 ? 'True' : 'False',
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
                      coinsReward: widget.coinsReward,
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
