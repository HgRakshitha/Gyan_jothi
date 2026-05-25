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

/// Single scrollable page: "Teddy's Lost Button".
class TeddysLostButtonStoryPage extends StatelessWidget {
  const TeddysLostButtonStoryPage({super.key});

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
                        const _TeddyTitleCard(),
                        const SizedBox(height: 20),
                        _paragraphs([
                          'Teddy was a small brown bear with a bright blue button on his favorite jacket.',
                          'He loved that button.',
                          'It shined in the sunlight and made him feel special.',
                          'One morning, while playing in the meadow with his friends, Teddy suddenly stopped.',
                          '\u201COh no!\u201D he gasped.',
                          'His blue button was gone.',
                        ]),
                        const SizedBox(height: _sectionGap),
                        StoryPageScene(
                          assetPath: AppAssets.storyTeddyButtonOne,
                          width: imageW,
                        ),
                        const SizedBox(height: _afterImageGap),
                        _paragraphs([
                          'Teddy looked down at his jacket. There was only a tiny empty thread where the button used to be.',
                          'His eyes filled with worry.',
                          '\u201CWhat if I never find it?\u201D he whispered.',
                          'His friends gathered around him \u2014 Bunny, Fox, and Little Duck.',
                          '\u201CDon\u2019t worry,\u201D said Bunny gently.',
                          '\u201CWe\u2019ll help you.\u201D',
                        ]),
                        const SizedBox(height: _sectionGap),
                        StoryPageScene(
                          assetPath: AppAssets.storyTeddyButtonTwo,
                          width: imageW,
                        ),
                        const SizedBox(height: _afterImageGap),
                        _paragraphs([
                          'They searched near the flowers.',
                        ]),
                        const SizedBox(height: _sectionGap),
                        StoryPageScene(
                          assetPath: AppAssets.storyTeddyButtonThree,
                          width: imageW,
                        ),
                        const SizedBox(height: _afterImageGap),
                        _paragraphs([
                          'They looked under small stones.',
                          'Fox checked near the tree.',
                          'Duck waddled carefully near the pond.',
                          'Suddenly\u2026',
                          '\u201CI found something!\u201D shouted Duck.',
                        ]),
                        const SizedBox(height: _sectionGap),
                        StoryPageScene(
                          assetPath: AppAssets.storyTeddyButtonFour,
                          width: imageW,
                        ),
                        const SizedBox(height: _afterImageGap),
                        _paragraphs([
                          'There, near a little bush, lay the small blue button.',
                          'Teddy\u2019s face lit up with joy.',
                          'Fox carefully picked it up.',
                          'Bunny helped hold the jacket steady.',
                          'Duck brought a tiny needle and thread from her little basket.',
                          'Together, they stitched the button back onto Teddy\u2019s jacket.',
                          'Teddy smiled warmly.',
                          '\u201CIt\u2019s not just my button,\u201D he said.',
                          '\u201CIt\u2019s our button now.\u201D',
                          'And from that day on, Teddy knew something important:',
                          'Problems feel smaller when friends help.',
                        ]),
                        const SizedBox(height: _sectionGap),
                        StoryPageScene(
                          assetPath: AppAssets.storyTeddyButtonFive,
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
                          'When we help each other, problems become easier to solve.',
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

class _TeddyTitleCard extends StatelessWidget {
  const _TeddyTitleCard();

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
            'Teddy\u2019s Lost Button',
            textAlign: TextAlign.center,
            style: AppTextStyles.headlineLarge.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'A story about solving problems together.',
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
