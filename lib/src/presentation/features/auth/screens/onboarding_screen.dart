import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/profile_constants.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/theme.dart';
import '../providers/auth_provider.dart';

/// Onboarding screen for new users to set preferences.
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final Set<String> _selectedInterests = {};
  bool _isSaving = false;

  Future<void> _handleContinue() async {
    if (_isSaving) return;

    setState(() => _isSaving = true);

    final success = await ref.read(authProvider.notifier).updateProfile(
          interests: _selectedInterests.toList(),
          onboardingCompleted: true,
        );

    if (!mounted) return;

    setState(() => _isSaving = false);

    if (success) {
      context.go(AppRoutes.home);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Failed to save preferences. Please try again.'),
          backgroundColor: AppColors.danger,
          behavior: SnackBarBehavior.floating,
        ),
      );
      ref.read(authProvider.notifier).clearError();
    }
  }

  Future<void> _handleSkip() async {
    if (_isSaving) return;

    setState(() => _isSaving = true);

    // Mark onboarding as completed even when skipping
    await ref.read(authProvider.notifier).updateProfile(
          onboardingCompleted: true,
        );

    if (!mounted) return;

    // Navigate regardless of success (best effort)
    context.go(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpacing.xxxl),
              Text(
                'Welcome to Rwanda Connect',
                style: AppTypography.displayMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Tell us about your interests to personalize your experience',
                style: AppTypography.bodyMediumSecondary,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xxxl),
              Text(
                'Select your interests',
                style: AppTypography.titleMedium,
              ),
              const SizedBox(height: AppSpacing.lg),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: availableInterests.map((interest) {
                  final isSelected = _selectedInterests.contains(interest);
                  return FilterChip(
                    label: Text(interest),
                    selected: isSelected,
                    onSelected: _isSaving
                        ? null
                        : (selected) {
                            setState(() {
                              if (selected) {
                                _selectedInterests.add(interest);
                              } else {
                                _selectedInterests.remove(interest);
                              }
                            });
                          },
                  );
                }).toList(),
              ),
              if (_selectedInterests.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.lg),
                Text(
                  '${_selectedInterests.length} selected',
                  style: AppTypography.bodySmallSecondary,
                ),
              ],
              const Spacer(),
              ElevatedButton(
                onPressed: _isSaving ? null : _handleContinue,
                child: _isSaving
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.white,
                        ),
                      )
                    : const Text('Continue'),
              ),
              const SizedBox(height: AppSpacing.md),
              TextButton(
                onPressed: _isSaving ? null : _handleSkip,
                child: const Text('Skip for now'),
              ),
              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }
}
