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

/// Single scrollable page: "Chicky Learns to Walk".
class ChickyLearnsToWalkStoryPage extends StatelessWidget {
  const ChickyLearnsToWalkStoryPage({super.key});

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
                        const _ChickyTitleCard(),
                        const SizedBox(height: 20),
                        _paragraphs([
                          'Chicky was a tiny yellow chick with soft feathers and wobbly little legs.',
                          'Today was a big day.',
                          'Chicky wanted to walk all by herself.',
                        ]),
                        const SizedBox(height: _sectionGap),
                        StoryPageScene(
                          assetPath: AppAssets.storyChickyWalkOne,
                          width: imageW,
                        ),
                        const SizedBox(height: _afterImageGap),
                        _paragraphs([
                          'Mama Hen smiled gently.',
                          '\u201CYou can do it, Chicky. Just try.\u201D',
                          'Chicky took one small step\u2026',
                          'Wobble.',
                          'Another step\u2026',
                          'Wiggle.',
                          'And then\u2014 Plop!',
                          'She fell softly on the grass.',
                        ]),
                        const SizedBox(height: _sectionGap),
                        StoryPageScene(
                          assetPath: AppAssets.storyChickyWalkTwo,
                          width: imageW,
                        ),
                        const SizedBox(height: _afterImageGap),
                        _paragraphs([
                          'Chicky\u2019s eyes filled with tears.',
                          '\u201CI can\u2019t do it,\u201D she sniffed.',
                          'Nearby, a little brown bunny hopped closer.',
                          '\u201CTry again!\u201D said Bunny cheerfully.',
                        ]),
                        const SizedBox(height: _sectionGap),
                        StoryPageScene(
                          assetPath: AppAssets.storyChickyWalkThree,
                          width: imageW,
                        ),
                        const SizedBox(height: _afterImageGap),
                        _paragraphs([
                          'A friendly turtle nodded slowly.',
                          '\u201CSlow steps are strong steps.\u201D',
                          'Chicky wiped her tears.',
                          'She stood up again.',
                          'Step.',
                          'Wobble.',
                          'Step.',
                          'Wiggle.',
                          'She almost fell\u2026',
                          'But this time she balanced!',
                        ]),
                        const SizedBox(height: _sectionGap),
                        StoryPageScene(
                          assetPath: AppAssets.storyChickyWalkFour,
                          width: imageW,
                        ),
                        const SizedBox(height: _afterImageGap),
                        _paragraphs([
                          'One more step.',
                          'And another.',
                          'And another!',
                          '\u201CI\u2019m walking! I\u2019m walking!\u201D Chicky chirped happily.',
                          'Mama Hen flapped her wings proudly.',
                          'The bunny clapped.',
                          'The turtle smiled.',
                          'Chicky learned something very important that day:',
                          'If you fall, you can stand again.',
                          'If you try, you can grow.',
                          'And if you never give up, you will succeed.',
                        ]),
                        const SizedBox(height: _sectionGap),
                        StoryPageScene(
                          assetPath: AppAssets.storyChickyWalkFive,
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
                          'If you fall, don\u2019t give up. Try again, and you will succeed.',
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

class _ChickyTitleCard extends StatelessWidget {
  const _ChickyTitleCard();

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
            'Chicky Learns to Walk',
            textAlign: TextAlign.center,
            style: AppTextStyles.headlineLarge.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'A story about trying again and never giving up',
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
