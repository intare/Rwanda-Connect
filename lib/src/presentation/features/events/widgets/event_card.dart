import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/theme.dart';
import '../../../../domain/entities/event.dart';

/// Card widget displaying an event summary.
class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    required this.event,
    this.onTap,
  });

  final Event event;
  final VoidCallback? onTap;

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = date.difference(now).inDays;

    if (difference < 0) {
      return 'Past event';
    } else if (difference == 0) {
      return 'Today, ${DateFormat.jm().format(date)}';
    } else if (difference == 1) {
      return 'Tomorrow, ${DateFormat.jm().format(date)}';
    } else if (difference < 7) {
      return DateFormat('EEEE, h:mm a').format(date);
    } else {
      return DateFormat('MMM d, h:mm a').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPast = event.isPast;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date badge
              _DateBadge(date: event.date, isPast: isPast),
              const SizedBox(width: AppSpacing.lg),

              // Event details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Type badge
                    Row(
                      children: [
                        _TypeBadge(type: event.type),
                        const Spacer(),
                        // RSVP count
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.people_outline,
                              size: AppSizes.iconSm,
                              color: AppColors.secondaryText,
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            Text(
                              '${event.rsvpCount}',
                              style: AppTypography.labelSmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),

                    // Title
                    Text(
                      event.title,
                      style: AppTypography.titleMedium.copyWith(
                        color: isPast ? AppColors.secondaryText : null,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.xs),

                    // Organizer
                    Text(
                      'by ${event.organizer}',
                      style: AppTypography.bodySmallSecondary,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.sm),

                    // Location and time
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: AppSizes.iconSm,
                          color: AppColors.secondaryText,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Expanded(
                          child: Text(
                            event.location,
                            style: AppTypography.bodySmallSecondary,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          size: AppSizes.iconSm,
                          color: isPast ? AppColors.danger : AppColors.secondaryText,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          _formatDate(event.date),
                          style: AppTypography.bodySmallSecondary.copyWith(
                            color: isPast ? AppColors.danger : null,
                          ),
                        ),
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

class _DateBadge extends StatelessWidget {
  const _DateBadge({required this.date, required this.isPast});

  final DateTime date;
  final bool isPast;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: isPast
            ? AppColors.secondaryText.withValues(alpha: 0.1)
            : AppColors.accent.withValues(alpha: 0.1),
        borderRadius: AppRadius.cardRadius,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            DateFormat('MMM').format(date).toUpperCase(),
            style: AppTypography.labelSmall.copyWith(
              color: isPast ? AppColors.secondaryText : AppColors.accent,
            ),
          ),
          Text(
            '${date.day}',
            style: AppTypography.headlineMedium.copyWith(
              color: isPast ? AppColors.secondaryText : AppColors.accent,
            ),
          ),
        ],
      ),
    );
  }
}

class _TypeBadge extends StatelessWidget {
  const _TypeBadge({required this.type});

  final EventType type;

  Color _getTypeColor() {
    return switch (type) {
      EventType.networking => AppColors.accent,
      EventType.seminar => AppColors.success,
      EventType.workshop => AppColors.warning,
      EventType.conference => AppColors.info,
    };
  }

  @override
  Widget build(BuildContext context) {
    final color = _getTypeColor();

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: AppRadius.pillRadius,
      ),
      child: Text(
        type.label,
        style: AppTypography.labelSmall.copyWith(color: color),
      ),
    );
  }
}
