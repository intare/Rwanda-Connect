import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/theme/theme.dart';

/// Privacy Policy screen displaying privacy information.
class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  Future<void> _launchFullPolicy() async {
    final uri = Uri.parse('https://rwandaconnect.com/privacy');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        actions: [
          IconButton(
            icon: const Icon(Icons.open_in_new),
            onPressed: _launchFullPolicy,
            tooltip: 'Open in browser',
          ),
        ],
      ),
      body: ListView(
        padding: AppSpacing.screenPadding,
        children: [
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Last updated: January 2024',
            style: AppTypography.bodySmallSecondary,
          ),
          const SizedBox(height: AppSpacing.xxl),

          _PolicySection(
            title: 'Information We Collect',
            content:
                'We collect information you provide directly to us, such as when you create an account, '
                'update your profile, apply for opportunities, RSVP to events, or contact us for support.\n\n'
                'This includes:\n'
                '- Name and email address\n'
                '- Location and interests\n'
                '- Profile information\n'
                '- Usage data and preferences',
          ),

          _PolicySection(
            title: 'How We Use Your Information',
            content:
                'We use the information we collect to:\n\n'
                '- Provide, maintain, and improve our services\n'
                '- Personalize your experience and show relevant opportunities\n'
                '- Send you notifications about opportunities, events, and updates\n'
                '- Process your subscriptions and payments\n'
                '- Respond to your comments, questions, and requests\n'
                '- Detect and prevent fraud and abuse',
          ),

          _PolicySection(
            title: 'Information Sharing',
            content:
                'We do not sell your personal information. We may share your information in the following circumstances:\n\n'
                '- With your consent or at your direction\n'
                '- With service providers who assist in our operations\n'
                '- When required by law or to protect our rights\n'
                '- In connection with a business transfer or merger',
          ),

          _PolicySection(
            title: 'Data Security',
            content:
                'We take reasonable measures to help protect your personal information from loss, theft, misuse, '
                'and unauthorized access. We use encryption, secure servers, and regular security audits to '
                'keep your data safe.',
          ),

          _PolicySection(
            title: 'Your Rights',
            content:
                'You have the right to:\n\n'
                '- Access your personal information\n'
                '- Update or correct your information\n'
                '- Delete your account and data\n'
                '- Opt out of marketing communications\n'
                '- Request a copy of your data\n\n'
                'Contact us at privacy@rwandaconnect.com to exercise these rights.',
          ),

          _PolicySection(
            title: 'Cookies and Tracking',
            content:
                'We use cookies and similar technologies to remember your preferences, '
                'analyze usage patterns, and improve our services. You can control cookie '
                'settings through your browser preferences.',
          ),

          _PolicySection(
            title: 'Children\'s Privacy',
            content:
                'Rwanda Connect is not intended for children under 16 years of age. We do not '
                'knowingly collect personal information from children. If you believe we have '
                'collected information from a child, please contact us.',
          ),

          _PolicySection(
            title: 'Changes to This Policy',
            content:
                'We may update this Privacy Policy from time to time. We will notify you of any '
                'significant changes by posting the new policy on this page and updating the '
                '"Last updated" date.',
          ),

          _PolicySection(
            title: 'Contact Us',
            content:
                'If you have any questions about this Privacy Policy, please contact us at:\n\n'
                'Email: privacy@rwandaconnect.com\n'
                'Address: Kigali, Rwanda',
          ),

          const SizedBox(height: AppSpacing.xxl),

          // Full policy link
          Center(
            child: TextButton.icon(
              onPressed: _launchFullPolicy,
              icon: const Icon(Icons.open_in_new),
              label: const Text('View Full Policy Online'),
            ),
          ),
          const SizedBox(height: AppSpacing.xxxl),
        ],
      ),
    );
  }
}

class _PolicySection extends StatelessWidget {
  const _PolicySection({
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTypography.titleSmall,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            content,
            style: AppTypography.bodyMedium.copyWith(
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
