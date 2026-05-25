import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/navigation/go_to_app_home.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/breakpoints.dart';
import '../../../../core/utils/search_filter.dart';
import '../../../../shared/widgets/quiz_header.dart';
import '../../../../shared/widgets/search_bar.dart';
import '../../../../shared/widgets/search_empty_state.dart';

/// Which chapter screen to open (avoid matching UI copy — ampersands / typos break `== title`).
enum _ArtCraftChapterNav {
  creativeDrawing,
  colorAndCreate,
  makeAScene,
  foldAndCreate,
}

class ArtCraftHomePage extends StatefulWidget {
  const ArtCraftHomePage({super.key});

  @override
  State<ArtCraftHomePage> createState() => _ArtCraftHomePageState();
}

class _ArtCraftHomePageState extends State<ArtCraftHomePage> {
  String _query = '';

  static const _chapters = <_ChapterCardData>[
    _ChapterCardData(
      nav: _ArtCraftChapterNav.creativeDrawing,
      title: 'Creative Drawing',
      subtitle: 'Draw simple guided objects.',
      materialsCount: 4,
      backgroundColor: Color(0xFFF2D6DB),
    ),
    _ChapterCardData(
      nav: _ArtCraftChapterNav.colorAndCreate,
      title: 'Color & Create',
      subtitle: 'Color with purpose, not random filling.',
      materialsCount: 4,
      backgroundColor: Color(0xFFBCD8F5),
    ),
    _ChapterCardData(
      nav: _ArtCraftChapterNav.makeAScene,
      title: 'Make a Scene',
      subtitle: 'Build a complete picture using objects.',
      materialsCount: 4,
      backgroundColor: Color(0xFFE8D4E8),
    ),
    _ChapterCardData(
      nav: _ArtCraftChapterNav.foldAndCreate,
      title: 'Fold & Create',
      subtitle: 'Turn paper into fun creations',
      materialsCount: 5,
      backgroundColor: Color(0xFFE8E4EC),
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
                title: 'Art & Craft',
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
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          AppSearchBar(
                            hint: 'Search Art & Craft',
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

  void _onChapterTap(BuildContext context) {
    switch (data.nav) {
      case _ArtCraftChapterNav.creativeDrawing:
        context.push(AppRoutes.artCraftCreativeDrawing);
        break;
      case _ArtCraftChapterNav.colorAndCreate:
        context.push(AppRoutes.artCraftColorAndCreate);
        break;
      case _ArtCraftChapterNav.makeAScene:
        context.push(AppRoutes.artCraftMakeScene);
        break;
      case _ArtCraftChapterNav.foldAndCreate:
        context.push(AppRoutes.artCraftFoldAndCreate);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _onChapterTap(context),
        borderRadius: BorderRadius.circular(24),
        child: Ink(
          height: 140,
          decoration: BoxDecoration(
            color: data.backgroundColor,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
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
        ),
      ),
    );
  }
}

class _ChapterCardData {
  final _ArtCraftChapterNav nav;
  final String title;
  final String subtitle;
  final int materialsCount;
  final Color backgroundColor;

  const _ChapterCardData({
    required this.nav,
    required this.title,
    required this.subtitle,
    required this.materialsCount,
    required this.backgroundColor,
  });
}
