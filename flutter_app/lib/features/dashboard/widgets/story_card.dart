import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/theme/text_styles.dart';

class StoryCard extends StatelessWidget {
  final String title;
  final String? imagePath;
  final VoidCallback? onTap;

  const StoryCard({
    super.key,
    required this.title,
    this.imagePath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: imagePath != null
                  ? Image.asset(imagePath!,
                      width: 56, height: 56, fit: BoxFit.cover)
                  : Container(
                      width: 56,
                      height: 56,
                      color: AppColors.cardStories,
                      child: const Icon(Icons.auto_stories_rounded,
                          color: AppColors.textSecondary)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(title,
                  style: AppTextStyles.titleSmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis),
            ),
            const Icon(Icons.play_circle_fill_rounded,
                color: AppColors.primary, size: 32),
          ],
        ),
      ),
    );
  }
}
