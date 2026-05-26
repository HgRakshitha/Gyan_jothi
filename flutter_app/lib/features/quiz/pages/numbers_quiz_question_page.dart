import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/utils/breakpoints.dart';
import '../../../shared/widgets/quiz_header.dart';
import '../data/color_quiz_layout.dart';
import '../data/numbers_quiz_questions.dart';
import '../go_to_quiz_hub.dart';
import '../go_to_quiz_result.dart';
import '../quiz_answer_tracker.dart';
import '../quiz_feedback.dart';
import '../widgets/alphabet_quiz_fill_blank_widgets.dart';

/// Numbers Quiz — `/quiz/numbers/1` … `/quiz/numbers/9`.
class NumbersQuizQuestionPage extends StatefulWidget {
  final int questionNumber;
  final int coinsReward;

  const NumbersQuizQuestionPage({
    super.key,
    required this.questionNumber,
    this.coinsReward = 50,
  });

  @override
  State<NumbersQuizQuestionPage> createState() =>
      _NumbersQuizQuestionPageState();
}

class _NumbersQuizQuestionPageState extends State<NumbersQuizQuestionPage> {
  static const _progressInset = 22.0;
  static const _defaultImageW = 260.0;
  static const _defaultImageH = 220.0;

  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    if (widget.questionNumber == 1) {
      QuizAnswerTracker.reset();
    }
  }

  NumbersQuizStep get _step => numbersQuizStepFor(widget.questionNumber);

  void _goNext() {
    final step = _step;
    if (_selectedIndex == null) {
      showQuizSelectAnswer(context);
      return;
    }
    final isCorrect = _selectedIndex == step.correctIndex;
    String userAnswer = '';
    String correctAnswer = '';
    if (step.kind == NumbersQuizKind.trueFalse) {
      userAnswer = _selectedIndex == 0 ? 'True' : 'False';
      correctAnswer = step.correctIndex == 0 ? 'True' : 'False';
    } else {
      final opts = step.options ?? [];
      userAnswer = (_selectedIndex != null && _selectedIndex! < opts.length)
          ? opts[_selectedIndex!]
          : '';
      correctAnswer = step.correctIndex < opts.length
          ? opts[step.correctIndex]
          : '';
    }
    QuizAnswerTracker.record(
      question: step.prompt,
      userAnswer: userAnswer,
      correctAnswer: correctAnswer,
      isCorrect: isCorrect,
    );
    if (widget.questionNumber < kNumbersQuizTotal) {
      context.push(
        AppRoutes.quizNumbersQuestion(widget.questionNumber + 1),
      );
    } else {
      goToQuizResult(
        context,
        quizTitle: 'Numbers Quiz',
        totalQuestions: kNumbersQuizTotal,
        coinsReward: widget.coinsReward,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_step.kind == NumbersQuizKind.fillIn) {
      return _buildFillIn(context);
    }
    return _buildTrueFalse(context);
  }

  Widget _buildFillIn(BuildContext context) {
    final padH = Breakpoints.horizontalPadding(context);
    final padB = Breakpoints.scrollBottomPadding(context);
    final step = _step;
    final options = step.options!;
    final assetPath = step.imageAssetPath ?? AppAssets.quizNum;
    final imgW = step.imageWidth ?? _defaultImageW;
    final imgH = step.imageHeight ?? _defaultImageH;
    final groundGlow = step.showImageGroundGlow ?? true;
    final promptSize = step.promptFontSize ?? 17.0;
    final isWordProblem = step.imageAssetPath == AppAssets.quizBallon;

    final cardTop = isWordProblem ? 0.0 : ColorQuizLayout.cardTopPadding;
    final cardBottom = isWordProblem ? 8.0 : ColorQuizLayout.cardBottomPadding;
    final gapImgPrompt =
        isWordProblem ? 4.0 : ColorQuizLayout.imageToPromptGap;
    final gapPromptOpts =
        isWordProblem ? 10.0 : ColorQuizLayout.promptToOptionsGap;

    final card = Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        ColorQuizLayout.cardHorizontalPadding,
        cardTop,
        ColorQuizLayout.cardHorizontalPadding,
        cardBottom,
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
              assetPath: assetPath,
              width: imgW,
              height: imgH,
              compact: isWordProblem,
              showGroundGlow: groundGlow,
              fallback: assetPath == AppAssets.quizBallon
                  ? const Icon(
                      Icons.circle_rounded,
                      size: 120,
                      color: Color(0xFFE53935),
                    )
                  : const Icon(
                      Icons.calculate_rounded,
                      size: 120,
                      color: Color(0xFF5C6BC0),
                    ),
            ),
          ),
          SizedBox(height: gapImgPrompt),
          Text(
            '“${step.prompt}”',
            textAlign: TextAlign.center,
            style: AppTextStyles.headlineMedium.copyWith(
              fontSize: promptSize,
              fontWeight: FontWeight.w800,
              height: isWordProblem ? 1.28 : 1.35,
            ),
          ),
          SizedBox(height: gapPromptOpts),
          isWordProblem
              ? FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.center,
                  child: AlphabetQuizOptionGrid(
                    labels: options,
                    selectedIndex: _selectedIndex,
                    onSelect: (i) => setState(() => _selectedIndex = i),
                  ),
                )
              : AlphabetQuizOptionGrid(
                  labels: options,
                  selectedIndex: _selectedIndex,
                  onSelect: (i) => setState(() => _selectedIndex = i),
                ),
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
                    '${widget.questionNumber}/$kNumbersQuizTotal',
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
              child: isWordProblem
                  ? Padding(
                      padding: EdgeInsets.fromLTRB(padH, 0, padH, 0),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.topCenter,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: constraints.maxWidth, maxWidth: constraints.maxWidth,
                                
                              ),
                              child: card,
                            ),
                          );
                        },
                      ),
                    )
                  : SingleChildScrollView(
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
              padding: EdgeInsets.fromLTRB(
                padH,
                0,
                padH,
                (isWordProblem ? 4 : 8) + padB,
              ),
              child: step.showBackWithSubmit
                  ? AlphabetQuizBackSubmitBar(
                      onBack: () => context.pop(),
                      onSubmit: _goNext,
                    )
                  : AlphabetQuizSubmitButton(onPressed: _goNext),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrueFalse(BuildContext context) {
    final padH = Breakpoints.horizontalPadding(context);
    final padB = Breakpoints.scrollBottomPadding(context);
    final step = _step;
    final assetPath = step.imageAssetPath ?? AppAssets.quizNum;
    final imgW = step.imageWidth ?? _defaultImageW;
    final imgH = step.imageHeight ?? _defaultImageH;
    final groundGlow = step.showImageGroundGlow ?? true;

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
                padH + _progressInset,
                6,
                padH + _progressInset,
                0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    step.progressLabel,
                    style: AppTextStyles.titleMedium.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    '${widget.questionNumber}/$kNumbersQuizTotal',
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
                                assetPath: assetPath,
                                width: imgW,
                                height: imgH,
                                showGroundGlow: groundGlow,
                                fallback: const Icon(
                                  Icons.calculate_rounded,
                                  size: 120,
                                  color: Color(0xFF5C6BC0),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '“${step.prompt}”',
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
                onSubmit: _goNext,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
