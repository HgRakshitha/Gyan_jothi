import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/router/app_router.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/utils/breakpoints.dart';
import '../../../core/utils/search_filter.dart';
import '../../quiz/pages/quiz_page.dart';
import '../../events/pages/events_page.dart';
import '../../stories/pages/stories_page.dart';
import '../../../shared/providers/user_provider.dart';
import '../../../shared/widgets/app_asset_image.dart';
import '../../../shared/widgets/search_bar.dart';
import '../../../shared/widgets/search_empty_state.dart';
import '../../../shared/widgets/top_wave_clipper.dart';
import '../widgets/quick_access_card.dart';
import '../widgets/event_card.dart';

class DashboardPage extends ConsumerStatefulWidget {
  final VoidCallback? onProfileTap;
  const DashboardPage({super.key, this.onProfileTap});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  String _searchQuery = '';

  static const List<AnnouncementItem> _announcements = [
    AnnouncementItem(
      title: 'School Holiday Notice',
      description: 'School will remain closed on Monday for a public holiday.',
      timeAgo: '30 mins ago',
      backgroundColor: AppColors.announcementBg,
    ),
    AnnouncementItem(
      title: 'New Quiz Available',
      description: 'Try the new Colors Quiz and earn badges!',
      timeAgo: '40 mins ago',
      backgroundColor: AppColors.announcementBg,
    ),
    AnnouncementItem(
      title: 'Upcoming Event',
      description: 'Annual Sports Day registration is now open!',
      timeAgo: '3 hours ago',
      backgroundColor: AppColors.announcementBg,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final topPad = MediaQuery.viewPaddingOf(context).top;
    const double headerContentHeight = 174.0;
    const double mobileSheetTopGap = 60.0;
    const double mobileSheetOverlap = 28.0;
    final isWebTopShell = Breakpoints.isWebOrDesktop(context);
    final extraTopInset = isWebTopShell ? 52.0 : 0.0;

    final maxContentW = Breakpoints.contentMaxWidth(context);

    final filteredAnnouncements = _announcements
        .where(
          (a) => matchesSearchQuery(
            _searchQuery,
            [a.title, a.description, a.timeAgo],
          ),
        )
        .toList();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final padH = Breakpoints.horizontalPadding(context);
            final isWeb = Breakpoints.isWebOrDesktop(context);
            final padB = isWeb ? Breakpoints.scrollBottomPadding(context) : 0.0;

            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height:
                            topPad +
                            headerContentHeight +
                            extraTopInset +
                            mobileSheetTopGap -
                            mobileSheetOverlap,
                        padding: const EdgeInsets.all(1),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color.fromRGBO(225, 221, 30, 0.14),
                              Color(0xFFE1DD1E),
                              Color.fromRGBO(225, 221, 30, 0.14),
                            ],
                            stops: [0.0323, 0.5014, 0.9652],
                          ),
                        ),
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFFBEDF00), // Darker lime
                                Color(0xFFF2FCAC), // Lighter lime
                              ],
                            ),
                          ),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: (maxContentW ?? double.infinity) + 48,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: topPad + 12 + extraTopInset,
                                left: padH,
                                right: padH,
                              ),
                              child: _Header(
                                name: user.name,
                                className: user.className,
                                coins: user.coins,
                                avatarPath: user.avatarPath,
                                onProfileTap: widget.onProfileTap,
                              ),
                            ),
                          ),
                        ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top:
                              topPad +
                              headerContentHeight +
                              extraTopInset -
                              mobileSheetOverlap +
                              8,
                        ),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: maxContentW ?? constraints.maxWidth,
                            ),
                            child: CustomPaint(
                              painter: const _TopWaveShadowPainter(),
                              foregroundPainter: const _TopWaveBorderPainter(),
                              child: ClipPath(
                                clipper: const TopWaveClipper(),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 90, sigmaY: 90),
                                  child: Container(
                                    width: double.infinity,
                                    color: Colors.white.withValues(alpha: 0.95),
                                    child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                    padH,
                                    isWeb ? 42 : 40,
                                    padH,
                                    padB,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppSearchBar(
                                        hint: AppStrings.searchHint,
                                        onChanged: (v) =>
                                            setState(() => _searchQuery = v),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        AppStrings.quickAccess,
                                        style: AppTextStyles.sectionHeading,
                                      ),
                                      const SizedBox(height: 12),
                                      _QuickAccessGrid(
                                        onLearnTap: () => context.push(AppRoutes.learn),
                                        onQuizTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => const QuizPage(),
                                          ),
                                        ),
                                        onEventsTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => const EventsPage(),
                                          ),
                                        ),
                                        onStoriesTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => const StoriesPage(),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 22),
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.fromLTRB(
                                            12, 14, 12, 10),
                                        decoration: BoxDecoration(
                                          color: AppColors.assignmentSectionBg,
                                          borderRadius:
                                              BorderRadius.circular(32),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              AppStrings.announcements,
                                              style:
                                                  AppTextStyles.sectionHeading,
                                            ),
                                            const SizedBox(height: 12),
                                            if (filteredAnnouncements
                                                    .isEmpty &&
                                                _searchQuery
                                                    .trim()
                                                    .isNotEmpty)
                                              const SearchEmptyState()
                                            else
                                              ...filteredAnnouncements.map(
                                                (item) => Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    bottom: 10,
                                                  ),
                                                  child:
                                                      EventCard(item: item),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
      ),
    );
  }
}

// ─── Header ──────────────────────────────────────────────────────────────────
class _Header extends StatelessWidget {
  final String name;
  final String className;
  final int coins;
  final String avatarPath;
  final VoidCallback? onProfileTap;

  const _Header({
    required this.name,
    required this.className,
    required this.coins,
    required this.avatarPath,
    this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSizes.paddingPage,
        10,
        AppSizes.paddingPage,
        8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: onProfileTap,
                child: Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.white, width: 2),
                    color: Colors.white,
                  ),
                  clipBehavior: Clip.hardEdge,
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: AppAssetImage(
                    assetPath: avatarPath.isNotEmpty ? avatarPath : AppAssets.avatarDefault,
                    width: 50,
                    height: 50,
                    fit: BoxFit.contain,
                    fallback: const Icon(Icons.person_rounded),
                  ),
                ),
              ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.headlineMedium
                      .copyWith(fontSize: 21, height: 1.2, fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(width: 8),
              _CoinBadge(coins: coins),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            className,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bodySmall.copyWith(
              color: Colors.black87,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _CoinBadge extends StatelessWidget {
  final int coins;
  const _CoinBadge({required this.coins});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.8),
              width: 1.2,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const AppAssetImage(
                assetPath: AppAssets.iconCoin,
                width: 18,
                height: 18,
                fallback: Icon(
                  Icons.monetization_on_rounded,
                  size: 18,
                ),
              ),
              const SizedBox(width: 7),
              Text(
                '$coins',
                maxLines: 1,
                style: AppTextStyles.titleSmall
                    .copyWith(fontWeight: FontWeight.w800, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Quick Access Grid ────────────────────────────────────────────────────────
class _QuickAccessGrid extends StatelessWidget {
  final VoidCallback onLearnTap;
  final VoidCallback onQuizTap;
  final VoidCallback onEventsTap;
  final VoidCallback onStoriesTap;

  const _QuickAccessGrid({
    required this.onLearnTap,
    required this.onQuizTap,
    required this.onEventsTap,
    required this.onStoriesTap,
  });

  static const double _quizEventsWidth = 167;
  static const double _quizEventsHeight = 130;
  static const double _cardRadius = 34;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: QuickAccessCard(
                data: const QuickAccessData(
                  label: 'Learn',
                  backgroundColor: Color(0xFFFDE8C2),
                  imagePath: AppAssets.illustrationLearn,
                  imageScale: 0.84,
                ),
                height: _quizEventsHeight * 2 + 10,
                onTap: onLearnTap,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                children: [
                  QuickAccessCard(
                    data: const QuickAccessData(
                      label: 'Quiz',
                      backgroundColor: Color(0xFFDFD5D9),
                      imagePath: AppAssets.illustrationQuiz,
                      imageScale: 0.98,
                    ),
                    width: double.infinity,
                    height: _quizEventsHeight,
                    borderRadius: _cardRadius,
                    border: Border.all(width: 1, color: Colors.black.withValues(alpha: 0.08)),
                    onTap: onQuizTap,
                  ),
                  const SizedBox(height: 10),
                  QuickAccessCard(
                    data: const QuickAccessData(
                      label: 'Events',
                      backgroundColor: Color(0xFFFADEDE),
                      imagePath: AppAssets.illustrationEvents,
                      imageScale: 0.90,
                    ),
                    width: double.infinity,
                    height: _quizEventsHeight,
                    borderRadius: _cardRadius,
                    border: Border.all(width: 1, color: Colors.black.withValues(alpha: 0.08)),
                    onTap: onEventsTap,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        QuickAccessCard(
          data: const QuickAccessData(
            label: 'Stories',
            backgroundColor: Color(0xFFFBE1CE),
            imagePath: AppAssets.illustrationStories,
            imageScale: 1.08,
            imageRight: 9,
            imageBottom: -1
          ),
          height: 130,
          borderRadius: _cardRadius,
          border: Border.all(width: 1, color: Colors.black.withValues(alpha: 0.08)),
          onTap: onStoriesTap,
        ),
      ],
    );
  }
}

// ─── Clippers ───────────────────────────────────────────────────────────────

class _TopWaveShadowPainter extends CustomPainter {
  const _TopWaveShadowPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final path = const TopWaveClipper().getClip(size);
    final shadowPaint = Paint()
      ..color = const Color(0x29957642)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 40);
    
    canvas.drawPath(path.shift(const Offset(0, -20)), shadowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _TopWaveBorderPainter extends CustomPainter {
  const _TopWaveBorderPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final path = const TopWaveClipper().getClip(size);
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..shader = const LinearGradient(
        colors: [
          Color.fromRGBO(225, 221, 30, 0.14),
          Color(0xFFE1DD1E),
          Color.fromRGBO(225, 221, 30, 0.14),
        ],
        stops: [0.0323, 0.5014, 0.9652],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
      
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
