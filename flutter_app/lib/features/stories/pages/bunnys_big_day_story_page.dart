import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/navigation/go_to_app_home.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/utils/breakpoints.dart';
import '../../../shared/widgets/quiz_header.dart';
import '../widgets/story_page_scene.dart';

/// Single scrollable page: "Bunny's Big Day" (first–fourth scenes + first image repeated at end).
class BunnysBigDayStoryPage extends StatelessWidget {
  const BunnysBigDayStoryPage({super.key});

  static const _bodyStyle = AppTextStyles.storyParagraph;

  static const _sectionGap = 22.0;
  static const _afterImageGap = 18.0;
  static const _paragraphGap = 14.0;

  @override
  Widget build(BuildContext context) {
    final padH = Breakpoints.horizontalPadding(context);
    final padB = Breakpoints.scrollBottomPadding(context);
    final maxContent = Breakpoints.contentMaxWidth(context);
    final screenW = MediaQuery.sizeOf(context).width;
    final contentW = maxContent != null
        ? math.min(maxContent, screenW - 2 * padH)
        : screenW - 2 * padH;
    final imageW = math.min(340.0, math.max(200.0, contentW));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            QuizHeader(
              title: 'Story',
              onBack: () => goToAppHome(context),
              margin: const EdgeInsets.only(bottom: 16),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.fromLTRB(
                  padH,
                  AppSizes.storyReaderTopPadding,
                  padH,
                  20 + padB,
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: contentW),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const _TitleCard(),
                        const SizedBox(height: 20),
                        _paragraphs([
                          'In a bright green meadow, there lived a little bunny named Bella\u2026',
                          'Today was a big day for Bella the Bunny.',
                        ]),
                        const SizedBox(height: _sectionGap),
                        StoryPageScene(
                          assetPath: AppAssets.storyBunnyDayFirst,
                          width: imageW,
                        ),
                        const SizedBox(height: _afterImageGap),
                        _paragraphs([
                          'She was going to the meadow to play for the first time.',
                          'Bella carried her favorite red ball.',
                          'It was soft and bouncy.',
                        ]),
                        const SizedBox(height: _sectionGap),
                        StoryPageScene(
                          assetPath: AppAssets.storyBunnyDaySecond,
                          width: imageW,
                        ),
                        const SizedBox(height: _afterImageGap),
                        _paragraphs([
                          'When she reached the meadow, she saw other animals playing',
                          'a squirrel, a duck, and a little turtle.',
                          'Bella wanted to join them\u2026 but she felt shy.',
                          'She sat quietly and bounced her ball alone.',
                          'Suddenly, the ball rolled away and stopped near the turtle.',
                        ]),
                        const SizedBox(height: _sectionGap),
                        StoryPageScene(
                          assetPath: AppAssets.storyBunnyDayThird,
                          width: imageW,
                        ),
                        const SizedBox(height: _afterImageGap),
                        _paragraphs([
                          'The turtle picked it up and smiled.',
                          '\u201CCan we play too?\u201D he asked.',
                        ]),
                        const SizedBox(height: _sectionGap),
                        StoryPageScene(
                          assetPath: AppAssets.storyBunnyDayFourth,
                          width: imageW,
                        ),
                        const SizedBox(height: _afterImageGap),
                        _paragraphs([
                          'Bella thought for a moment.',
                          'Then she smiled back. \u201CYes! Let\u2019s play together!\u201D',
                          'Soon, they were laughing, bouncing, and running around the meadow.',
                          'Bella realized something important.',
                          'Sharing her ball made the game more fun.',
                          'And by the end of the day, Bella didn\u2019t just have her red ball.',
                          'She had new friends.',
                        ]),
                        const SizedBox(height: _sectionGap),
                        StoryPageScene(
                          assetPath: AppAssets.storyBunnyDayFirst,
                          width: imageW,
                        ),
                        const SizedBox(height: _afterImageGap),
                        Text(
                          'Moral:',
                          style: AppTextStyles.headlineMedium.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Sharing makes playtime happier, and new friends make every day special.',
                          textAlign: TextAlign.justify,
                          style: _bodyStyle,
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

  Widget _paragraphs(List<String> lines) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < lines.length; i++) ...[
          if (i > 0) const SizedBox(height: _paragraphGap),
          Text(
            lines[i],
            textAlign: TextAlign.justify,
            style: _bodyStyle,
          ),
        ],
      ],
    );
  }
}

class _TitleCard extends StatelessWidget {
  const _TitleCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
      decoration: BoxDecoration(
        color: AppColors.storyTitleBackground,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Bunny\u2019s Big Day',
            textAlign: TextAlign.center,
            style: AppTextStyles.headlineLarge.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'A sweet story about sharing and friendship.',
            textAlign: TextAlign.center,
            style: AppTextStyles.titleMedium.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              height: 1.35,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
