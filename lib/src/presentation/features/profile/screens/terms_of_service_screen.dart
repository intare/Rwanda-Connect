import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/theme/theme.dart';

/// Terms of Service screen displaying terms and conditions.
class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  Future<void> _launchFullTerms() async {
    final uri = Uri.parse('https://rwandaconnect.com/terms');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms of Service'),
        actions: [
          IconButton(
            icon: const Icon(Icons.open_in_new),
            onPressed: _launchFullTerms,
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

          // Important Disclaimer Banner
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.warning.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.warning.withValues(alpha: 0.3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: AppColors.warning,
                      size: AppSizes.iconMd,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      'Important Notice',
                      style: AppTypography.titleSmall.copyWith(
                        color: AppColors.warning,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'Rwanda Connect is an independent, privately operated platform. '
                  'It does not represent, and is not affiliated with or endorsed by, '
                  'any government entity, embassy, or consulate.',
                  style: AppTypography.bodySmall.copyWith(height: 1.5),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),

          _TermsSection(
            title: 'Acceptance of Terms',
            content:
                'By accessing or using Rwanda Connect, you agree to be bound by these Terms of Service. '
                'If you do not agree to these terms, please do not use our services.',
          ),

          _TermsSection(
            title: 'About Our Platform',
            content:
                'Rwanda Connect is an independent community platform designed to serve the Rwandan diaspora. '
                'We provide:\n\n'
                '- Curated news and articles from third-party sources\n'
                '- Job and investment opportunity listings from external providers\n'
                '- Community discussion forums\n'
                '- Event listings and discovery\n'
                '- Educational resources and guides\n\n'
                'All content is aggregated from publicly available sources or submitted by third-party '
                'providers. We do not create, verify, or endorse any government-related information.',
          ),

          _TermsSection(
            title: 'No Government Affiliation',
            content:
                'Rwanda Connect does not represent, is not affiliated with, and is not endorsed by '
                'the Government of Rwanda, any embassy, any consulate, or any other government entity.\n\n'
                'Rwanda Connect does not provide official government services, does not process '
                'government applications on behalf of users, and does not act as an authorized '
                'government intermediary.',
          ),

          _TermsSection(
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

          _TermsSection(
            title: 'Third-Party Content',
            content:
                'Our platform aggregates content from various third-party sources including:\n\n'
                '- News outlets and media organizations\n'
                '- Job boards and recruitment platforms\n'
                '- Event organizers and community groups\n'
                '- User-submitted content\n\n'
                'We do not guarantee the accuracy, completeness, or reliability of any third-party content. '
                'Users are responsible for verifying information before making decisions based on it.',
          ),

          _TermsSection(
            title: 'User Responsibilities',
            content:
                'By using Rwanda Connect, you agree to:\n\n'
                '- Verify all information independently before acting on it\n'
                '- Not rely solely on our platform for official government information\n'
                '- Contact relevant authorities directly for official services\n'
                '- Use the platform in compliance with all applicable laws\n'
                '- Not submit false, misleading, or harmful content\n'
                '- Respect other community members',
          ),

          _TermsSection(
            title: 'Disclaimer of Warranties',
            content:
                'Rwanda Connect is provided "as is" without warranties of any kind. We do not warrant that:\n\n'
                '- Information is accurate, complete, or current\n'
                '- The service will be uninterrupted or error-free\n'
                '- Opportunities listed are legitimate or available\n'
                '- Third-party content is reliable\n\n'
                'Users assume all risks associated with using information from this platform.',
          ),

          _TermsSection(
            title: 'Limitation of Liability',
            content:
                'Rwanda Connect shall not be liable for any damages arising from:\n\n'
                '- Use of or reliance on information from our platform\n'
                '- Actions taken based on third-party content\n'
                '- Interactions with other users or third parties\n'
                '- Any errors or omissions in content\n\n'
                'This includes but is not limited to financial losses, missed opportunities, '
                'or any other direct or indirect damages.',
          ),

          _TermsSection(
            title: 'Intellectual Property',
            content:
                'The Rwanda Connect name, logo, and original content are owned by Rwanda Connect. '
                'Third-party content remains the property of its respective owners. Users may not '
                'reproduce, distribute, or create derivative works without permission.',
          ),

          _TermsSection(
            title: 'Changes to Terms',
            content:
                'We may update these Terms of Service at any time. Continued use of the platform '
                'after changes constitutes acceptance of the new terms. We encourage users to '
                'review these terms periodically.',
          ),

          _TermsSection(
            title: 'Contact Us',
            content:
                'If you have questions about these Terms of Service, please contact us at:\n\n'
                'Email: legal@rwandaconnect.com\n'
                'Support: support@rwandaconnect.com',
          ),

          const SizedBox(height: AppSpacing.xxl),

          // Full terms link
          Center(
            child: TextButton.icon(
              onPressed: _launchFullTerms,
              icon: const Icon(Icons.open_in_new),
              label: const Text('View Full Terms Online'),
            ),
          ),
          const SizedBox(height: AppSpacing.xxxl),
        ],
      ),
    );
  }
}

class _TermsSection extends StatelessWidget {
  const _TermsSection({
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
