import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/utils/breakpoints.dart';
import '../../../shared/providers/user_provider.dart';
import '../../../shared/widgets/app_asset_image.dart';
import '../../../shared/widgets/top_wave_clipper.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final topPad = MediaQuery.viewPaddingOf(context).top;
    final maxContentW = Breakpoints.contentMaxWidth(context);
    final padH = Breakpoints.horizontalPadding(context);
    final isMobile = Breakpoints.isMobile(context);
    final padB = isMobile ? 0.0 : Breakpoints.scrollBottomPadding(context);
    final extraTopInset = isMobile ? 0.0 : 52.0;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: topPad + 320 + extraTopInset,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.primary,
                          Color(0xFFDFF06A),
                        ],
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: maxContentW ?? double.infinity,
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                            padH,
                            topPad + 28 + extraTopInset,
                            padH,
                            0,
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: 92,
                                height: 92,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.18),
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 1.4),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x14000000),
                                      blurRadius: 16,
                                      offset: Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: AppAssetImage(
                                    assetPath: user.avatarPath.isNotEmpty ? user.avatarPath : AppAssets.avatarDefault,
                                    width: 84,
                                    height: 84,
                                    fit: BoxFit.contain,
                                    fallback: const Icon(Icons.person_rounded, size: 42),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 18),
                              Text(
                                user.name,
                                style: AppTextStyles.headlineLarge.copyWith(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                user.className,
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: Colors.black87,
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 18),
                              _CoinPill(coins: user.coins),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: topPad + 250 + extraTopInset),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: maxContentW ?? double.infinity,
                        ),
                        child: ClipPath(
                          clipper: const TopWaveClipper(),
                          child: Container(
                            width: double.infinity,
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(padH, 34, padH, padB),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const _SectionHeader(
                                      title: 'My Badges',
                                      action: 'View All',
                                    ),
                                    const SizedBox(height: 14),
                                    const Row(
                                      children: [
                                        Expanded(
                                          child: _BadgeCard(
                                            title: 'Star Learner',
                                            assetPath: AppAssets.profileBadgeStar,
                                            backgroundColor: Color(0xFFFFE0E7),
                                          ),
                                        ),
                                        SizedBox(width: 14),
                                        Expanded(
                                          child: _BadgeCard(
                                            title: 'Quiz Master',
                                            assetPath: AppAssets.profileBadgePrize,
                                            backgroundColor: Color(0xFFE7E0E5),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 22),
                                    const _SectionHeader(title: 'Learning Stats'),
                                    const SizedBox(height: 14),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: _StatCard(
                                            value: '${user.completedActivities.where((a) => a.startsWith('learn_')).length}',
                                            title: 'Lessons\nCompleted',
                                            assetPath: AppAssets.profileStatLessons,
                                            backgroundColor: const Color(0xFFDCE6FF),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: _StatCard(
                                            value: '${user.completedActivities.where((a) => a.startsWith('quiz_')).length}',
                                            title: 'Quizzes\nTaken',
                                            assetPath: AppAssets.profileStatQuizzes,
                                            backgroundColor: const Color(0xFFFFE8BF),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        const Expanded(
                                          child: _StatCard(
                                            value: '92%',
                                            title: 'Average\nScore',
                                            assetPath: AppAssets.profileStatScore,
                                            backgroundColor: Color(0xFFF1D7FF),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        const Expanded(
                                          child: _StatCard(
                                            value: '18',
                                            title: 'Day\nStreak',
                                            assetPath: AppAssets.profileStatStreak,
                                            backgroundColor: Color(0xFFFFE0CC),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
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
        ),
      ),
    );
  }
}

class _CoinPill extends StatelessWidget {
  final int coins;

  const _CoinPill({required this.coins});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.30),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white, width: 1.2),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 14,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const AppAssetImage(
            assetPath: AppAssets.iconCoin,
            width: 16,
            height: 16,
            fallback: Icon(Icons.monetization_on_rounded, size: 16),
          ),
          const SizedBox(width: 8),
          Text(
            '$coins',
            style: AppTextStyles.titleSmall.copyWith(
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String? action;

  const _SectionHeader({required this.title, this.action});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyles.titleMedium.copyWith(
            fontWeight: FontWeight.w800,
            fontSize: 16,
          ),
        ),
        if (action != null)
          Text(
            action!,
            style: AppTextStyles.bodySmall.copyWith(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
      ],
    );
  }
}

class _BadgeCard extends StatelessWidget {
  final String title;
  final String assetPath;
  final Color backgroundColor;

  const _BadgeCard({
    required this.title,
    required this.assetPath,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 146,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppAssetImage(
            assetPath: assetPath,
            width: 72,
            height: 72,
            fallback: const Icon(Icons.star_rounded, size: 52),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: AppTextStyles.titleSmall.copyWith(
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String title;
  final String assetPath;
  final Color backgroundColor;

  const _StatCard({
    required this.value,
    required this.title,
    required this.assetPath,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 172,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.fromLTRB(8, 14, 8, 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AppAssetImage(
            assetPath: assetPath,
            width: 48,
            height: 48,
            fallback: const Icon(Icons.star_rounded, size: 36),
          ),
          Text(
            value,
            style: AppTextStyles.headlineLarge.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall.copyWith(
              color: Colors.black87,
              height: 1.15,
              fontWeight: FontWeight.w700,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

