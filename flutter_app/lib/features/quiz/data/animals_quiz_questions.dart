import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';

const int kAnimalsQuizTotal = 9;

enum AnimalsQuizQuestionKind {
  multipleChoice,
  trueFalse,
}

class AnimalsQuizStep {
  final String progressLabel;
  final String imageAssetPath;
  final String prompt;
  final List<String> options;
  final AnimalsQuizQuestionKind kind;
  final bool showBackWithSubmit;
  final List<Color>? headerGradientColors;
  final double imageWidth;
  final double imageHeight;
  /// Multiple choice: index into [options]. True/False: 0 = True, 1 = False.
  final int correctIndex;

  const AnimalsQuizStep({
    required this.progressLabel,
    required this.imageAssetPath,
    required this.prompt,
    this.options = const [],
    this.kind = AnimalsQuizQuestionKind.multipleChoice,
    this.showBackWithSubmit = true,
    this.headerGradientColors,
    this.imageWidth = 248,
    this.imageHeight = 228,
    required this.correctIndex,
  });
}

/// Questions 1–4: original Animals Quiz; 5–11: Movement / T–F / Odd one out / Water / Wild / Body / Special.
const List<AnimalsQuizStep> kAnimalsQuizSteps = [
  AnimalsQuizStep(
    progressLabel: 'Identify the Animal',
    imageAssetPath: AppAssets.quizElephant,
    prompt: 'What animal is this?',
    options: ['Tiger', 'Elephant', 'Cat', 'Dog'],
    showBackWithSubmit: false,
    correctIndex: 1,
  ),
  AnimalsQuizStep(
    progressLabel: 'Animal Home',
    imageAssetPath: AppAssets.quizLion,
    prompt: 'Where does a lion live?',
    options: ['Home', 'Water', 'Jungle', 'Tree'],
    correctIndex: 2,
  ),
  AnimalsQuizStep(
    progressLabel: 'What Do They Eat?',
    imageAssetPath: AppAssets.quizRabbit,
    prompt: 'What does a rabbit like to eat?',
    options: ['Fish', 'Meat', 'Carrot', 'Cake'],
    headerGradientColors: [
      Color(0xFFEFFF7A),
      Color(0xFFDFFF4F),
    ],
    correctIndex: 2,
  ),
  AnimalsQuizStep(
    progressLabel: 'Animal Babies',
    imageAssetPath: AppAssets.quizPuppy,
    prompt: 'What is a baby dog called?',
    options: ['Chick', 'Puppy', 'Calf', 'Kitten'],
    correctIndex: 1,
  ),
  AnimalsQuizStep(
    progressLabel: 'Movement Type',
    imageAssetPath: AppAssets.quizZoo,
    prompt: 'Which animal can jump?',
    options: ['Kangaroo', 'Elephant', 'Turtle', 'Cow'],
    imageWidth: 260,
    imageHeight: 200,
    correctIndex: 0,
  ),
  AnimalsQuizStep(
    progressLabel: 'True or False',
    imageAssetPath: AppAssets.quizAniFish,
    prompt: 'A fish can walk on land.',
    kind: AnimalsQuizQuestionKind.trueFalse,
    imageWidth: 240,
    imageHeight: 220,
    correctIndex: 1,
  ),
  AnimalsQuizStep(
    progressLabel: 'Odd One Out',
    imageAssetPath: AppAssets.quizZoo,
    prompt: 'Which one is different?',
    options: ['Dog', 'Cat', 'Car', 'Cow'],
    imageWidth: 260,
    imageHeight: 200,
    correctIndex: 2,
  ),
  AnimalsQuizStep(
    progressLabel: 'Water Animal',
    imageAssetPath: AppAssets.quizRever,
    prompt: 'Which animal lives in water?',
    options: ['Horse', 'Fish', 'Goat', 'Lion'],
    imageWidth: 260,
    imageHeight: 220,
    correctIndex: 1,
  ),
  AnimalsQuizStep(
    progressLabel: 'Wild or Domestic',
    imageAssetPath: AppAssets.quizZoo,
    prompt: 'Which one is a wild animal?',
    options: ['Cat', 'Dog', 'Goat', 'Tiger'],
    imageWidth: 260,
    imageHeight: 200,
    correctIndex: 3,
  ),
  AnimalsQuizStep(
    progressLabel: 'Body Feature Question',
    imageAssetPath: AppAssets.quizZoo,
    prompt: 'Which animal has a very long neck?',
    options: ['Cat', 'Dog', 'Giraffe', 'Bear'],
    imageWidth: 260,
    imageHeight: 200,
    correctIndex: 2,
  ),
  AnimalsQuizStep(
    progressLabel: 'Special Ability Question',
    imageAssetPath: AppAssets.quizZoo,
    prompt: 'Which animal cannot fly?',
    options: ['Parrot', 'Penguin', 'Sparrow', 'Cow'],
    imageWidth: 260,
    imageHeight: 200,
    correctIndex: 3,
  ),
];

AnimalsQuizStep animalsQuizStepFor(int questionNumber) {
  final i = questionNumber.clamp(1, kAnimalsQuizTotal) - 1;
  return kAnimalsQuizSteps[i];
}
