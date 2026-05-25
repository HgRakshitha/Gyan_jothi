import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


import '../../../../core/constants/app_assets.dart';
import '../../../../core/navigation/go_to_app_home.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/breakpoints.dart';
import '../../../../core/utils/search_filter.dart';
import '../../../../shared/widgets/app_asset_image.dart';
import '../../../../shared/widgets/quiz_header.dart';
import '../../../../shared/widgets/search_bar.dart';
import '../../../../shared/widgets/search_empty_state.dart';

class ScienceHomePage extends StatefulWidget {
  const ScienceHomePage({super.key});

  @override
  State<ScienceHomePage> createState() => _ScienceHomePageState();
}

class _ScienceHomePageState extends State<ScienceHomePage> {
  String _query = '';

  static const _chapters = <_ChapterCardData>[
    _ChapterCardData(
      title: 'Living & Non-Living',
      subtitle: 'Learn what is alive and not alive',
      materialsCount: 4,
      backgroundColor: Color(0xFFF3E1A9),
      imagePath: AppAssets.scienceLiving,
    ),
    _ChapterCardData(
      title: 'Animals',
      subtitle: 'Learn animals and their sounds',
      materialsCount: 4,
      backgroundColor: Color(0xFFF2D6DB),
      imagePath: AppAssets.scienceAnimals,
    ),
    _ChapterCardData(
      title: 'Plants',
      subtitle: 'Know plants and how they grow',
      materialsCount: 4,
      backgroundColor: Color(0xFFE8E4EC),
      imagePath: AppAssets.sciencePlants,
    ),
    _ChapterCardData(
      title: 'Water & Air',
      subtitle: 'Learn about water and air',
      materialsCount: 4,
      backgroundColor: Color(0xFFF5D4C4),
      imagePath: AppAssets.scienceWater,
    ),
    _ChapterCardData(
      title: 'Human Body',
      subtitle: 'Learn about body parts',
      materialsCount: 4,
      backgroundColor: Color(0xFFD4D8F0),
      imagePath: AppAssets.scienceHumanBody,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final maxContentW = Breakpoints.contentMaxWidth(context);
    final padH = Breakpoints.horizontalPadding(context);
    final padB = Breakpoints.scrollBottomPadding(context);

    final filtered = _chapters
        .where(
          (c) => matchesSearchQuery(
            _query,
            [c.title, c.subtitle, '${c.materialsCount}'],
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
                title: 'Science',
                onBack: () => goToAppHome(context),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(padH, 20, padH, padB),
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
                            hint: 'Search Science',
                            onChanged: (v) => setState(() => _query = v),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Choose a Chapter',
                            style: AppTextStyles.titleMedium.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (filtered.isEmpty && _query.trim().isNotEmpty)
                            const SearchEmptyState()
                          else
                            ...List.generate(
                              filtered.length,
                              (index) => Padding(
                                padding: EdgeInsets.only(
                                  bottom:
                                      index == filtered.length - 1 ? 0 : 16,
                                ),
                                child: _ChapterCard(data: filtered[index]),
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

class _ChapterCard extends StatelessWidget {
  final _ChapterCardData data;

  const _ChapterCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if (data.title == 'Living & Non-Living') {
            context.push(AppRoutes.scienceLiving);
          } else if (data.title == 'Animals') {
            context.push(AppRoutes.scienceAnimals);
          } else if (data.title == 'Plants') {
            context.push(AppRoutes.sciencePlants);
          } else if (data.title == 'Water & Air') {
            context.push(AppRoutes.scienceWaterAir);
          } else if (data.title == 'Human Body') {
            context.push(AppRoutes.scienceHumanBody);
          }
        },
        borderRadius: BorderRadius.circular(24),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Container(
            height: 140,
            decoration: BoxDecoration(
              color: data.backgroundColor,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Stack(
              children: [
                // Text content on left
                Positioned(
                  left: 20,
                  top: 0,
                  bottom: 0,
                  right: 130,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.title,
                        style: AppTextStyles.titleMedium.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        data.subtitle,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.45),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.9),
                            width: 1.0,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          '${data.materialsCount} Materials',
                          style: AppTextStyles.labelSmall.copyWith(
                            color: Colors.black87,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Image integrated into card
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  width: 130,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: AppAssetImage(
                      assetPath: data.imagePath,
                      width: 130,
                      height: 140,
                      fit: BoxFit.contain,
                      fallback: const Icon(Icons.science_rounded, size: 64),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ChapterCardData {
  final String title;
  final String subtitle;
  final int materialsCount;
  final Color backgroundColor;
  final String imagePath;

  const _ChapterCardData({
    required this.title,
    required this.subtitle,
    required this.materialsCount,
    required this.backgroundColor,
    required this.imagePath,
  });
}
