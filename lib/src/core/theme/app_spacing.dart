import 'package:flutter/material.dart';

/// Spacing and radius constants for Rwanda Connect app.
/// Spacing scale: 4, 8, 12, 16, 20, 24, 32
/// Radius: 8 for cards, 12 for modals, 999 for pills
abstract final class AppSpacing {
  // Spacing scale
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;

  // Common edge insets
  static const EdgeInsets paddingXs = EdgeInsets.all(xs);
  static const EdgeInsets paddingSm = EdgeInsets.all(sm);
  static const EdgeInsets paddingMd = EdgeInsets.all(md);
  static const EdgeInsets paddingLg = EdgeInsets.all(lg);
  static const EdgeInsets paddingXl = EdgeInsets.all(xl);
  static const EdgeInsets paddingXxl = EdgeInsets.all(xxl);

  // Horizontal padding
  static const EdgeInsets horizontalSm = EdgeInsets.symmetric(horizontal: sm);
  static const EdgeInsets horizontalMd = EdgeInsets.symmetric(horizontal: md);
  static const EdgeInsets horizontalLg = EdgeInsets.symmetric(horizontal: lg);
  static const EdgeInsets horizontalXl = EdgeInsets.symmetric(horizontal: xl);

  // Vertical padding
  static const EdgeInsets verticalSm = EdgeInsets.symmetric(vertical: sm);
  static const EdgeInsets verticalMd = EdgeInsets.symmetric(vertical: md);
  static const EdgeInsets verticalLg = EdgeInsets.symmetric(vertical: lg);
  static const EdgeInsets verticalXl = EdgeInsets.symmetric(vertical: xl);

  // Screen padding (standard horizontal margin for screens)
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(horizontal: lg);
}

/// Border radius constants
abstract final class AppRadius {
  static const double card = 8;
  static const double modal = 12;
  static const double pill = 999;
  static const double button = 8;
  static const double input = 8;

  // BorderRadius instances
  static const BorderRadius cardRadius = BorderRadius.all(Radius.circular(card));
  static const BorderRadius modalRadius = BorderRadius.all(Radius.circular(modal));
  static const BorderRadius pillRadius = BorderRadius.all(Radius.circular(pill));
  static const BorderRadius buttonRadius = BorderRadius.all(Radius.circular(button));
  static const BorderRadius inputRadius = BorderRadius.all(Radius.circular(input));
}

/// Touch target sizes for accessibility
abstract final class AppSizes {
  // Minimum touch target size (44x44 as per spec)
  static const double minTouchTarget = 44;

  // Icon sizes
  static const double iconSm = 16;
  static const double iconMd = 20;
  static const double iconLg = 24;
  static const double iconXl = 32;

  // Avatar sizes
  static const double avatarSm = 32;
  static const double avatarMd = 40;
  static const double avatarLg = 56;
  static const double avatarXl = 80;

  // Button heights
  static const double buttonHeight = 48;
  static const double buttonHeightSm = 36;

  // Input field height
  static const double inputHeight = 48;

  // App bar height
  static const double appBarHeight = 56;

  // Bottom navigation height
  static const double bottomNavHeight = 64;
}
