import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/user_provider.dart';


import '../../../../core/constants/app_assets.dart';
import '../../../../core/navigation/go_to_app_home.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/breakpoints.dart';
import '../../../../shared/widgets/app_asset_image.dart';
import '../../../../shared/widgets/quiz_header.dart';
import '../../../../shared/widgets/star_badge.dart';
import '../../../../shared/widgets/type_label_pill.dart';
import '../../../../shared/widgets/crescent_border_card.dart';

class ShapesPage extends StatelessWidget {
  const ShapesPage({super.key});

  static const _materials = <_MaterialItemData>[
    _MaterialItemData(
      title: 'Shape Names',
      typeLabel: 'Book',
      coinCount: 2,
      imagePath: AppAssets.englishLetterTrace,
      isVideo: false,
    ),
    _MaterialItemData(
      title: 'Shapes Song',
      typeLabel: 'Video',
      coinCount: 3,
      imagePath: AppAssets.englishAbcSong,
      isVideo: true,
    ),
    _MaterialItemData(
      title: 'Match the Shapes',
      typeLabel: 'Activity',
      coinCount: 1,
      imagePath: AppAssets.englishLetterTrace,
      isVideo: false,
    ),
    _MaterialItemData(
      title: 'Find the Shape',
      typeLabel: 'Activity',
      coinCount: 1,
      imagePath: AppAssets.englishLetterTrace,
      isVideo: false,
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
                title: 'Shapes',
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
                                Column(
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
                                  ],
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
                              child: _MaterialCard(data: _materials[index]),
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

class _MaterialCard extends ConsumerWidget {
  final _MaterialItemData data;
    
  const _MaterialCard({required this.data});

  
  

  
  void _awardCoins(BuildContext context, WidgetRef ref) {
    final success = ref.read(userProvider.notifier).completeActivity('learn_${data.title}', data.coinCount);
    if (success) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.stars_rounded, color: Colors.amber, size: 24),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Well Done! You earned ${data.coinCount} coins! 🪙🏆',
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: const Color(0xFF4CAF50),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _awardCoins(context, ref),
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
                  color: Colors.white.withValues(alpha: 0.7),
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
                    fallback: const Icon(Icons.hexagon_rounded, size: 28),
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
                        TypeLabelPill(label: data.typeLabel),
                        const SizedBox(width: 8),
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
                onTap: () => _awardCoins(context, ref),
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
                  child: Icon(
                    data.isVideo ? Icons.play_arrow_rounded : Icons.arrow_forward_ios_rounded,
                    size: data.isVideo ? 26 : 20,
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

class _MaterialItemData {
  final String title;
  final String typeLabel;
  final int coinCount;
  final String imagePath;
  final bool isVideo;

  const _MaterialItemData({
    required this.title,
    required this.typeLabel,
    required this.coinCount,
    required this.imagePath,
    required this.isVideo,
  });
}
