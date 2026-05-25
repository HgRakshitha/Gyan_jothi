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

/// Single scrollable page: "The Shining Star".
class ShiningStarStoryPage extends StatelessWidget {
  const ShiningStarStoryPage({super.key});

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
                        const _ShiningStarTitleCard(),
                        const SizedBox(height: 20),
                        _paragraphs([
                          'High above the quiet town, in the dark blue night sky, lived a tiny star named Lumi.',
                          'All the other stars sparkled brightly.',
                          'They twinkled and shimmered proudly.',
                          'But Lumi felt different.',
                          '\u201CI\u2019m not as bright as the others,\u201D she whispered softly.',
                        ]),
                        const SizedBox(height: _sectionGap),
                        StoryPageScene(
                          assetPath: AppAssets.storyShiningStarOne,
                          width: imageW,
                        ),
                        const SizedBox(height: _afterImageGap),
                        _paragraphs([
                          'Every night, she tried to glow stronger.',
                          'But whenever she looked at the biggest star in the sky, she felt small.',
                          'One evening, a gentle silver moon noticed her sadness.',
                          '\u201CWhy do you hide your light?\u201D asked the Moon kindly.',
                        ]),
                        const SizedBox(height: _sectionGap),
                        StoryPageScene(
                          assetPath: AppAssets.storyShiningStarTwo,
                          width: imageW,
                        ),
                        const SizedBox(height: _afterImageGap),
                        _paragraphs([
                          '\u201CI\u2019m not bright enough,\u201D Lumi replied.',
                          'The Moon smiled.',
                          '\u201CEvery star shines in its own way. You don\u2019t have to be the biggest. Just be yourself.\u201D',
                          'That night, Lumi stopped comparing.',
                          'She took a deep breath.',
                          'She glowed softly\u2026',
                          'Then a little brighter\u2026',
                          'And brighter\u2026',
                        ]),
                        const SizedBox(height: _sectionGap),
                        StoryPageScene(
                          assetPath: AppAssets.storyShiningStarThree,
                          width: imageW,
                        ),
                        const SizedBox(height: _afterImageGap),
                        _paragraphs([
                          'Suddenly, her warm golden light began to shimmer beautifully.',
                          'Down below, a little child looked up from her window.',
                          '\u201CLook, Mama! That star is so pretty!\u201D',
                        ]),
                        const SizedBox(height: _sectionGap),
                        StoryPageScene(
                          assetPath: AppAssets.storyShiningStarFour,
                          width: imageW,
                        ),
                        const SizedBox(height: _afterImageGap),
                        _paragraphs([
                          'Lumi sparkled happily.',
                          'She realized something very important:',
                          'She was always shining.',
                          'She just needed to believe it.',
                          'And from that night on, Lumi glowed with confidence \u2014 not because she was the biggest star, but because she was herself.',
                        ]),
                        const SizedBox(height: _sectionGap),
                        StoryPageScene(
                          assetPath: AppAssets.storyShiningStarFive,
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
                          'Believe in yourself. You shine in your own special way.',
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

class _ShiningStarTitleCard extends StatelessWidget {
  const _ShiningStarTitleCard();

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
            'The Shining Star',
            textAlign: TextAlign.center,
            style: AppTextStyles.headlineLarge.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'A bedtime story about believing in yourself and glowing bright.',
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
