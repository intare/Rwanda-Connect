import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/theme/theme.dart';

/// About screen showing app information.
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  static const _officialSources = <Map<String, String>>[
    {'name': 'Government of Rwanda', 'url': 'https://www.gov.rw'},
    {'name': 'MINAFFET', 'url': 'https://www.minaffet.gov.rw'},
    {'name': 'RDB', 'url': 'https://rdb.rw'},
    {'name': 'RRA', 'url': 'https://www.rra.gov.rw'},
    {'name': 'RPPA', 'url': 'https://www.rppa.gov.rw'},
    {'name': 'Irembo', 'url': 'https://www.irembo.gov.rw'},
    {'name': 'Immigration', 'url': 'https://www.migration.gov.rw'},
  ];

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
        title: const Text('About'),
      ),
      body: ListView(
        padding: AppSpacing.screenPadding,
        children: [
          const SizedBox(height: AppSpacing.xxl),

          // App logo and name
          Center(
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(
                    Icons.public,
                    size: 56,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  'Rwanda Connect',
                  style: AppTypography.headlineMedium,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Version 1.0.0',
                  style: AppTypography.bodyMediumSecondary,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xxxl),

          // Description
          Text(
            'A community platform by The New Times, connecting the Rwandan diaspora to opportunities, news, and each other.',
            style: AppTypography.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xxl),

          // Disclaimer Card
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
                      'Important Disclaimer',
                      style: AppTypography.titleSmall.copyWith(
                        color: AppColors.warning,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'Rwanda Connect is a product of The New Times. '
                  'We are NOT affiliated with, endorsed by, or connected to any government entity, '
                  'embassy, or official institution.',
                  style: AppTypography.bodySmall.copyWith(height: 1.5),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'All information, news, and opportunities shared on this platform are aggregated '
                  'from publicly available third-party sources. Users should independently verify '
                  'any official information directly with the relevant authorities before taking action.',
                  style: AppTypography.bodySmall.copyWith(height: 1.5),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xxxl),

          // Links
          const Divider(),
          _AboutLink(
            icon: Icons.language,
            title: 'Visit Website',
            onTap: () => _launchUrl('https://rwandaconnect.com'),
          ),
          _AboutLink(
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy Policy',
            onTap: () => _launchUrl('https://rwandaconnect.com/privacy'),
          ),
          _AboutLink(
            icon: Icons.description_outlined,
            title: 'Terms of Service',
            onTap: () => _launchUrl('https://rwandaconnect.com/terms'),
          ),
          _AboutLink(
            icon: Icons.email_outlined,
            title: 'Contact Us',
            subtitle: 'support@rwandaconnect.com',
            onTap: () => _launchUrl('mailto:support@rwandaconnect.com'),
          ),
          _AboutLink(
            icon: Icons.edit_outlined,
            title: 'Editorial',
            subtitle: 'editor@newtimesrwanda.com',
            onTap: () => _launchUrl('mailto:editor@newtimesrwanda.com'),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Official Sources',
            style: AppTypography.titleSmall,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'For government-related information, verify directly with official websites:',
            style: AppTypography.bodySmallSecondary,
          ),
          const SizedBox(height: AppSpacing.sm),
          ..._officialSources.map(
            (source) => _AboutLink(
              icon: Icons.verified_outlined,
              title: source['name']!,
              subtitle: source['url']!,
              onTap: () => _launchUrl(source['url']!),
            ),
          ),
          const Divider(),
          const SizedBox(height: AppSpacing.xxl),

          // Social links
          Text(
            'Follow Us',
            style: AppTypography.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _SocialButton(
                icon: Icons.facebook,
                onTap: () => _launchUrl('https://facebook.com/rwandaconnect'),
              ),
              const SizedBox(width: AppSpacing.lg),
              _SocialButton(
                icon: Icons.camera_alt_outlined, // Instagram-like
                onTap: () => _launchUrl('https://instagram.com/rwandaconnect'),
              ),
              const SizedBox(width: AppSpacing.lg),
              _SocialButton(
                icon: Icons.alternate_email, // Twitter/X-like
                onTap: () => _launchUrl('https://twitter.com/rwandaconnect'),
              ),
              const SizedBox(width: AppSpacing.lg),
              _SocialButton(
                icon: Icons.work_outline, // LinkedIn-like
                onTap: () =>
                    _launchUrl('https://linkedin.com/company/rwandaconnect'),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xxxl),

          // Credits
          Center(
            child: Text(
              'Powered by The New Times',
              style: AppTypography.titleSmall.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Center(
            child: Text(
              'Made with love for the Rwandan diaspora',
              style: AppTypography.bodySmallSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Center(
            child: Text(
              '\u00a9 2024 Rwanda Connect. All rights reserved.',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.secondaryText,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xxxl),
        ],
      ),
    );
  }
}

class _AboutLink extends StatelessWidget {
  const _AboutLink({
    required this.icon,
    required this.title,
    required this.onTap,
    this.subtitle,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title, style: AppTypography.bodyLarge),
      subtitle: subtitle != null
          ? Text(subtitle!, style: AppTypography.bodySmallSecondary)
          : null,
      trailing: const Icon(
        Icons.open_in_new,
        size: AppSizes.iconSm,
        color: AppColors.secondaryText,
      ),
      onTap: onTap,
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
