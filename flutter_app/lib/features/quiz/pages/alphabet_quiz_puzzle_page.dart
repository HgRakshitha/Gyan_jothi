import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/utils/breakpoints.dart';
import '../../../shared/widgets/quiz_header.dart';
import '../../../shared/widgets/crescent_border_card.dart';
import '../go_to_quiz_hub.dart';
import '../go_to_quiz_result.dart';
import '../quiz_answer_tracker.dart';
import '../quiz_feedback.dart';
import '../widgets/alphabet_quiz_fill_blank_widgets.dart';

/// Word tiles for puzzle rounds — between compact and full MCQ size.
abstract final class _PuzzleTileDim {
  static const w = 148.0;
  static const h = 94.0;
  static const gap = 10.0;
}

/// Drag-and-drop puzzle (“Puzzle” type) — bag, dog, apple rounds, etc.
class AlphabetQuizPuzzleRoundPage extends StatefulWidget {
  final int questionNumber;
  final String imageAssetPath;
  final double imageWidth;
  final double imageHeight;
  final Widget fallback;
  /// Four words in 2×2 grid order: top-left, top-right, bottom-left, bottom-right.
  final List<String> bankOrder;
  final String? submitNextRoute;
  final List<String> correctSlotOrder;
  final String instructionText;
  final int coinsReward;

  const AlphabetQuizPuzzleRoundPage({
    super.key,
    required this.questionNumber,
    required this.imageAssetPath,
    required this.imageWidth,
    required this.imageHeight,
    required this.fallback,
    required this.bankOrder,
    required this.correctSlotOrder,
    this.instructionText = 'Drag the words to make a correct sentence',
    this.submitNextRoute,
    this.coinsReward = 50,
  });

  @override
  State<AlphabetQuizPuzzleRoundPage> createState() =>
      _AlphabetQuizPuzzleRoundPageState();
}

class _AlphabetQuizPuzzleRoundPageState
    extends State<AlphabetQuizPuzzleRoundPage> {
  static const _totalQuestions = 8;

  final List<String?> _slots = [null, null, null, null];

  void _placeWord(String word, int slotIndex) {
    setState(() {
      for (var i = 0; i < 4; i++) {
        if (_slots[i] == word) {
          _slots[i] = null;
        }
      }
      _slots[slotIndex] = word;
    });
  }

  bool _wordPlaced(String w) => _slots.contains(w);

  void _submit() {
    if (_slots.any((s) => s == null)) {
      showQuizPuzzleIncomplete(context);
      return;
    }
    final filled = _slots.map((e) => e!).toList();
    final isCorrect = listEquals(filled, widget.correctSlotOrder);
    QuizAnswerTracker.record(
      question: 'Arrange words: ${widget.correctSlotOrder.join(" ")}',
      userAnswer: filled.join(' '),
      correctAnswer: widget.correctSlotOrder.join(' '),
      isCorrect: isCorrect,
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
  }

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
                10,
                padH + progressInset,
                0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Puzzle',
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
            const SizedBox(height: 6),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(padH, 0, padH, 0),
                child: Column(
                  children: [
                    Center(
                      child: AlphabetQuizIllustration(
                        assetPath: widget.imageAssetPath,
                        width: widget.imageWidth,
                        height: widget.imageHeight,
                        fallback: widget.fallback,
                        compact: true,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return FittedBox(
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
                                  Text(
                                    widget.instructionText,
                                    textAlign: TextAlign.center,
                                    style:
                                        AppTextStyles.headlineMedium.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      height: 1.3,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  _SentenceSlots(
                                    slots: _slots,
                                    onPlaceWord: _placeWord,
                                    onClearSlot: (i) =>
                                        setState(() => _slots[i] = null),
                                  ),
                                  const SizedBox(height: 22),
                                  _WordBankGrid(
                                    bankOrder: widget.bankOrder,
                                    wordPlaced: _wordPlaced,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(padH, 4, padH, 8 + padB),
              child: AlphabetQuizBackSubmitBar(
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

class _SentenceSlots extends StatelessWidget {
  final List<String?> slots;
  final void Function(String word, int slotIndex) onPlaceWord;
  final ValueChanged<int> onClearSlot;

  const _SentenceSlots({
    required this.slots,
    required this.onPlaceWord,
    required this.onClearSlot,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(4, (i) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: DragTarget<String>(
              onAcceptWithDetails: (details) =>
                  onPlaceWord(details.data, i),
              builder: (context, candidate, rejected) {
                final hasCandidate = candidate.isNotEmpty;
                return GestureDetector(
                  onTap: slots[i] != null ? () => onClearSlot(i) : null,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    height: 44,
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: hasCandidate
                              ? AppColors.primary
                              : AppColors.textPrimary,
                          width: hasCandidate ? 2.5 : 2,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: Text(
                        slots[i] ?? '',
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.titleMedium.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }
}

class _WordBankGrid extends StatelessWidget {
  final List<String> bankOrder;
  final bool Function(String word) wordPlaced;

  const _WordBankGrid({
    required this.bankOrder,
    required this.wordPlaced,
  });

  @override
  Widget build(BuildContext context) {
    const gap = _PuzzleTileDim.gap;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _bankCell(bankOrder[0]),
            const SizedBox(width: gap),
            _bankCell(bankOrder[1]),
          ],
        ),
        const SizedBox(height: gap),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _bankCell(bankOrder[2]),
            const SizedBox(width: gap),
            _bankCell(bankOrder[3]),
          ],
        ),
      ],
    );
  }

  Widget _bankCell(String word) {
    if (wordPlaced(word)) {
      return const SizedBox(
        width: _PuzzleTileDim.w,
        height: _PuzzleTileDim.h,
      );
    }

    return Draggable<String>(
      data: word,
      feedback: Material(
        color: Colors.transparent,
        child: _WordTilePreview(
          label: word,
          width: _PuzzleTileDim.w,
          height: _PuzzleTileDim.h,
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.35,
        child: AlphabetQuizOptionTile(
          label: word,
          selected: false,
          onTap: () {},
          width: _PuzzleTileDim.w,
          height: _PuzzleTileDim.h,
        ),
      ),
      child: AlphabetQuizOptionTile(
        label: word,
        selected: false,
        onTap: () {},
        width: _PuzzleTileDim.w,
        height: _PuzzleTileDim.h,
      ),
    );
  }
}

class _WordTilePreview extends StatelessWidget {
  final String label;
  final double width;
  final double height;

  const _WordTilePreview({
    required this.label,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final radius =
        width < 152 ? 26.0 : AlphabetQuizDim.optionRadius;
    final fontSize = height < 102 ? 14.0 : 16.0;
    return CrescentBorderCard(
      width: width,
      height: height,
      innerColor: const Color(0xFFFBFBE4),
      borderColor: const Color(0xFFE8E0C8),
      borderWidth: AlphabetQuizDim.optionSideBorder,
      borderRadius: radius,
      padding: EdgeInsets.zero,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.12),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
      child: Center(
        child: Text(
          label,
          style: AppTextStyles.titleMedium.copyWith(
            fontSize: fontSize,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
