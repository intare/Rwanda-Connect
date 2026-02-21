import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/theme.dart';
import '../../../../domain/entities/auth_state.dart';
import '../providers/auth_provider.dart';

/// Screen for email verification.
class VerifyEmailScreen extends ConsumerStatefulWidget {
  const VerifyEmailScreen({super.key, this.token});

  /// Optional token from deep link.
  final String? token;

  @override
  ConsumerState<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends ConsumerState<VerifyEmailScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _tokenController;
  bool _verificationSuccess = false;
  bool _isResending = false;

  @override
  void initState() {
    super.initState();
    _tokenController = TextEditingController(text: widget.token ?? '');

    // Auto-verify if token is provided via deep link
    if (widget.token != null && widget.token!.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _handleVerify();
      });
    }
  }

  @override
  void dispose() {
    _tokenController.dispose();
    super.dispose();
  }

  Future<void> _handleVerify() async {
    if (_formKey.currentState?.validate() ?? false) {
      final success = await ref.read(authProvider.notifier).verifyEmail(
            _tokenController.text.trim(),
          );

      if (!mounted) return;

      if (success) {
        setState(() => _verificationSuccess = true);
      }
    }
  }

  Future<void> _handleResend() async {
    if (_isResending) return;

    setState(() => _isResending = true);

    final success = await ref.read(authProvider.notifier).resendVerificationEmail();

    if (!mounted) return;

    setState(() => _isResending = false);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Verification email sent!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final user = ref.watch(currentUserProvider);
    final isLoading = authState is AuthStateLoading;

    // Listen for errors
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next is AuthStateError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.message),
            backgroundColor: AppColors.danger,
            behavior: SnackBarBehavior.floating,
          ),
        );
        ref.read(authProvider.notifier).clearError();
      }
    });

    // If user's email is now verified, redirect
    if (user?.emailVerified == true && !_verificationSuccess) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (user?.onboardingCompleted == true) {
          context.go(AppRoutes.home);
        } else {
          context.go(AppRoutes.onboarding);
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
        actions: [
          TextButton(
            onPressed: () async {
              await ref.read(authProvider.notifier).logout();
              if (context.mounted) {
                context.go(AppRoutes.login);
              }
            },
            child: const Text('Sign Out'),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screenPadding,
          child: _verificationSuccess
              ? _buildSuccessContent()
              : _buildFormContent(isLoading, user?.email),
        ),
      ),
    );
  }

  Widget _buildFormContent(bool isLoading, String? email) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppSpacing.xl),
          Icon(
            Icons.mark_email_unread_outlined,
            size: 80,
            color: AppColors.primary,
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(
            'Verify your email',
            style: AppTypography.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'We\'ve sent a verification link to:',
            style: AppTypography.bodyMediumSecondary,
            textAlign: TextAlign.center,
          ),
          if (email != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              email,
              style: AppTypography.titleMedium,
              textAlign: TextAlign.center,
            ),
          ],
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Click the link in your email or enter the verification code below.',
            style: AppTypography.bodyMediumSecondary,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xxxl),
          TextFormField(
            controller: _tokenController,
            decoration: const InputDecoration(
              labelText: 'Verification Code',
              hintText: 'Enter code from email',
              prefixIcon: Icon(Icons.verified_outlined),
            ),
            textInputAction: TextInputAction.done,
            autocorrect: false,
            enabled: !isLoading,
            onFieldSubmitted: (_) => _handleVerify(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the verification code';
              }
              return null;
            },
          ),
          const SizedBox(height: AppSpacing.xl),
          ElevatedButton(
            onPressed: isLoading ? null : _handleVerify,
            child: isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.white,
                    ),
                  )
                : const Text('Verify Email'),
          ),
          const SizedBox(height: AppSpacing.xl),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Didn\'t receive the email?',
                style: AppTypography.bodyMediumSecondary,
              ),
              TextButton(
                onPressed: (isLoading || _isResending) ? null : _handleResend,
                child: _isResending
                    ? const SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Resend'),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Check your spam folder if you don\'t see it in your inbox.',
            style: AppTypography.bodySmallSecondary,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessContent() {
    final user = ref.watch(currentUserProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: AppSpacing.xxxl),
        Icon(
          Icons.verified_outlined,
          size: 80,
          color: AppColors.accent,
        ),
        const SizedBox(height: AppSpacing.xl),
        Text(
          'Email verified!',
          style: AppTypography.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          'Your email has been successfully verified. You can now access all features.',
          style: AppTypography.bodyMediumSecondary,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.xxxl),
        ElevatedButton(
          onPressed: () {
            if (user?.onboardingCompleted == true) {
              context.go(AppRoutes.home);
            } else {
              context.go(AppRoutes.onboarding);
            }
          },
          child: const Text('Continue'),
        ),
      ],
    );
  }
}
