import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/navigation/go_to_app_home.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/utils/breakpoints.dart';
import '../../../core/utils/search_filter.dart';
import '../../../shared/widgets/app_asset_image.dart';
import '../../../shared/widgets/quiz_header.dart';
import '../../../shared/widgets/search_bar.dart';
import '../../../shared/widgets/search_empty_state.dart';

class StoriesPage extends StatefulWidget {
  const StoriesPage({super.key});

  @override
  State<StoriesPage> createState() => _StoriesPageState();
}

class _StoriesPageState extends State<StoriesPage> {
  String _query = '';

  static const _stories = <_StoryCardData>[
    _StoryCardData(
      title: "Bunny's Big Day",
      description:
          "A sweet story about sharing, playing, and making new friends.",
      gradientColors: [Color(0xFFF5E6A3), Color(0xFFF0D4BE)],
      imagePath: AppAssets.storyBunnysDay,
      navigateTo: AppRoutes.storyBunnyBigDay,
    ),
    _StoryCardData(
      title: "Ellie the Kind Elephant",
      description:
          "Learn kindness and helping others through Ellie's little adventures.",
      gradientColors: [Color(0xFFB8D4E8), Color(0xFFD8C8E8)],
      imagePath: AppAssets.storyElie,
      navigateTo: AppRoutes.storyEllieKindElephant,
    ),
    _StoryCardData(
      title: "Chicky Learns to Walk",
      description: "A fun story about trying again and never giving up.",
      gradientColors: [Color(0xFFF2D6DB), Color(0xFFF5E0D0)],
      imagePath: AppAssets.storyChicky,
      navigateTo: AppRoutes.storyChickyLearnsToWalk,
    ),
    _StoryCardData(
      title: "The Shining Star",
      description:
          "A bedtime story about believing in yourself and glowing bright.",
      gradientColors: [Color(0xFFFFB5C8), Color(0xFFE8A0C0)],
      imagePath: AppAssets.storyShiningStar,
      navigateTo: AppRoutes.storyShiningStar,
    ),
    _StoryCardData(
      title: "Teddy's Lost Button",
      description: "A simple problem-solving story with teamwork and care.",
      gradientColors: [Color(0xFFE8B4C8), Color(0xFFF2D0DB)],
      imagePath: AppAssets.storyTeddy,
      navigateTo: AppRoutes.storyTeddysLostButton,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final maxContentW = Breakpoints.contentMaxWidth(context);
    final padH = Breakpoints.horizontalPadding(context);
    final padB = Breakpoints.scrollBottomPadding(context);

    final filtered = _stories
        .where(
          (s) => matchesSearchQuery(
            _query,
            [s.title, s.description],
          ),
        )
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              QuizHeader(
                title: 'Stories',
                onBack: () => popOrGoToAppHome(context),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(padH, 16, padH, padB),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: maxContentW ?? double.infinity,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppSearchBar(
                            hint: 'Search Stories',
                            onChanged: (v) => setState(() => _query = v),
                          ),
                          const SizedBox(height: 16),
                          if (filtered.isEmpty && _query.trim().isNotEmpty)
                            const SearchEmptyState()
                          else
                            ...List.generate(
                              filtered.length,
                              (index) => Padding(
                                padding: EdgeInsets.only(
                                  bottom:
                                      index == filtered.length - 1 ? 0 : 12,
                                ),
                                child: _StoryCard(data: filtered[index]),
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
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  final _StoryCardData data;

  const _StoryCard({required this.data});

  @override
  Widget build(BuildContext context) {
    final card = Container(
      height: 158,
      padding: const EdgeInsets.fromLTRB(12, 10, 8, 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: data.gradientColors,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.titleMedium.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    data.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: const Color(0xFF000000),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      height: 1.25,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 140,
            height: 132,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: AppAssetImage(
                assetPath: data.imagePath,
                width: 132,
                height: 132,
                fit: BoxFit.cover,
                fallback: Icon(
                  Icons.menu_book_rounded,
                  size: 74,
                  color: Colors.black.withValues(alpha: 0.42),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    final route = data.navigateTo;
    if (route != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () => context.push(route),
          child: card,
        ),
      );
    }
    return card;
  }
}

class _StoryCardData {
  final String title;
  final String description;
  final List<Color> gradientColors;
  final String imagePath;
  final String? navigateTo;

  const _StoryCardData({
    required this.title,
    required this.description,
    required this.gradientColors,
    required this.imagePath,
    this.navigateTo,
  });
}
