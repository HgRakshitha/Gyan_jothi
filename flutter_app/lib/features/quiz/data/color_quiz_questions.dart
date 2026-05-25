import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';

/// One fill-in-the-blank color question (image + prompt + four options).
class ColorQuizQuestionData {
  final String imageAssetPath;
  final double imageWidth;
  final double imageHeight;
  final Widget fallback;
  final String prompt;
  final List<String> options;
  /// Index into [options] for the correct choice.
  final int correctOptionIndex;

  const ColorQuizQuestionData({
    required this.imageAssetPath,
    required this.imageWidth,
    required this.imageHeight,
    required this.fallback,
    required this.prompt,
    required this.options,
    required this.correctOptionIndex,
  });
}

/// Fill-in questions: **Q1** (carrot) and **Q9** (strawberry). Q10–11 are T/F + odd-color screens.
final List<ColorQuizQuestionData> kColorQuizQuestions = [
  const ColorQuizQuestionData(
    imageAssetPath: AppAssets.quizCarrot,
    imageWidth: 236,
    imageHeight: 236,
    fallback: Icon(
      Icons.restaurant_rounded,
      size: 120,
      color: Color(0xFFFF6D00),
    ),
    prompt: 'The carrot is ___.',
    options: ['Pink', 'Red', 'Orange', 'White'],
    correctOptionIndex: 2,
  ),
  const ColorQuizQuestionData(
    imageAssetPath: AppAssets.quizStrawberry,
    imageWidth: 236,
    imageHeight: 224,
    fallback: Icon(
      Icons.restaurant_rounded,
      size: 120,
      color: Color(0xFFE53935),
    ),
    prompt: 'The strawberry is ___.',
    options: ['Red', 'Blue', 'Black', 'Yellow'],
    correctOptionIndex: 0,
  ),
];

/// Maps fill-in steps: **Q1** and **Q9** only.
int colorQuizFillInIndex(int questionNumber) {
  assert(questionNumber == 1 || questionNumber == 9);
  if (questionNumber == 1) return 0;
  return 1;
}
