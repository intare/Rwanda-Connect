import 'package:flutter/material.dart';
import '../theme/theme.dart';

/// Splash screen shown while checking authentication status.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App logo/icon
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.connect_without_contact,
                size: 60,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
            Text(
              'Rwanda Connect',
              style: AppTypography.displayMedium.copyWith(
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: AppSpacing.xxxl),
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
