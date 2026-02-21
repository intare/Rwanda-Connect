import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';
import '../../../../domain/entities/mentorship.dart';

/// Card widget for displaying a mentor in a list.
class MentorCard extends StatelessWidget {
  const MentorCard({
    super.key,
    required this.mentor,
    required this.onTap,
  });

  final Mentor mentor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              Stack(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundImage: mentor.avatar != null
                        ? NetworkImage(mentor.avatar!)
                        : null,
                    child: mentor.avatar == null
                        ? Text(
                            mentor.initials,
                            style: AppTypography.titleMedium.copyWith(
                              color: Colors.white,
                            ),
                          )
                        : null,
                  ),
                  if (mentor.isAvailable)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: AppColors.success,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: AppSpacing.md),
              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name and rating
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            mentor.name,
                            style: AppTypography.titleSmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (mentor.rating > 0) ...[
                          const Icon(
                            Icons.star,
                            size: 16,
                            color: AppColors.warning,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            mentor.formattedRating,
                            style: AppTypography.labelSmall,
                          ),
                        ],
                      ],
                    ),
                    // Title and company
                    if (mentor.title != null || mentor.company != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        [mentor.title, mentor.company]
                            .where((e) => e != null)
                            .join(' at '),
                        style: AppTypography.bodySmallSecondary,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: AppSpacing.sm),
                    // Expertise chips
                    Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: mentor.expertise.take(3).map((e) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            e.label,
                            style: AppTypography.labelSmall.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    // Stats row
                    Row(
                      children: [
                        _StatItem(
                          icon: Icons.work_outline,
                          value: '${mentor.yearsExperience} yrs',
                        ),
                        const SizedBox(width: AppSpacing.md),
                        _StatItem(
                          icon: Icons.people_outline,
                          value: '${mentor.totalMentees} mentees',
                        ),
                        if (mentor.location != null) ...[
                          const SizedBox(width: AppSpacing.md),
                          _StatItem(
                            icon: Icons.location_on_outlined,
                            value: mentor.location!,
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.icon,
    required this.value,
  });

  final IconData icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColors.secondaryText),
        const SizedBox(width: 4),
        Text(
          value,
          style: AppTypography.labelSmall.copyWith(
            color: AppColors.secondaryText,
          ),
        ),
      ],
    );
  }
}

/// Featured mentor card with larger display.
class FeaturedMentorCard extends StatelessWidget {
  const FeaturedMentorCard({
    super.key,
    required this.mentor,
    required this.onTap,
  });

  final Mentor mentor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 200,
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            children: [
              // Avatar
              Stack(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: mentor.avatar != null
                        ? NetworkImage(mentor.avatar!)
                        : null,
                    child: mentor.avatar == null
                        ? Text(
                            mentor.initials,
                            style: AppTypography.headlineSmall.copyWith(
                              color: Colors.white,
                            ),
                          )
                        : null,
                  ),
                  if (mentor.isAvailable)
                    Positioned(
                      bottom: 4,
                      right: 4,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: AppColors.success,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              // Name
              Text(
                mentor.name,
                style: AppTypography.titleSmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              // Title
              if (mentor.title != null) ...[
                const SizedBox(height: 2),
                Text(
                  mentor.title!,
                  style: AppTypography.bodySmallSecondary,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: AppSpacing.sm),
              // Rating
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.star,
                    size: 16,
                    color: AppColors.warning,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    mentor.formattedRating,
                    style: AppTypography.labelSmall,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '(${mentor.reviewCount})',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.secondaryText,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              // Primary expertise
              if (mentor.expertise.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    mentor.expertise.first.label,
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
