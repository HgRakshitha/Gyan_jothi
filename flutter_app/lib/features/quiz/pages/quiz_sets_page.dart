import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/text_styles.dart';
import '../../../core/utils/breakpoints.dart';
import '../../../shared/widgets/quiz_header.dart';

class QuizSetsPageArgs {
  final String title;
  final List<String> targetRoutes;
  final List<String> setNames;
  final List<String> setEmojis;
  final int questionCount;

  const QuizSetsPageArgs({
    required this.title,
    required this.targetRoutes,
    required this.setNames,
    required this.setEmojis,
    required this.questionCount,
  });
}

class QuizSetsPage extends StatelessWidget {
  final QuizSetsPageArgs args;

  const QuizSetsPage({
    super.key,
    required this.args,
  });

  static const _colors = [
    Color(0xFFE9B6E7),
    Color(0xFFBDD6F0),
    Color(0xFFEFC0CF),
    Color(0xFFF0D7D9),
    Color(0xFFE5FA46),
  ];

  @override
  Widget build(BuildContext context) {
    final maxContentW = Breakpoints.contentMaxWidth(context);
    final padH = Breakpoints.horizontalPadding(context);
    final padB = Breakpoints.scrollBottomPadding(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      body: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            QuizHeader(
              title: args.title,
              onBack: () => context.pop(),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(padH, 20, padH, padB),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: maxContentW ?? double.infinity,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Choose a Set',
                          style: AppTextStyles.titleMedium.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ...List.generate(
                          args.setNames.length,
                          (index) => Padding(
                            padding: EdgeInsets.only(
                              bottom: index == args.setNames.length - 1 ? 0 : 16,
                            ),
                            child: _SetCard(
                              title: args.setNames[index],
                              emoji: args.setEmojis[index],
                              backgroundColor: _colors[index % _colors.length],
                              targetRoute: args.targetRoutes[index],
                              questionCount: args.questionCount,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SetCard extends StatelessWidget {
  final String title;
  final String emoji;
  final Color backgroundColor;
  final String targetRoute;
  final int questionCount;

  const _SetCard({
    required this.title,
    required this.emoji,
    required this.backgroundColor,
    required this.targetRoute,
    required this.questionCount,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () {
          context.push(targetRoute);
        },
        child: Container(
          height: 120,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  color: Colors.white54,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    emoji,
                    style: const TextStyle(fontSize: 36),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.titleMedium.copyWith(
                        fontWeight: FontWeight.w900,
                        fontSize: 22,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '$questionCount Questions',
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.play_circle_fill_rounded,
                size: 40,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
