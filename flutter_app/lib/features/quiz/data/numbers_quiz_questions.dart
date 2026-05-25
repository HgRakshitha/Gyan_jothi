import '../../../core/constants/app_assets.dart';

/// One step in the Numbers Quiz (9 screens).
enum NumbersQuizKind { fillIn, trueFalse }

class NumbersQuizStep {
  final NumbersQuizKind kind;
  final String progressLabel;
  /// Shown inside typographic quotes in the UI.
  final String prompt;
  /// Four options for [fillIn]; ignored for [trueFalse].
  final List<String>? options;
  /// Question 1 uses Submit only; later questions use Back + Submit.
  final bool showBackWithSubmit;
  /// Defaults to [AppAssets.quizNum] when null.
  final String? imageAssetPath;
  final double? imageWidth;
  final double? imageHeight;
  final bool? showImageGroundGlow;
  /// When set, overrides default prompt text size on fill-in screens.
  final double? promptFontSize;
  /// Fill-in: index into [options]. True/False: 0 = True, 1 = False.
  final int correctIndex;

  const NumbersQuizStep({
    required this.kind,
    required this.progressLabel,
    required this.prompt,
    this.options,
    required this.showBackWithSubmit,
    required this.correctIndex,
    this.imageAssetPath,
    this.imageWidth,
    this.imageHeight,
    this.showImageGroundGlow,
    this.promptFontSize,
  });
}

const int kNumbersQuizTotal = 9;

final List<NumbersQuizStep> kNumbersQuizSteps = [
  const NumbersQuizStep(
    kind: NumbersQuizKind.fillIn,
    progressLabel: 'Fill in the Blank',
    prompt: '2, 4, 6, _',
    options: ['7', '8', '9', '5'],
    showBackWithSubmit: false,
    correctIndex: 1,
  ),
  const NumbersQuizStep(
    kind: NumbersQuizKind.fillIn,
    progressLabel: 'Fill in the Blank',
    prompt: '10, 9, _, 7',
    options: ['6', '8', '4', '5'],
    showBackWithSubmit: true,
    correctIndex: 1,
  ),
  const NumbersQuizStep(
    kind: NumbersQuizKind.fillIn,
    progressLabel: 'Fill in the Blank',
    prompt: '_ comes before 15',
    options: ['13', '14', '16', '15'],
    showBackWithSubmit: true,
    correctIndex: 1,
  ),
  const NumbersQuizStep(
    kind: NumbersQuizKind.trueFalse,
    progressLabel: 'True or False',
    prompt: '12 is greater than 9.',
    showBackWithSubmit: true,
    correctIndex: 0,
  ),
  const NumbersQuizStep(
    kind: NumbersQuizKind.trueFalse,
    progressLabel: 'True or False',
    prompt: '5 + 2 equals 10.',
    showBackWithSubmit: true,
    correctIndex: 1,
  ),
  const NumbersQuizStep(
    kind: NumbersQuizKind.trueFalse,
    progressLabel: 'True or False',
    prompt: '20 is an even number.',
    showBackWithSubmit: true,
    correctIndex: 0,
  ),
  const NumbersQuizStep(
    kind: NumbersQuizKind.fillIn,
    progressLabel: 'Compare Numbers',
    prompt: 'Which number is between 6 and 8?',
    options: ['10', '9', '5', '7'],
    showBackWithSubmit: true,
    correctIndex: 3,
  ),
  const NumbersQuizStep(
    kind: NumbersQuizKind.fillIn,
    progressLabel: 'Find the Pattern',
    prompt: '3, 6, 9, _',
    options: ['10', '12', '11', '8'],
    showBackWithSubmit: true,
    correctIndex: 1,
  ),
  const NumbersQuizStep(
    kind: NumbersQuizKind.fillIn,
    progressLabel: 'Word Problem',
    prompt:
        'Riya has 3 balloons. She gets 2 more. How many balloons does she have now?',
    options: ['5', '4', '6', '3'],
    showBackWithSubmit: true,
    correctIndex: 0,
    imageAssetPath: AppAssets.quizBallon,
    imageWidth: 176,
    imageHeight: 196,
    promptFontSize: 14,
  ),
];

NumbersQuizStep numbersQuizStepFor(int questionNumber) {
  assert(questionNumber >= 1 && questionNumber <= kNumbersQuizTotal);
  return kNumbersQuizSteps[questionNumber - 1];
}
