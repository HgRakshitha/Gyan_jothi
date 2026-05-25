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

class MathHomePage extends StatefulWidget {
  const MathHomePage({super.key});

  @override
  State<MathHomePage> createState() => _MathHomePageState();
}

class _MathHomePageState extends State<MathHomePage> {
  String _query = '';

  static const _chapters = <_ChapterCardData>[
    _ChapterCardData(
      title: 'Numbers',
      subtitle: 'Learn numbers with fun and pictures',
      materialsCount: 3,
      backgroundColor: Color(0xFFF2D6DB),
      imagePath: AppAssets.mathNumbers,
    ),
    _ChapterCardData(
      title: 'Counting',
      subtitle: 'Count objects and learn numbers',
      materialsCount: 4,
      backgroundColor: Color(0xFFBDD6F5),
      imagePath: AppAssets.mathCount,
    ),
    _ChapterCardData(
      title: 'Shapes',
      subtitle: 'Learn shapes around you',
      materialsCount: 4,
      backgroundColor: Color(0xFFD8B4ED),
      imagePath: AppAssets.mathShapes,
    ),
    _ChapterCardData(
      title: 'Addition (Intro)',
      subtitle: 'Add numbers using objects',
      materialsCount: 3,
      backgroundColor: Color(0xFFF3E1A9),
      imagePath: AppAssets.mathAddition,
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
                title: 'Math',
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
                            hint: 'Search Math',
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
          if (data.title == 'Numbers') {
            context.push(AppRoutes.mathNumbers);
          } else if (data.title == 'Counting') {
            context.push(AppRoutes.mathCounting);
          } else if (data.title == 'Shapes') {
            context.push(AppRoutes.mathShapes);
          } else if (data.title == 'Addition (Intro)') {
            context.push(AppRoutes.mathAddition);
          }
        },
        borderRadius: BorderRadius.circular(24),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Container(
            height: 160,
            decoration: BoxDecoration(
              color: data.backgroundColor,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 20,
                  top: 0,
                  bottom: 0,
                  right: 155,
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
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  width: 155,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: AppAssetImage(
                      assetPath: data.imagePath,
                      width: 155,
                      height: 160,
                      fit: BoxFit.contain,
                      fallback: const Icon(Icons.calculate_rounded, size: 72),
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
