import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Typography styles for Rwanda Connect app.
/// Primary font: Sora (fallback: Poppins, Roboto)
/// Scale: 12, 14, 16 (base), 18, 20, 24, 32
abstract final class AppTypography {
  static TextStyle get _baseTextStyle => GoogleFonts.sora(
        color: AppColors.primaryText,
      );

  // Display styles
  static TextStyle get displayLarge => _baseTextStyle.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 1.25,
      );

  static TextStyle get displayMedium => _baseTextStyle.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        height: 1.33,
      );

  static TextStyle get displaySmall => _baseTextStyle.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.4,
      );

  // Headline styles
  static TextStyle get headlineLarge => _baseTextStyle.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 1.33,
      );

  static TextStyle get headlineMedium => _baseTextStyle.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.4,
      );

  static TextStyle get headlineSmall => _baseTextStyle.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.44,
      );

  // Title styles
  static TextStyle get titleLarge => _baseTextStyle.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.44,
      );

  static TextStyle get titleMedium => _baseTextStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.5,
      );

  static TextStyle get titleSmall => _baseTextStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.43,
      );

  // Body styles
  static TextStyle get bodyLarge => _baseTextStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
      );

  static TextStyle get bodyMedium => _baseTextStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.43,
      );

  static TextStyle get bodySmall => _baseTextStyle.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.33,
      );

  // Label styles
  static TextStyle get labelLarge => _baseTextStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.43,
      );

  static TextStyle get labelMedium => _baseTextStyle.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.33,
      );

  static TextStyle get labelSmall => _baseTextStyle.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.33,
      );

  // Secondary text variants
  static TextStyle get bodyLargeSecondary => bodyLarge.copyWith(
        color: AppColors.secondaryText,
      );

  static TextStyle get bodyMediumSecondary => bodyMedium.copyWith(
        color: AppColors.secondaryText,
      );

  static TextStyle get bodySmallSecondary => bodySmall.copyWith(
        color: AppColors.secondaryText,
      );
}
