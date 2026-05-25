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

/// Single scrollable page: "Ellie the Kind Elephant".
class EllieKindElephantStoryPage extends StatelessWidget {
  const EllieKindElephantStoryPage({super.key});

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
                        const _EllieTitleCard(),
                        const SizedBox(height: 20),
                        _paragraphs([
                          'Ellie was a little elephant with big floppy ears and even bigger eyes.',
                          'She lived in a sunny green forest where birds sang every morning and butterflies danced in the air.',
                          'Ellie was not the strongest elephant.',
                          'She was not the fastest either.',
                          'But she had something very special.',
                          'She had a kind heart.',
                        ]),
                        const SizedBox(height: _sectionGap),
                        StoryPageScene(
                          assetPath: AppAssets.storyEllieSceneFirst,
                          width: imageW,
                        ),
                        const SizedBox(height: _afterImageGap),
                        _paragraphs([
                          'One bright morning, Ellie was walking through the forest when she heard a tiny cry.',
                          '\u201CHelp! Help!\u201D',
                          'She looked up and saw a small bird fluttering near the ground.',
                          'The bird\u2019s nest had fallen from the tree.',
                          '\u201COh no,\u201D said Ellie softly. \u201CDon\u2019t worry. I will help you.\u201D',
                          'Very carefully, Ellie picked up the nest with her trunk.',
                          'She stood on her tiptoes and gently placed it back on the branch. The baby bird chirped happily.',
                          '\u201CThank you, Ellie!\u201D',
                          'Ellie smiled. Her heart felt warm.',
                        ]),
                        const SizedBox(height: _sectionGap),
                        StoryPageScene(
                          assetPath: AppAssets.storyEllieSceneSecond,
                          width: imageW,
                        ),
                        const SizedBox(height: _afterImageGap),
                        _paragraphs([
                          'Later that afternoon, the sun grew hot.',
                          'Ellie saw a rabbit and a deer sitting under a tree.',
                          'They looked tired and thirsty.',
                          '\u201CThere is no water nearby,\u201D said the rabbit sadly.',
                          'Ellie knew what to do.',
                          'She walked to the pond, filled her trunk with cool water, and carried it back.',
                          'She sprayed the water gently so her friends could drink.',
                          '\u201CAhhh!\u201D said the deer. \u201CYou saved us!\u201D',
                          'Ellie giggled. Helping felt wonderful.',
                        ]),
                        const SizedBox(height: _sectionGap),
                        StoryPageScene(
                          assetPath: AppAssets.storyEllieSceneThird,
                          width: imageW,
                        ),
                        const SizedBox(height: _afterImageGap),
                        _paragraphs([
                          'As the day was ending, Ellie noticed a tiny tortoise stuck in the mud.',
                          'He was trying very hard to move, but he could not.',
                          '\u201CPlease don\u2019t cry,\u201D Ellie said kindly.',
                          'She did not rush.',
                          'She did not push too hard.',
                          'Slowly and gently, she helped the tortoise onto dry ground.',
                          '\u201CThank you for being patient,\u201D the tortoise said.',
                          'Ellie felt proud.',
                        ]),
                        const SizedBox(height: _sectionGap),
                        StoryPageScene(
                          assetPath: AppAssets.storyEllieSceneFourth,
                          width: imageW,
                        ),
                        const SizedBox(height: _afterImageGap),
                        _paragraphs([
                          'That evening, all the animals gathered around Ellie.',
                          'The bird sang a happy song.',
                          'The rabbit brought flowers.',
                          'The deer bowed politely.',
                          'The tortoise smiled warmly.',
                          '\u201CYou are the kindest elephant in the forest,\u201D they said.',
                          'Ellie felt shy.',
                          'She was not the biggest.',
                          'She was not the strongest.',
                          'But she knew something very important.',
                          'Kindness makes you big inside.',
                          'And that made Ellie the happiest elephant of all.',
                        ]),
                        const SizedBox(height: _sectionGap),
                        StoryPageScene(
                          assetPath: AppAssets.storyEllieSceneFifth,
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
                          'Kindness makes the world brighter.',
                          textAlign: TextAlign.justify,
                          style: _bodyStyle,
                        ),
                        const SizedBox(height: _paragraphGap),
                        const Text(
                          'Helping others makes your heart grow.',
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

class _EllieTitleCard extends StatelessWidget {
  const _EllieTitleCard();

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
            'Ellie the Kind Elephant',
            textAlign: TextAlign.center,
            style: AppTextStyles.headlineLarge.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'A story about kindness and helping others.',
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
