import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/theme.dart';

/// Onboarding screen for new users to set preferences.
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

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
                children: [
                  _InterestChip(label: 'Technology'),
                  _InterestChip(label: 'Investment'),
                  _InterestChip(label: 'Business'),
                  _InterestChip(label: 'Education'),
                  _InterestChip(label: 'Healthcare'),
                  _InterestChip(label: 'Agriculture'),
                  _InterestChip(label: 'Real Estate'),
                  _InterestChip(label: 'Networking'),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => context.go(AppRoutes.home),
                child: const Text('Continue'),
              ),
              const SizedBox(height: AppSpacing.md),
              TextButton(
                onPressed: () => context.go(AppRoutes.home),
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

class _InterestChip extends StatefulWidget {
  const _InterestChip({required this.label});

  final String label;

  @override
  State<_InterestChip> createState() => _InterestChipState();
}

class _InterestChipState extends State<_InterestChip> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.label),
      selected: _selected,
      onSelected: (selected) => setState(() => _selected = selected),
    );
  }
}
