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
            'Last updated: February 23, 2026',
            style: AppTypography.bodySmallSecondary,
          ),
          const SizedBox(height: AppSpacing.xxl),

          // Independent Platform Disclaimer
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Independence Notice',
                  style: AppTypography.titleSmall.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Rwanda Connect is an independent, privately operated platform.',
                  style: AppTypography.bodySmall.copyWith(height: 1.5),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),

          _PolicySection(
            title: 'Independence and Non-Government Affiliation',
            content:
                'Rwanda Connect is an independent, privately operated platform.\n\n'
                'Rwanda Connect does not represent, is not affiliated with, and is not endorsed by '
                'the Government of Rwanda, any embassy, any consulate, or any other government entity.\n\n'
                'Rwanda Connect does not provide official government services, does not process '
                'government applications on behalf of users, and does not act as an authorized '
                'government intermediary.',
          ),

          _PolicySection(
            title: 'Government-Related Information and Source Verification',
            content:
                'Some content in the App may discuss public policies, procedures, tenders, visas, '
                'taxation, education, business registration, or other public-service topics.\n\n'
                'This information is provided for general informational purposes only and may come '
                'from third-party publishers or public sources. Users are responsible for independently '
                'verifying official requirements, deadlines, and decisions directly with official sources.\n\n'
                'Official public source examples:\n'
                '- Government of Rwanda: https://www.gov.rw\n'
                '- MINAFFET: https://www.minaffet.gov.rw\n'
                '- RDB: https://rdb.rw\n'
                '- RRA: https://www.rra.gov.rw\n'
                '- RPPA: https://www.rppa.gov.rw\n'
                '- Irembo: https://www.irembo.gov.rw\n'
                '- Rwanda Immigration: https://www.migration.gov.rw\n\n'
                'If information in the App differs from an official source, the official source takes precedence.',
          ),

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
