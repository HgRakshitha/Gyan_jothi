import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/navigation/go_to_app_home.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/breakpoints.dart';
import '../../../../shared/widgets/app_asset_image.dart';
import '../../../../shared/widgets/quiz_header.dart';
import '../../../../shared/widgets/star_badge.dart';
import '../../../../shared/widgets/type_label_pill.dart';
import '../../../../shared/widgets/crescent_border_card.dart';
/// "Color & Create" chapter — list of coloring activities (matches design mockup).
class ColorAndCreatePage extends StatelessWidget {
  const ColorAndCreatePage({super.key});

  static const _materials = <_ColorMaterialItemData>[
    _ColorMaterialItemData(
      title: 'Color the Tree',
      coinCount: 2,
      imagePath: AppAssets.artsCraftColorTree,
    ),
    _ColorMaterialItemData(
      title: 'Color the Animal',
      coinCount: 2,
      imagePath: AppAssets.artsCraftColorAnimalThumb,
    ),
    _ColorMaterialItemData(
      title: 'Color My Home',
      coinCount: 3,
      imagePath: AppAssets.artsCraftColorHome,
    ),
    _ColorMaterialItemData(
      title: 'Color the Big Balloon',
      coinCount: 3,
      imagePath: AppAssets.artsCraftColorBig,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final maxContentW = Breakpoints.contentMaxWidth(context);
    final padH = Breakpoints.horizontalPadding(context);
    final padB = Breakpoints.scrollBottomPadding(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              QuizHeader(
                title: 'Color & Create',
                subtitle: 'Study Material',
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
                          Center(
                            child: Column(
                              children: [
                                Text(
                                  'Complete the chapter and',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'earn a star badge!',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                const StarBadge(size: 80),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              final double cardWidth = constraints.maxWidth > 600
                                  ? (constraints.maxWidth - 24) / 2
                                  : constraints.maxWidth;
                              return Wrap(
                                spacing: 24,
                                runSpacing: 16,
                                children: List.generate(
                                  _materials.length,
                                  (index) => SizedBox(
                                    width: cardWidth,
                                    child: _ColorMaterialCard(
                                      data: _materials[index],
                                      onTap: () {
                                        if (index == 0) {
                                          context.push(AppRoutes.artCraftColorTheTree);
                                        } else if (index == 1) {
                                          context.push(AppRoutes.artCraftColorTheAnimal);
                                        } else if (index == 2) {
                                          context.push(AppRoutes.artCraftColorMyHome);
                                        } else if (index == 3) {
                                          context.push(AppRoutes.artCraftColorTheBigBalloon);
                                        } else {
                                          context.push(
                                            AppRoutes.artCraftColorActivity,
                                            extra: _materials[index].title,
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
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

class _ColorMaterialCard extends StatelessWidget {
  final _ColorMaterialItemData data;
  final VoidCallback? onTap;

  const _ColorMaterialCard({required this.data, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: CrescentBorderCard(
          borderRadius: 24,
          padding: const EdgeInsets.fromLTRB(16, 14, 14, 14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
          child: Row(
            children: [
              Container(
                width: AppSizes.studyMaterialThumbnailSize,
                height: AppSizes.studyMaterialThumbnailSize,
                decoration: BoxDecoration(
                  color: AppColors.tabActionButtonBg,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: AppAssetImage(
                    assetPath: data.imagePath,
                    width: AppSizes.studyMaterialThumbnailSize,
                    height: AppSizes.studyMaterialThumbnailSize,
                    fit: BoxFit.cover,
                    fallback: const Icon(Icons.palette_rounded, size: 28),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title,
                      style: AppTextStyles.titleMedium.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: AppSizes.studyMaterialTitleFontSize,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const TypeLabelPill(label: 'Activity'),
                        const SizedBox(width: 4),
                        ...List.generate(
                          data.coinCount,
                          (_) => const Padding(
                            padding: EdgeInsets.only(right: 2),
                            child: AppAssetImage(
                              assetPath: AppAssets.iconCoin,
                              width: 16,
                              height: 16,
                              fallback: Icon(
                                Icons.monetization_on_rounded,
                                size: 16,
                                color: Colors.amber,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: onTap ?? () {},
                child: Container(
                  width: AppSizes.studyMaterialActionButtonSize,
                  height: AppSizes.studyMaterialActionButtonSize,
                  decoration: BoxDecoration(
                    color: AppColors.tabActionButtonBg,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 20,
                    fill: 0,
                    color: Colors.black87,
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

class _ColorMaterialItemData {
  final String title;
  final int coinCount;
  final String imagePath;

  const _ColorMaterialItemData({
    required this.title,
    required this.coinCount,
    required this.imagePath,
  });
}
