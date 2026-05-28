import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../shared/providers/user_provider.dart';
import '../../../../shared/widgets/custom_button.dart';

class StickerSpellPage extends ConsumerStatefulWidget {
  const StickerSpellPage({super.key});

  @override
  ConsumerState<StickerSpellPage> createState() => _StickerSpellPageState();
}

class _StickerSpellPageState extends ConsumerState<StickerSpellPage> {
  final List<String> _words = [
    'ANT', 'BAT', 'BED', 'BIRD',
    'BOAT', 'BOOK', 'BUG', 'CAKE', 'COIN',
    'CORN', 'CRAB', 'DRUM', 'DUCK', 'FROG',
    'GOAT', 'HOUSE', 'LEAF', 'MILK', 'MOON',
    'PEAR', 'PIG', 'RING', 'ROSE', 'TREE'
  ];
  int _currentWordIndex = 0;
  
  List<String> _shuffledLetters = [];
  List<String?> _placedLetters = [];
  bool _isCompleted = false;

  @override
  void initState() {
    super.initState();
    _loadWord();
  }

  void _loadWord() {
    final word = _words[_currentWordIndex];
    _placedLetters = List.filled(word.length, null);
    
    // Shuffle letters
    _shuffledLetters = word.split('').toList();
    _shuffledLetters.shuffle(Random());
    
    _isCompleted = false;
  }

  void _nextWord() {
    if (_currentWordIndex < _words.length - 1) {
      setState(() {
        _currentWordIndex++;
        _loadWord();
      });
    } else {
      _finishActivity();
    }
  }

  void _finishActivity() {
    final success = ref.read(userProvider.notifier).completeActivity('learn_Word Book', 20);
    if (success) {
      context.pushReplacement(AppRoutes.taskCompletion, extra: 20);
    } else {
      context.pop();
    }
  }

  void _checkCompletion() {
    final word = _words[_currentWordIndex];
    final currentSpelling = _placedLetters.join('');
    if (currentSpelling == word) {
      setState(() {
        _isCompleted = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final word = _words[_currentWordIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Sticker & Spell',
          style: AppTextStyles.headlineMedium,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black87),
          onPressed: () => context.pop(),
        ),
        actions: [
          TextButton(
            onPressed: _finishActivity,
            child: Text(
              'Done',
              style: AppTextStyles.titleMedium.copyWith(color: AppColors.primary),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              "Let's spell the word together!",
              style: AppTextStyles.titleMedium,
            ),
            const Spacer(),
            
            // Image / Silhouette Area
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: _isCompleted
                  ? _buildUnlockedSticker(word)
                  : _buildSilhouette(word),
            ),
            
            const SizedBox(height: 40),
            
            // Letter Slots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(word.length, (index) {
                return DragTarget<String>(
                  onWillAcceptWithDetails: (details) => 
                      details.data == word[index] && _placedLetters[index] == null && !_isCompleted,
                  onAcceptWithDetails: (details) {
                    setState(() {
                      _placedLetters[index] = details.data;
                      _shuffledLetters.remove(details.data);
                    });
                    _checkCompletion();
                  },
                  builder: (context, candidateData, rejectedData) {
                    return Container(
                      width: 60,
                      height: 60,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: candidateData.isNotEmpty ? AppColors.primary.withValues(alpha: 0.2) : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _placedLetters[index] != null 
                              ? AppColors.primary 
                              : Colors.grey.withValues(alpha: 0.5),
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          _placedLetters[index] ?? '',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
            
            const SizedBox(height: 40),
            
            // Draggable Letters
            if (!_isCompleted)
              Wrap(
                spacing: 16,
                children: _shuffledLetters.map((letter) {
                  return Draggable<String>(
                    data: letter,
                    feedback: _buildLetterTile(letter, isDragging: true),
                    childWhenDragging: Opacity(
                      opacity: 0.0,
                      child: _buildLetterTile(letter),
                    ),
                    child: _buildLetterTile(letter),
                  );
                }).toList(),
              ),

            // Next / Finish button when completed
            if (_isCompleted)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: CustomButton(
                  label: _currentWordIndex < _words.length - 1 ? 'Next Sticker' : 'Finish',
                  onTap: _nextWord,
                ),
              ),
              
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildLetterTile(String letter, {bool isDragging = false}) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDragging ? 0.2 : 0.1),
              blurRadius: isDragging ? 10 : 4,
              offset: Offset(0, isDragging ? 8 : 4),
            ),
          ],
          border: Border.all(color: Colors.blueAccent, width: 2),
        ),
        child: Center(
          child: Text(
            letter,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSilhouette(String word) {
    return Container(
      key: ValueKey('silhouette_$word'),
      width: 200,
      height: 200,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Center(
        child: ColorFiltered(
          colorFilter: const ColorFilter.mode(
            Colors.black12,
            BlendMode.srcIn,
          ),
          child: Image.asset(
            'assets/word_book/${word.toLowerCase()}.png',
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.help_outline_rounded,
              size: 100,
              color: Colors.black26,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUnlockedSticker(String word) {
    return Container(
      key: ValueKey('sticker_$word'),
      width: 220,
      height: 220,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.amber.withValues(alpha: 0.3),
            blurRadius: 40,
            spreadRadius: 10,
          )
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(
                'assets/word_book/${word.toLowerCase()}.png',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.star_rounded,
                  size: 80,
                  color: Colors.amber,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              word,
              style: AppTextStyles.headlineLarge.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w900,
                fontSize: 32,
              ),
            )
          ],
        ),
      ),
    );
  }
}
