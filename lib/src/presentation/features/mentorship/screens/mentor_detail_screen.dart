import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/theme/theme.dart';
import '../../../../data/repositories/mentorship_repository_impl.dart';
import '../../../../domain/entities/mentorship.dart';
import '../../../../domain/repositories/mentorship_repository.dart';
import '../../../widgets/offline_indicator.dart';
import '../providers/mentorship_provider.dart';

/// Screen displaying detailed mentor information.
class MentorDetailScreen extends ConsumerStatefulWidget {
  const MentorDetailScreen({super.key, required this.mentorId});

  final String mentorId;

  @override
  ConsumerState<MentorDetailScreen> createState() => _MentorDetailScreenState();
}

class _MentorDetailScreenState extends ConsumerState<MentorDetailScreen> {
  final _messageController = TextEditingController();
  bool _isSendingRequest = false;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _sendRequest(Mentor mentor) async {
    if (_messageController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a message')),
      );
      return;
    }

    setState(() => _isSendingRequest = true);

    final repository = ref.read(mentorshipRepositoryProvider);
    final result = await repository.sendRequest(
      mentor.id,
      _messageController.text.trim(),
    );

    if (!mounted) return;

    setState(() => _isSendingRequest = false);

    switch (result) {
      case MentorshipSuccess():
        _messageController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Mentorship request sent successfully!'),
            backgroundColor: AppColors.success,
          ),
        );
        ref.invalidate(mentorshipQuotaProvider);
      case MentorshipFailure(:final message):
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: AppColors.danger),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final mentorAsync = ref.watch(mentorDetailProvider(widget.mentorId));
    final quotaAsync = ref.watch(mentorshipQuotaProvider);

    return Scaffold(
      body: mentorAsync.when(
        data: (mentor) {
          if (mentor == null) return const _NotFoundView();
          return _MentorContent(
            mentor: mentor,
            quota: quotaAsync.valueOrNull ?? 0,
            messageController: _messageController,
            isSendingRequest: _isSendingRequest,
            onSendRequest: () => _sendRequest(mentor),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => _ErrorView(
          message: error.toString(),
          onRetry: () => ref.invalidate(mentorDetailProvider(widget.mentorId)),
        ),
      ),
    );
  }
}

class _MentorContent extends StatelessWidget {
  const _MentorContent({
    required this.mentor,
    required this.quota,
    required this.messageController,
    required this.isSendingRequest,
    required this.onSendRequest,
  });

  final Mentor mentor;
  final int quota;
  final TextEditingController messageController;
  final bool isSendingRequest;
  final VoidCallback onSendRequest;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 200,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              color: AppColors.primary,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 60),
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: mentor.avatar != null
                              ? NetworkImage(mentor.avatar!)
                              : null,
                          child: mentor.avatar == null
                              ? Text(mentor.initials,
                                  style: AppTypography.headlineMedium
                                      .copyWith(color: Colors.white))
                              : null,
                        ),
                        if (mentor.isAvailable)
                          Positioned(
                            bottom: 4,
                            right: 4,
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: AppColors.success,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 3),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SliverToBoxAdapter(child: OfflineBanner()),
        SliverPadding(
          padding: const EdgeInsets.all(AppSpacing.md),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // Name and title
              Text(mentor.name, style: AppTypography.headlineSmall, textAlign: TextAlign.center),
              if (mentor.title != null || mentor.company != null) ...[
                const SizedBox(height: 4),
                Text(
                  [mentor.title, mentor.company].where((e) => e != null).join(' at '),
                  style: AppTypography.bodyMediumSecondary,
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: AppSpacing.sm),

              // Rating
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.star, color: AppColors.warning, size: 20),
                  const SizedBox(width: 4),
                  Text(mentor.formattedRating, style: AppTypography.titleSmall),
                  const SizedBox(width: 4),
                  Text('(${mentor.reviewCount} reviews)',
                      style: AppTypography.bodySmallSecondary),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),

              // Stats
              _StatsRow(mentor: mentor),
              const SizedBox(height: AppSpacing.lg),

              // Expertise
              Text('Expertise', style: AppTypography.titleMedium),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: mentor.expertise
                    .map((e) => Chip(label: Text(e.label), visualDensity: VisualDensity.compact))
                    .toList(),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Bio
              if (mentor.bio != null) ...[
                Text('About', style: AppTypography.titleMedium),
                const SizedBox(height: AppSpacing.sm),
                Text(mentor.bio!, style: AppTypography.bodyMedium),
                const SizedBox(height: AppSpacing.lg),
              ],

              // Languages
              if (mentor.languages.isNotEmpty) ...[
                Text('Languages', style: AppTypography.titleMedium),
                const SizedBox(height: AppSpacing.sm),
                Text(mentor.languages.join(', '), style: AppTypography.bodyMedium),
                const SizedBox(height: AppSpacing.lg),
              ],

              // LinkedIn
              if (mentor.linkedinUrl != null) ...[
                OutlinedButton.icon(
                  onPressed: () => _launchUrl(mentor.linkedinUrl!),
                  icon: const Icon(Icons.link),
                  label: const Text('View LinkedIn Profile'),
                ),
                const SizedBox(height: AppSpacing.lg),
              ],

              // Request section
              if (mentor.isAvailable) ...[
                const Divider(),
                const SizedBox(height: AppSpacing.md),
                Text('Request Mentorship', style: AppTypography.titleMedium),
                const SizedBox(height: AppSpacing.sm),
                if (quota > 0) ...[
                  Text(
                    'Introduce yourself and explain why you\'d like ${mentor.name} as your mentor.',
                    style: AppTypography.bodySmallSecondary,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  TextField(
                    controller: messageController,
                    maxLines: 4,
                    maxLength: 500,
                    decoration: const InputDecoration(
                      hintText: 'Write your message...',
                      alignLabelWithHint: true,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  FilledButton(
                    onPressed: isSendingRequest ? null : onSendRequest,
                    style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(48)),
                    child: isSendingRequest
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                          )
                        : const Text('Send Request'),
                  ),
                ] else ...[
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.warning.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline, color: AppColors.warning),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            'You\'ve used all your mentorship requests. Upgrade to send more.',
                            style: AppTypography.bodySmall.copyWith(color: AppColors.warning),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ] else ...[
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.schedule, color: AppColors.secondaryText),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        'This mentor is currently unavailable',
                        style: AppTypography.bodyMediumSecondary,
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.xl),
            ]),
          ),
        ),
      ],
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.mentor});

  final Mentor mentor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatItem(value: '${mentor.yearsExperience}', label: 'Years Exp.'),
          _StatItem(value: '${mentor.totalMentees}', label: 'Mentees'),
          if (mentor.location != null) _StatItem(value: mentor.location!, label: 'Location'),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: AppTypography.titleMedium),
        Text(label, style: AppTypography.labelSmall.copyWith(color: AppColors.secondaryText)),
      ],
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: AppColors.secondaryText),
            const SizedBox(height: AppSpacing.md),
            Text(message, style: AppTypography.bodyMedium, textAlign: TextAlign.center),
            const SizedBox(height: AppSpacing.md),
            FilledButton.tonal(onPressed: onRetry, child: const Text('Try Again')),
          ],
        ),
      ),
    );
  }
}

class _NotFoundView extends StatelessWidget {
  const _NotFoundView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.person_off_outlined, size: 64, color: AppColors.secondaryText),
            const SizedBox(height: AppSpacing.md),
            Text('Mentor not found', style: AppTypography.titleMedium),
            const SizedBox(height: AppSpacing.md),
            FilledButton.tonal(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
