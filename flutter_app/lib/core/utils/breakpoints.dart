import 'package:flutter/material.dart';

/// Responsive breakpoints: mobile-first layout on narrow screens,
/// website-style layout on wide screens (web/tablet/desktop).
class Breakpoints {
  Breakpoints._();

  /// Width below which we use mobile layout (single column, bottom nav).
  static const double mobileBreakpoint = 600;

  /// Width below which we use tablet layout (optional; currently same as web).
  static const double tabletBreakpoint = 900;

  /// Max content width for website-style layout on large screens.
  static const double webContentMaxWidth = 1000;

  /// Horizontal padding for content on web (sides of centered column).
  static const double webPaddingHorizontal = 24;

  /// True when screen is narrow (phone or narrow browser) → mobile layout.
  static bool isMobile(BuildContext context) {
    return MediaQuery.sizeOf(context).width < mobileBreakpoint;
  }

  /// True when screen is wide (web/tablet/desktop) → website layout.
  static bool isWebOrDesktop(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= mobileBreakpoint;
  }

  /// Max width for main content: null on mobile (full width), [webContentMaxWidth] on web.
  static double? contentMaxWidth(BuildContext context) {
    if (isMobile(context)) return null;
    return webContentMaxWidth;
  }

  /// Horizontal padding for the main content area.
  static double horizontalPadding(BuildContext context) {
    if (isMobile(context)) return 16;
    return webPaddingHorizontal;
  }

  /// Bottom padding for scroll content (space above bottom nav on mobile).
  static double scrollBottomPadding(BuildContext context) {
    return isMobile(context) ? 24 : 40;
  }
}
