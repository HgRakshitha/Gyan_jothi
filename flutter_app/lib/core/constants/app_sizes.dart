import 'package:flutter/material.dart';

class AppSizes {
  AppSizes._();

  // Padding
  static const double paddingPage = 16.0;
  static const double paddingSection = 12.0;
  static const double paddingCard = 14.0;
  static const double paddingSmall = 8.0;
  static const double paddingXSmall = 4.0;

  // Gap between items
  static const double gapSmall = 8.0;
  static const double gapMedium = 12.0;
  static const double gapLarge = 16.0;

  // Border radius
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 16.0;
  static const double radiusLarge = 24.0;
  static const double radiusPill = 50.0;

  // Lime yellow top header (QuizHeader) — use everywhere for consistent height.
  static const double yellowHeaderHeight = 200.0;

  /// Scroll padding below yellow tab on story reader pages (before title card).
  static const double storyReaderTopPadding = 14.0;

  /// Learn — chapter material list row title (aligned across English/Math/Science/Art).
  static const double studyMaterialTitleFontSize = 16.0;

  /// Optional line under title (e.g. Listen & Repeat / Colors).
  static const double studyMaterialDescriptionFontSize = 13.0;

  /// Video / Book / Activity pill — use with [TypeLabelPill] only.
  static const double studyMaterialTypePillFontSize = 13.0;
  static const double studyMaterialTypePillBorderRadius = 16.0;
  static const EdgeInsets studyMaterialTypePillPadding =
      EdgeInsets.symmetric(horizontal: 10, vertical: 5);

  static const double studyMaterialThumbnailSize = 56.0;
  static const double studyMaterialActionButtonSize = 50.0;
  static const double studyMaterialCoinIconSize = 16.0;

  // Component heights
  static const double bottomNavHeight = 64.0;
  static const double searchBarHeight = 48.0;
  static const double quickAccessCardHeight = 110.0;
  static const double quickAccessCardHeightWide = 100.0;

  // Avatar
  static const double avatarSize = 40.0;
  static const double avatarSizeLarge = 56.0;
}
