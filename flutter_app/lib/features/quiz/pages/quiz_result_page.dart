import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/utils/breakpoints.dart';
import '../../../shared/providers/user_provider.dart';
import '../../../shared/widgets/quiz_header.dart';
import '../quiz_answer_tracker.dart';
import '../widgets/emoji_blast_animation.dart';

/// Shown after the last question. Supports tabs to show the score and review answers.
class QuizResultPage extends StatelessWidget {
  final String quizTitle;
  final int score;
  final int total;
  final int coins;
  final List<QuizQuestionResult> results;

  const QuizResultPage({
    super.key,
    required this.quizTitle,
    required this.score,
    required this.total,
    required this.coins,
    this.results = const [],
  });

  QuizCelebrationInfo _getCelebrationInfo() {
    final percent = total > 0 ? (score / total) : 0.0;
    if (percent == 1.0) {
      return const QuizCelebrationInfo(
        title: 'Perfect Score!',
        subtitle: 'Wow! You answered everything correctly! You are a superstar! ⭐🌟⭐',
        badgeEmoji: '🏆',
        blastEmojis: ['🏆', '👑', '🥳', '🎉', '⭐', '🥇', '✨'],
        badgeGradients: [Color(0xFFFFD54F), Color(0xFFFF8F00)],
      );
    } else if (percent >= 0.75) {
      return const QuizCelebrationInfo(
        title: 'Outstanding Job!',
        subtitle: 'Almost perfect! You did an amazing job, keep it up! 🚀💖',
        badgeEmoji: '🥳',
        blastEmojis: ['🥳', '🎈', '👏', '🌟', '✨', '🌈', '🎉'],
        badgeGradients: [Color(0xFFE040FB), Color(0xFF00E5FF)],
      );
    } else if (percent >= 0.5) {
      return const QuizCelebrationInfo(
        title: 'Great Effort!',
        subtitle: 'Good job! You got more than half right. Practice makes perfect! 📚🌻',
        badgeEmoji: '😊',
        blastEmojis: ['👍', '😊', '✨', '🎯', '🌈', '🌻', '⚡'],
        badgeGradients: [Color(0xFF00E676), Color(0xFF00B0FF)],
      );
    } else {
      return const QuizCelebrationInfo(
        title: 'Keep Practicing!',
        subtitle: 'You are learning new things! Try again and see if you can get a higher score next time! ❤️🌞',
        badgeEmoji: '🌱',
        blastEmojis: ['💪', '📚', '🌱', '🧸', '💛', '🤗', '🎈'],
        badgeGradients: [Color(0xFFFF9100), Color(0xFFFF3D00)],
      );
    }
  }

  Widget _buildScoreTab(BuildContext context, double padH) {
    final cel = _getCelebrationInfo();
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: padH, vertical: 16),
      child: Column(
        children: [
          Text(
            quizTitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.titleMedium.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 24),
          AnimatedScoreBadge(
            key: ValueKey('$score/$total/$quizTitle'),
            emoji: cel.badgeEmoji,
            gradients: cel.badgeGradients,
          ),
          const SizedBox(height: 28),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  cel.title,
                  style: AppTextStyles.headlineMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w900,
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  'Your score',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '$score / $total',
                  style: AppTextStyles.headlineLarge.copyWith(
                    fontSize: 52,
                    fontWeight: FontWeight.w900,
                    color: AppColors.textPrimary,
                    height: 1.0,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  cel.subtitle,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                    height: 1.45,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewTab(BuildContext context, double padH) {
    if (results.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padH),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '🕵️‍♂️🔍📝',
                style: TextStyle(fontSize: 48),
              ),
              const SizedBox(height: 16),
              Text(
                'No Answer Details',
                style: AppTextStyles.titleMedium.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Play this quiz from the beginning to see your question-by-question review!',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: padH, vertical: 16),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final r = results[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 14),
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: BorderSide(
              color: r.isCorrect 
                  ? const Color(0xFFC8E6C9)
                  : const Color(0xFFFFCDD2),
              width: 2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFECEFF1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Q${index + 1}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        r.question,
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      r.isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
                      color: r.isCorrect ? const Color(0xFF4CAF50) : const Color(0xFFF44336),
                      size: 26,
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: r.isCorrect 
                        ? const Color(0xFFE8F5E9) 
                        : const Color(0xFFFFEBEE),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: RichText(
                    text: TextSpan(
                      text: 'Your Answer: ',
                      style: AppTextStyles.bodySmall.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                      children: [
                        TextSpan(
                          text: r.userAnswer,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: r.isCorrect 
                                ? const Color(0xFF2E7D32) 
                                : const Color(0xFFC62828),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (!r.isCorrect) ...[
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: RichText(
                      text: TextSpan(
                        text: 'Correct Answer: ',
                        style: AppTextStyles.bodySmall.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                        children: [
                          TextSpan(
                            text: r.correctAnswer,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF2E7D32),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final padH = Breakpoints.horizontalPadding(context);
    final padB = Breakpoints.scrollBottomPadding(context);
    final cel = _getCelebrationInfo();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F9FA),
        body: SafeArea(
          top: false,
          child: Stack(
            children: [
              QuizCoinsAwarder(quizTitle: quizTitle, coins: coins),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  QuizHeader(
                    title: 'Quiz Result',
                    onBack: () => context.go(AppRoutes.quiz),
                    margin: const EdgeInsets.only(bottom: 8),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: padH, vertical: 8),
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        labelColor: AppColors.textPrimary,
                        unselectedLabelColor: AppColors.textSecondary,
                        dividerColor: Colors.transparent,
                        labelStyle: AppTextStyles.titleSmall.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                        unselectedLabelStyle: AppTextStyles.titleSmall.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        tabs: const [
                          Tab(text: 'Score'),
                          Tab(text: 'Review Answers'),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildScoreTab(context, padH),
                        _buildReviewTab(context, padH),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(padH, 8, padH, 16 + padB),
                    child: SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: FilledButton(
                        onPressed: () => context.go(AppRoutes.quiz),
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.textPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26),
                          ),
                        ),
                        child: Text(
                          'Back to quizzes',
                          style: AppTextStyles.titleSmall.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned.fill(
                child: EmojiBlastAnimation(
                  key: ValueKey('$score/$total/$quizTitle'),
                  emojis: cel.blastEmojis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Helper model for celebration data
class QuizCelebrationInfo {
  final String title;
  final String subtitle;
  final String badgeEmoji;
  final List<String> blastEmojis;
  final List<Color> badgeGradients;

  const QuizCelebrationInfo({
    required this.title,
    required this.subtitle,
    required this.badgeEmoji,
    required this.blastEmojis,
    required this.badgeGradients,
  });
}

/// Animated score badge that scales/bounces in springily on load
class AnimatedScoreBadge extends StatefulWidget {
  final String emoji;
  final List<Color> gradients;

  const AnimatedScoreBadge({
    super.key,
    required this.emoji,
    required this.gradients,
  });

  @override
  State<AnimatedScoreBadge> createState() => _AnimatedScoreBadgeState();
}

class _AnimatedScoreBadgeState extends State<AnimatedScoreBadge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.1, 0.9, curve: Curves.elasticOut),
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        width: 130,
        height: 130,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: widget.gradients,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: widget.gradients.last.withValues(alpha: 0.35),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: widget.gradients.first.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Container(
          margin: const EdgeInsets.all(5),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          alignment: Alignment.center,
          child: Text(
            widget.emoji,
            style: const TextStyle(
              fontSize: 60,
              height: 1.15,
            ),
          ),
        ),
      ),
    );
  }
}

class QuizCoinsAwarder extends ConsumerStatefulWidget {
  final String quizTitle;
  final int coins;

  const QuizCoinsAwarder({
    super.key,
    required this.quizTitle,
    required this.coins,
  });

  @override
  ConsumerState<QuizCoinsAwarder> createState() => _QuizCoinsAwarderState();
}

class _QuizCoinsAwarderState extends ConsumerState<QuizCoinsAwarder> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final success = ref.read(userProvider.notifier).completeActivity('quiz_${widget.quizTitle}', widget.coins);
      if (success) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.stars_rounded, color: Colors.amber, size: 24),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Awesome! You earned ${widget.coins} coins! 🪙🏆',
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: const Color(0xFF4CAF50),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

