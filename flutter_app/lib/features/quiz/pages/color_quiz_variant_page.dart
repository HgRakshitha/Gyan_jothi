import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/utils/breakpoints.dart';
import '../../../shared/widgets/quiz_header.dart';
import '../data/color_quiz_layout.dart';
import '../go_to_quiz_hub.dart';
import '../go_to_quiz_result.dart';
import '../quiz_answer_tracker.dart';
import '../quiz_feedback.dart';
import '../widgets/alphabet_quiz_fill_blank_widgets.dart';

/// Shared layout for Color Quiz steps with custom progress labels (Q3–Q5 mocks).
class ColorQuizVariantPage extends StatefulWidget {
  final int questionNumber;
  final String progressLabel;
  final String imageAssetPath;
  final double imageWidth;
  final double imageHeight;
  final Widget imageFallback;
  /// Shown with typographic quotes in the UI.
  final String prompt;
  final List<String> options;
  /// When false, the illustration is shown without the yellow ground glow (better for dark images).
  final bool showImageGroundGlow;
  /// Q1 uses Submit only elsewhere; variant screens use Back + Submit when true.
  final bool showBackWithSubmit;
  /// Index into [options] for the correct choice.
  final int correctOptionIndex;

  const ColorQuizVariantPage({
    super.key,
    required this.questionNumber,
    required this.progressLabel,
    required this.imageAssetPath,
    required this.imageWidth,
    required this.imageHeight,
    required this.imageFallback,
    required this.prompt,
    required this.options,
    required this.correctOptionIndex,
    this.showImageGroundGlow = true,
    this.showBackWithSubmit = true,
  });

  @override
  State<ColorQuizVariantPage> createState() => _ColorQuizVariantPageState();
}

class _ColorQuizVariantPageState extends State<ColorQuizVariantPage> {
  static const _totalQuestions = 11;
  static const _progressInset = 22.0;

  int? _selectedIndex;

  void _submit() {
    if (_selectedIndex == null) {
      showQuizSelectAnswer(context);
      return;
    }
    final isCorrect = _selectedIndex == widget.correctOptionIndex;
    final userAnswer = (_selectedIndex != null && _selectedIndex! < widget.options.length)
        ? widget.options[_selectedIndex!]
        : '';
    final correctAnswer = widget.correctOptionIndex < widget.options.length
        ? widget.options[widget.correctOptionIndex]
        : '';
    QuizAnswerTracker.record(
      question: widget.prompt,
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
                      widget.progressLabel,
                      style: AppTextStyles.titleMedium.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
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
                          assetPath: widget.imageAssetPath,
                          width: widget.imageWidth,
                          height: widget.imageHeight,
                          fallback: widget.imageFallback,
                          showGroundGlow: widget.showImageGroundGlow,
                        ),
                      ),
                      const SizedBox(height: ColorQuizLayout.imageToPromptGap),
                      Text(
                        '“${widget.prompt}”',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.headlineMedium.copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: ColorQuizLayout.promptToOptionsGap),
                      AlphabetQuizOptionGrid(
                        labels: widget.options,
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
              child: widget.showBackWithSubmit
                  ? AlphabetQuizBackSubmitBar(
                      onBack: () => context.pop(),
                      onSubmit: _submit,
                    )
                  : AlphabetQuizSubmitButton(onPressed: _submit),
            ),
          ],
        ),
      ),
    );
  }
}

/// Q3 — Identify the odd color (palette).
class ColorQuizOddColorPage extends StatelessWidget {
  const ColorQuizOddColorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColorQuizVariantPage(
      questionNumber: 3,
      progressLabel: 'Identify the Odd Color',
      imageAssetPath: AppAssets.quizColorPalette,
      imageWidth: 260,
      imageHeight: 235,
      imageFallback: Icon(
        Icons.palette_rounded,
        size: 120,
        color: Color(0xFF7E57C2),
      ),
      prompt: 'Which color does NOT belong?',
      options: ['Pink', 'Red', 'Blue', 'Banana'],
      correctOptionIndex: 3,
    );
  }
}

/// Q4 — Complete the sentence (night sky / stargazing).
class ColorQuizCompleteSentenceSkyPage extends StatelessWidget {
  const ColorQuizCompleteSentenceSkyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColorQuizVariantPage(
      questionNumber: 4,
      progressLabel: 'Complete the sentence',
      imageAssetPath: AppAssets.quizSky,
      imageWidth: 285,
      imageHeight: 285,
      imageFallback: Icon(
        Icons.nights_stay_rounded,
        size: 120,
        color: Color(0xFF1A237E),
      ),
      prompt: 'The sky is usually ___.',
      options: ['Pink', 'Red', 'Blue', 'Banana'],
      showImageGroundGlow: false,
      correctOptionIndex: 2,
    );
  }
}

/// Q5 — Match color to object (milk).
class ColorQuizMatchMilkPage extends StatelessWidget {
  const ColorQuizMatchMilkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColorQuizVariantPage(
      questionNumber: 5,
      progressLabel: 'Match the Color to Object',
      imageAssetPath: AppAssets.quizMilk,
      imageWidth: 215,
      imageHeight: 250,
      imageFallback: Icon(
        Icons.local_drink_rounded,
        size: 120,
        color: Color(0xFFEEEEEE),
      ),
      prompt: 'Milk is ___.',
      options: ['Black', 'White', 'Orange', 'Yellow'],
      correctOptionIndex: 1,
    );
  }
}

/// Q6 — Match different (apple slices).
class ColorQuizAppleMatchDifferentPage extends StatelessWidget {
  const ColorQuizAppleMatchDifferentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColorQuizVariantPage(
      questionNumber: 6,
      progressLabel: 'Match the Color to Object',
      imageAssetPath: AppAssets.quizAppleSlice,
      imageWidth: 236,
      imageHeight: 224,
      imageFallback: Icon(
        Icons.apple_rounded,
        size: 120,
        color: Color(0xFFE53935),
      ),
      prompt: 'Which one is different?',
      options: ['Pink', 'Apple', 'Orange', 'Yellow'],
      correctOptionIndex: 1,
    );
  }
}

/// Q8 — Fill in the blank (clouds).
class ColorQuizCloudsFillPage extends StatelessWidget {
  const ColorQuizCloudsFillPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColorQuizVariantPage(
      questionNumber: 8,
      progressLabel: 'Fill in the Blank',
      imageAssetPath: AppAssets.quizClouds,
      imageWidth: 236,
      imageHeight: 200,
      imageFallback: Icon(
        Icons.cloud_rounded,
        size: 120,
        color: Color(0xFFB0BEC5),
      ),
      prompt: 'The clouds are ___.',
      options: ['Pink', 'Blue', 'Orange', 'White'],
      correctOptionIndex: 3,
    );
  }
}

/// Q11 — Identify the odd option (wooden table).
class ColorQuizTableOddDifferentPage extends StatelessWidget {
  const ColorQuizTableOddDifferentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColorQuizVariantPage(
      questionNumber: 11,
      progressLabel: 'Identify the Odd Color',
      imageAssetPath: AppAssets.quizTable,
      imageWidth: 248,
      imageHeight: 200,
      imageFallback: Icon(
        Icons.table_restaurant_rounded,
        size: 120,
        color: Color(0xFF8D6E63),
      ),
      prompt: 'Which one is different?',
      options: ['Red', 'Blue', 'Green', 'Table'],
      correctOptionIndex: 3,
    );
  }
}
