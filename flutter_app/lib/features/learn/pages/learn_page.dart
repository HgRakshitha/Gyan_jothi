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

class LearnPage extends StatefulWidget {
  const LearnPage({super.key});

  @override
  State<LearnPage> createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  String _query = '';

  static const _materials = <_MaterialCardData>[
    _MaterialCardData(
      title: 'English',
      subtitle: '8 Chapters',
      backgroundColor: Color(0xFFEFB39F),
      imagePath: AppAssets.learnEnglish,
    ),
    _MaterialCardData(
      title: 'Math',
      subtitle: '5 Chapters',
      backgroundColor: Color(0xFFF3E1A9),
      imagePath: AppAssets.learnMath,
    ),
    _MaterialCardData(
      title: 'Science',
      subtitle: '7 Chapters',
      backgroundColor: Color(0xFFBCD8F5),
      imagePath: AppAssets.learnScience,
    ),
    _MaterialCardData(
      title: 'Art & Craft',
      subtitle: '9 Chapters',
      backgroundColor: Color(0xFFF2D6DB),
      imagePath: AppAssets.learnArts,
    ),
  ];

  static const _games = <_GameCardData>[
    _GameCardData(
      title: 'Match the\nAlphabet',
      subtitle: 'Match uppercase with lowercase',
      tag: 'Medium',
      tagColor: Color(0xFFF1C933),
      backgroundColor: Color(0xFFD8B4ED),
      imagePath: AppAssets.learnAlphabet,
    ),
    _GameCardData(
      title: 'Count the\nObjects',
      subtitle: 'Count & select the right number',
      tag: 'Easy',
      tagColor: Color(0xFF8ADE63),
      backgroundColor: Color(0xFFF0D4BE),
      imagePath: AppAssets.learnObjects,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final maxContentW = Breakpoints.contentMaxWidth(context);
    final padH = Breakpoints.horizontalPadding(context);
    final padB = Breakpoints.scrollBottomPadding(context);

    final materialEntries = [
      (
        _materials[0],
        () => context.push(AppRoutes.englishHome),
      ),
      (
        _materials[1],
        () => context.push(AppRoutes.mathHome),
      ),
      (
        _materials[2],
        () => context.push(AppRoutes.scienceHome),
      ),
      (
        _materials[3],
        () => context.push(AppRoutes.artCraftHome),
      ),
    ];
    final filteredMaterials = materialEntries
        .where(
          (e) => matchesSearchQuery(
            _query,
            [e.$1.title, e.$1.subtitle],
          ),
        )
        .toList();
    final filteredGames = _games
        .where(
          (g) => matchesSearchQuery(
            _query,
            [g.title, g.subtitle, g.tag],
          ),
        )
        .toList();
    final showEmpty = _query.trim().isNotEmpty &&
        filteredMaterials.isEmpty &&
        filteredGames.isEmpty;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              QuizHeader(
                title: 'Learn',
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
                            hint: 'Search Learn',
                            onChanged: (v) => setState(() => _query = v),
                          ),
                          const SizedBox(height: 16),
                          if (filteredMaterials.isNotEmpty) ...[
                            const _SectionTitle(
                              title: 'Study Materials',
                              action: 'View All',
                            ),
                            const SizedBox(height: 8),
                            ..._twoColumnRows(
                              filteredMaterials
                                  .map(
                                    (e) => () => _LearnMaterialCard(
                                          data: e.$1,
                                          onTap: e.$2,
                                        ),
                                  )
                                  .toList(),
                            ),
                            const SizedBox(height: 16),
                          ],
                          if (filteredGames.isNotEmpty) ...[
                            const _SectionTitle(
                              title: 'Fun Learning Games',
                              action: 'View All',
                            ),
                            const SizedBox(height: 8),
                            ..._twoColumnRows(
                              filteredGames
                                  .map(
                                    (g) => () => _LearnGameCard(data: g),
                                  )
                                  .toList(),
                              crossGap: 16,
                            ),
                          ],
                          if (showEmpty) const SearchEmptyState(),
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

List<Widget> _twoColumnRows(
  List<Widget Function()> itemBuilders, {
  double crossGap = 14,
  double rowGap = 16,
}) {
  final out = <Widget>[];
  for (var i = 0; i < itemBuilders.length; i += 2) {
    if (i > 0) out.add(SizedBox(height: rowGap));
    out.add(
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: itemBuilders[i]()),
          if (i + 1 < itemBuilders.length) ...[
            SizedBox(width: crossGap),
            Expanded(child: itemBuilders[i + 1]()),
          ],
        ],
      ),
    );
  }
  return out;
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final String? action;

  const _SectionTitle({
    required this.title,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyles.titleMedium.copyWith(
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
        if (action != null)
          Text(
            action!,
            style: AppTextStyles.bodySmall.copyWith(
              color: Colors.black87,
              fontWeight: FontWeight.w700,
            ),
          ),
      ],
    );
  }
}

class _LearnMaterialCard extends StatelessWidget {
  final _MaterialCardData data;
  final VoidCallback? onTap;

  const _LearnMaterialCard({required this.data, this.onTap});

  @override
  Widget build(BuildContext context) {
    final child = Container(
      height: 162,
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 12),
      decoration: BoxDecoration(
        color: data.backgroundColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 2,
            right: 2,
            child: AppAssetImage(
              assetPath: data.imagePath,
              width: 92,
              height: 92,
              fallback: const Icon(Icons.menu_book_rounded, size: 70),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title,
                  style: AppTextStyles.titleMedium.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                    data.subtitle,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: Colors.black87,
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: child,
      );
    }
    return child;
  }
}

class _LearnGameCard extends StatelessWidget {
  final _GameCardData data;

  const _LearnGameCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      // 2-line titles + subtitle + tag exceed 200px inner height; was overflowing ~21px.
      height: 226,
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
      decoration: BoxDecoration(
        color: data.backgroundColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: AppAssetImage(
              assetPath: data.imagePath,
              width: 92,
              height: 92,
              fallback: Icon(
                Icons.extension_rounded,
                size: 68,
                color: Colors.amber.shade700,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            data.title,
            style: AppTextStyles.titleMedium.copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 15,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            data.subtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bodySmall.copyWith(
              color: Colors.black87,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
          ),
          const Spacer(),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: data.tagColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              data.tag,
              style: AppTextStyles.labelSmall.copyWith(
                color: Colors.black87,
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MaterialCardData {
  final String title;
  final String subtitle;
  final Color backgroundColor;
  final String imagePath;

  const _MaterialCardData({
    required this.title,
    required this.subtitle,
    required this.backgroundColor,
    required this.imagePath,
  });
}

class _GameCardData {
  final String title;
  final String subtitle;
  final String tag;
  final Color tagColor;
  final Color backgroundColor;
  final String imagePath;

  const _GameCardData({
    required this.title,
    required this.subtitle,
    required this.tag,
    required this.tagColor,
    required this.backgroundColor,
    required this.imagePath,
  });
}
