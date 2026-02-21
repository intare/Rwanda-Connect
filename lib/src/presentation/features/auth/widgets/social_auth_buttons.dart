import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../domain/entities/auth_state.dart';
import '../providers/auth_provider.dart';

/// Social authentication buttons for Google and Apple sign-in.
class SocialAuthButtons extends ConsumerStatefulWidget {
  const SocialAuthButtons({
    super.key,
    this.onSuccess,
  });

  /// Callback when authentication succeeds.
  final VoidCallback? onSuccess;

  @override
  ConsumerState<SocialAuthButtons> createState() => _SocialAuthButtonsState();
}

class _SocialAuthButtonsState extends ConsumerState<SocialAuthButtons> {
  bool _appleSignInAvailable = false;

  @override
  void initState() {
    super.initState();
    _checkAppleSignInAvailability();
  }

  Future<void> _checkAppleSignInAvailability() async {
    // Apple Sign-In is only available on iOS, macOS, and web
    if (Platform.isIOS || Platform.isMacOS) {
      final available =
          await ref.read(authProvider.notifier).isAppleSignInAvailable();
      if (mounted) {
        setState(() => _appleSignInAvailable = available);
      }
    }
  }

  Future<void> _handleGoogleSignIn() async {
    await ref.read(authProvider.notifier).signInWithGoogle();
  }

  Future<void> _handleAppleSignIn() async {
    await ref.read(authProvider.notifier).signInWithApple();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final isLoading = authState is AuthStateLoading;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _SocialAuthButton(
          onPressed: isLoading ? null : _handleGoogleSignIn,
          icon: _GoogleIcon(),
          label: 'Continue with Google',
          isLoading: isLoading,
        ),
        if (_appleSignInAvailable) ...[
          const SizedBox(height: AppSpacing.md),
          _SocialAuthButton(
            onPressed: isLoading ? null : _handleAppleSignIn,
            icon: const Icon(Icons.apple, size: 24),
            label: 'Continue with Apple',
            isLoading: isLoading,
            isDark: true,
          ),
        ],
      ],
    );
  }
}

/// Individual social auth button.
class _SocialAuthButton extends StatelessWidget {
  const _SocialAuthButton({
    required this.onPressed,
    required this.icon,
    required this.label,
    this.isLoading = false,
    this.isDark = false,
  });

  final VoidCallback? onPressed;
  final Widget icon;
  final String label;
  final bool isLoading;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: isDark ? AppColors.primary : AppColors.white,
          foregroundColor: isDark ? AppColors.white : AppColors.primaryText,
          side: BorderSide(
            color: isDark ? AppColors.primary : AppColors.border,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.button),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: isDark ? AppColors.white : AppColors.primary,
                ),
              )
            else ...[
              icon,
              const SizedBox(width: AppSpacing.sm),
              Text(
                label,
                style: AppTypography.labelLarge.copyWith(
                  color: isDark ? AppColors.white : AppColors.primaryText,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Google "G" logo icon.
class _GoogleIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: CustomPaint(
        painter: _GoogleLogoPainter(),
      ),
    );
  }
}

/// Custom painter for Google logo.
class _GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Scale to fit the size
    final scale = size.width / 24;
    canvas.scale(scale);

    // Blue
    paint.color = const Color(0xFF4285F4);
    canvas.drawPath(
      Path()
        ..moveTo(21.35, 11.1)
        ..cubicTo(21.35, 10.37, 21.28, 9.67, 21.17, 9)
        ..lineTo(12, 9)
        ..lineTo(12, 13)
        ..lineTo(17.26, 13)
        ..cubicTo(17.05, 14.33, 16.34, 15.45, 15.24, 16.19)
        ..lineTo(15.24, 18.67)
        ..lineTo(18.42, 18.67)
        ..cubicTo(20.28, 16.96, 21.35, 14.32, 21.35, 11.1)
        ..close(),
      paint,
    );

    // Green
    paint.color = const Color(0xFF34A853);
    canvas.drawPath(
      Path()
        ..moveTo(12, 22)
        ..cubicTo(14.97, 22, 17.46, 21.02, 18.42, 18.67)
        ..lineTo(15.24, 16.19)
        ..cubicTo(14.33, 16.82, 13.25, 17.2, 12, 17.2)
        ..cubicTo(9.16, 17.2, 6.74, 15.33, 5.87, 12.76)
        ..lineTo(2.62, 12.76)
        ..lineTo(2.62, 15.32)
        ..cubicTo(4.28, 19.25, 7.81, 22, 12, 22)
        ..close(),
      paint,
    );

    // Yellow
    paint.color = const Color(0xFFFBBC05);
    canvas.drawPath(
      Path()
        ..moveTo(5.87, 12.76)
        ..cubicTo(5.69, 12.13, 5.59, 11.47, 5.59, 10.79)
        ..cubicTo(5.59, 10.11, 5.69, 9.45, 5.87, 8.82)
        ..lineTo(5.87, 6.26)
        ..lineTo(2.62, 6.26)
        ..cubicTo(1.95, 7.59, 1.58, 9.09, 1.58, 10.79)
        ..cubicTo(1.58, 12.49, 1.95, 13.99, 2.62, 15.32)
        ..lineTo(5.87, 12.76)
        ..close(),
      paint,
    );

    // Red
    paint.color = const Color(0xFFEA4335);
    canvas.drawPath(
      Path()
        ..moveTo(12, 4.38)
        ..cubicTo(13.39, 4.38, 14.65, 4.88, 15.64, 5.85)
        ..lineTo(18.47, 3.02)
        ..cubicTo(16.62, 1.27, 14.21, 0.21, 12, 0.21)
        ..cubicTo(7.81, 0.21, 4.28, 2.96, 2.62, 6.89)
        ..lineTo(5.87, 9.45)
        ..cubicTo(6.74, 6.88, 9.16, 5.01, 12, 5.01)
        ..lineTo(12, 4.38)
        ..close(),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Divider with "or" text for separating social auth from email auth.
class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(color: AppColors.border),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Text(
            'or',
            style: AppTypography.bodySmallSecondary,
          ),
        ),
        Expanded(
          child: Divider(color: AppColors.border),
        ),
      ],
    );
  }
}
