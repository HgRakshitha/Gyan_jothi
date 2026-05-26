import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/user_provider.dart';

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

/// "Make a Scene" chapter — list of scene activities (matches Color & Create layout).
class MakeAScenePage extends ConsumerWidget {
  const MakeAScenePage({super.key});

  static const _materials = <_SceneMaterialItemData>[
    _SceneMaterialItemData(
      title: 'Create a Park',
      coinCount: 20,
      imagePath: AppAssets.artsCraftMakeScenePark,
    ),
    _SceneMaterialItemData(
      title: 'Build a Form',
      coinCount: 20,
      imagePath: AppAssets.artsCraftMakeSceneBuildForm,
    ),
    _SceneMaterialItemData(
      title: 'Make a Birthday Party',
      coinCount: 30,
      imagePath: AppAssets.artsCraftMakeSceneBirthday,
    ),
    _SceneMaterialItemData(
      title: 'Decorate a Classroom',
      coinCount: 30,
      imagePath: AppAssets.artsCraftMakeSceneClassroom,
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                title: 'Make a Scene',
                subtitle: 'Study Material',
                onBack: () => goToArtCraftHome(context),
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
                          ...List.generate(
                            _materials.length,
                            (index) => Padding(
                              padding: EdgeInsets.only(
                                bottom: index == _materials.length - 1 ? 0 : 12,
                              ),
                              child: _SceneMaterialCard(
                                data: _materials[index],
                                onTap: () async {
                                  dynamic result;
                                  if (index == 0) {
                                    result = await context.push(AppRoutes.artCraftCreateAPark);
                                  } else if (index == 1) {
                                    result = await context.push(AppRoutes.artCraftBuildAForm);
                                  } else if (index == 2) {
                                    result = await context.push(
                                      AppRoutes.artCraftMakeABirthdayParty,
                                    );
                                  } else if (index == 3) {
                                    result = await context.push(
                                      AppRoutes.artCraftDecorateAClassroom,
                                    );
                                  } else {
                                    result = await context.push(
                                      AppRoutes.artCraftSceneActivity,
                                      extra: _materials[index].title,
                                    );
                                  }
                                  if (result == true) {
                                    final success = ref.read(userProvider.notifier).completeActivity('learn_${_materials[index].title}', _materials[index].coinCount);
                                    if (success) {
                                      if (!context.mounted) return;
                                      context.push(AppRoutes.taskCompletion, extra: _materials[index].coinCount);
                                    }
                                  }
                                },
                              ),
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

class _SceneMaterialCard extends StatelessWidget {
  final _SceneMaterialItemData data;
  final VoidCallback? onTap;

  const _SceneMaterialCard({required this.data, this.onTap});

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
                    fallback: const Icon(Icons.layers_rounded, size: 28),
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
                    Row(
                      children: [
                        const TypeLabelPill(label: 'Activity'),
                        const SizedBox(width: 8),
                        const AppAssetImage(
                          assetPath: AppAssets.iconCoin,
                          width: 16,
                          height: 16, fallback: SizedBox.shrink(),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '+${data.coinCount}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber,
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

class _SceneMaterialItemData {
  final String title;
  final int coinCount;
  final String imagePath;

  const _SceneMaterialItemData({
    required this.title,
    required this.coinCount,
    required this.imagePath,
  });
}

