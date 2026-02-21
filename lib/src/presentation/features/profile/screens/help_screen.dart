import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/theme/theme.dart';

/// Help and support screen with FAQs and contact options.
class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: AppSpacing.lg),

          // Contact options
          Padding(
            padding: AppSpacing.horizontalLg,
            child: Text(
              'Contact Us',
              style: AppTypography.titleMedium,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          _ContactCard(
            icon: Icons.email_outlined,
            title: 'Email Support',
            subtitle: 'support@rwandaconnect.com',
            onTap: () => _launchUrl('mailto:support@rwandaconnect.com'),
          ),
          _ContactCard(
            icon: Icons.chat_outlined,
            title: 'Live Chat',
            subtitle: 'Available Mon-Fri, 9AM-5PM EAT',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Live chat coming soon'),
                ),
              );
            },
          ),
          const SizedBox(height: AppSpacing.xxl),

          // FAQ Section
          Padding(
            padding: AppSpacing.horizontalLg,
            child: Text(
              'Frequently Asked Questions',
              style: AppTypography.titleMedium,
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          const _FaqItem(
            question: 'How do I apply for opportunities?',
            answer:
                'Browse opportunities in the Opportunities tab. When you find one you\'re interested in, tap "Apply" to be redirected to the application page. Note: Applying requires an active subscription.',
          ),
          const _FaqItem(
            question: 'What\'s included in the free plan?',
            answer:
                'The free plan lets you browse all opportunities, events, and community posts. To apply for opportunities, bookmark items, or access mentorship features, you\'ll need to upgrade to a paid plan or start a free trial.',
          ),
          const _FaqItem(
            question: 'How does the free trial work?',
            answer:
                'The 14-day free trial gives you full access to all premium features. No credit card is required to start. After the trial ends, you\'ll need to subscribe to continue accessing premium features.',
          ),
          const _FaqItem(
            question: 'How do I RSVP for an event?',
            answer:
                'Go to the Events tab, find an event you\'re interested in, and tap "RSVP". You can view your RSVPs from the My RSVPs section in your profile.',
          ),
          const _FaqItem(
            question: 'Can I cancel my subscription?',
            answer:
                'Yes, you can cancel your subscription at any time. Your premium access will continue until the end of your current billing period.',
          ),
          const _FaqItem(
            question: 'How do I update my profile?',
            answer:
                'Go to Profile > Edit Profile to update your name, location, and interests. Changes are saved immediately.',
          ),
          const _FaqItem(
            question: 'I forgot my password. What do I do?',
            answer:
                'On the login screen, tap "Forgot Password" and enter your email. We\'ll send you a link to reset your password. You can also request a password reset from Settings.',
          ),
          const _FaqItem(
            question: 'How do I delete my account?',
            answer:
                'To delete your account, please contact our support team at support@rwandaconnect.com. We\'ll process your request within 48 hours.',
          ),

          const SizedBox(height: AppSpacing.xxl),

          // Additional resources
          Padding(
            padding: AppSpacing.horizontalLg,
            child: Text(
              'Additional Resources',
              style: AppTypography.titleMedium,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          ListTile(
            leading: const Icon(Icons.article_outlined, color: AppColors.primary),
            title: Text('User Guide', style: AppTypography.bodyLarge),
            trailing: const Icon(Icons.open_in_new, size: AppSizes.iconSm),
            onTap: () => _launchUrl('https://rwandaconnect.com/guide'),
          ),
          ListTile(
            leading: const Icon(Icons.video_library_outlined, color: AppColors.primary),
            title: Text('Video Tutorials', style: AppTypography.bodyLarge),
            trailing: const Icon(Icons.open_in_new, size: AppSizes.iconSm),
            onTap: () => _launchUrl('https://rwandaconnect.com/tutorials'),
          ),
          ListTile(
            leading: const Icon(Icons.feedback_outlined, color: AppColors.primary),
            title: Text('Send Feedback', style: AppTypography.bodyLarge),
            trailing: const Icon(Icons.open_in_new, size: AppSizes.iconSm),
            onTap: () => _launchUrl('mailto:feedback@rwandaconnect.com'),
          ),
          const SizedBox(height: AppSpacing.xxxl),
        ],
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  const _ContactCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.horizontalLg,
      child: Card(
        child: ListTile(
          leading: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.primary),
          ),
          title: Text(title, style: AppTypography.titleSmall),
          subtitle: Text(subtitle, style: AppTypography.bodySmallSecondary),
          trailing: const Icon(Icons.arrow_forward_ios, size: AppSizes.iconSm),
          onTap: onTap,
        ),
      ),
    );
  }
}

class _FaqItem extends StatefulWidget {
  const _FaqItem({
    required this.question,
    required this.answer,
  });

  final String question;
  final String answer;

  @override
  State<_FaqItem> createState() => _FaqItemState();
}

class _FaqItemState extends State<_FaqItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            widget.question,
            style: AppTypography.bodyLarge.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: AnimatedRotation(
            turns: _isExpanded ? 0.5 : 0,
            duration: const Duration(milliseconds: 200),
            child: const Icon(Icons.keyboard_arrow_down),
          ),
          onTap: () {
            setState(() => _isExpanded = !_isExpanded);
          },
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              0,
              AppSpacing.lg,
              AppSpacing.lg,
            ),
            child: Text(
              widget.answer,
              style: AppTypography.bodyMediumSecondary,
            ),
          ),
          crossFadeState: _isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 200),
        ),
        const Divider(height: 1),
      ],
    );
  }
}
