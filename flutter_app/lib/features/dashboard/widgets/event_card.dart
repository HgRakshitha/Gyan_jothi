import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/theme/text_styles.dart';

class AnnouncementItem {
  final String title;
  final String description;
  final String timeAgo;
  final Color? backgroundColor;

  const AnnouncementItem({
    required this.title,
    required this.description,
    required this.timeAgo,
    this.backgroundColor,
  });
}

class EventCard extends StatelessWidget {
  final AnnouncementItem item;
  final VoidCallback? onTap;

  const EventCard({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 2.5),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F6C4),
          borderRadius: BorderRadius.circular(36.5),
        ),
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: 140),
          padding: const EdgeInsets.fromLTRB(24, 22, 22, 22),
          decoration: BoxDecoration(
            color: item.backgroundColor ?? AppColors.announcementBg,
            borderRadius: BorderRadius.circular(34),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.headlineMedium.copyWith(
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      item.description,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textPrimary.withValues(alpha: 0.86),
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.55),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        item.timeAgo,
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.textPrimary.withValues(alpha: 0.85),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Icon(
                Icons.arrow_forward_rounded,
                size: 34,
                color: const Color(0xFF1C2343).withValues(alpha: 0.95),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
