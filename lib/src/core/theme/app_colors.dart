import 'package:flutter/material.dart';

/// Color tokens for Rwanda Connect app.
/// Based on DESIGN_SPEC.md - Clean, high-contrast light theme with black accents.
abstract final class AppColors {
  // Primary colors
  static const Color primary = Color(0xFF0B0B0B);
  static const Color primaryText = Color(0xFF111111);
  static const Color secondaryText = Color(0xFF5A5A5A);

  // Background and surface
  static const Color background = Color(0xFFF7F7F7);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color border = Color(0xFFE0E0E0);

  // Semantic colors
  static const Color success = Color(0xFF14804A);
  static const Color warning = Color(0xFFB54708);
  static const Color danger = Color(0xFFB42318);
  static const Color accent = Color(0xFF1D4ED8);
  static const Color info = Color(0xFF0891B2);

  // Shimmer loading colors
  static const Color shimmerBase = Color(0xFFE0E0E0);
  static const Color shimmerHighlight = Color(0xFFF5F5F5);

  // Additional utility colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Colors.transparent;

  // Disabled state (40% opacity as per spec)
  static Color get disabled => primary.withValues(alpha: 0.4);
}
