import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary
  static const Color primary = Color(0xFFCCE500); // Lime-yellow (app bar bg)
  static const Color primaryDark = Color(0xFFB8D000);

  // Background
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFFFFFFF);

  // Text
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF6B6B6B);
  static const Color textHint = Color(0xFFAAAAAA);

  // Quick Access Card backgrounds
  static const Color cardLearn = Color(0xFFFFF8E1);   // cream / warm yellow
  static const Color cardQuiz = Color(0xFFE5E0E7);    // soft lavender-grey
  static const Color cardEvents = Color(0xFFFFE4EC);  // light pink
  static const Color cardStories = Color(0xFFFFEBD6); // peach

  /// In-story rounded title card on all story readers (same cream as Teddy's Lost Button).
  static const Color storyTitleBackground = Color(0xFFF7F6C4);

  // Subject accent colours
  static const Color accentEnglish = Color(0xFFFFB5C8);
  static const Color accentMath = Color(0xFFB5D8FF);
  static const Color accentScience = Color(0xFFB8F0C8);
  static const Color accentArt = Color(0xFFFFD9A0);

  // Misc
  static const Color gold = Color(0xFFFFD700);
  static const Color shadow = Color(0x14000000); // rgba(0,0,0,0.08)
  static const Color divider = Color(0xFFEEEEEE);
  static const Color searchBarBg = Color(0x1FE1DD1E);
  static const Color searchBarBorder = Color(0xFFE1DD1E);
  static const Color bottomNavBg = Color(0xFFF0F4D0);

  // Announcement tints (match dashboard mock)
  static const Color announcementBgSoftYellow = Color(0xFFFBFBE4);
  static const Color announcementBgSoftGreen = Color(0xFFFBFBE4);

  // Announcement card
  static const Color announcementBg = Color(0xFFFBFBE4);

  // Dashboard spec colors
  static const Color sheetBorder = Color(0xFFE8E8DA);
  static const Color assignmentSectionBg = Color(0xFFFFFFFF);
  static const Color announcementSideBorder = Color(0xFFE2E2CF);

  // English sub pages - tab action button (play/arrow) background - light
  static const Color tabActionButtonBg = Color(0x26FFFFFF); // light white tint
}
