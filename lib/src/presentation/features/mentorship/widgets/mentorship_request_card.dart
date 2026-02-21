import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';
import '../../../../domain/entities/mentorship.dart';

/// Card widget for displaying a mentorship request.
class MentorshipRequestCard extends StatelessWidget {
  const MentorshipRequestCard({
    super.key,
    required this.request,
    required this.isSent,
    this.onCancel,
    this.onAccept,
    this.onDecline,
    this.onTap,
  });

  final MentorshipRequest request;
  final bool isSent;
  final VoidCallback? onCancel;
  final VoidCallback? onAccept;
  final VoidCallback? onDecline;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final name = isSent ? request.mentorName : request.menteeName;
    final avatar = isSent ? request.mentorAvatar : request.menteeAvatar;
    final subtitle = isSent ? request.mentorTitle : null;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundImage:
                        avatar != null ? NetworkImage(avatar) : null,
                    child: avatar == null && name != null
                        ? Text(
                            name[0].toUpperCase(),
                            style: AppTypography.titleMedium.copyWith(
                              color: Colors.white,
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name ?? 'Unknown',
                          style: AppTypography.titleSmall,
                        ),
                        if (subtitle != null)
                          Text(
                            subtitle,
                            style: AppTypography.bodySmallSecondary,
                          ),
                      ],
                    ),
                  ),
                  _StatusChip(status: request.status),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              // Message
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  request.message,
                  style: AppTypography.bodySmall,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              // Time and actions row
              Row(
                children: [
                  Icon(
                    Icons.schedule,
                    size: 14,
                    color: AppColors.secondaryText,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    request.timeAgo,
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.secondaryText,
                    ),
                  ),
                  const Spacer(),
                  // Actions
                  if (request.isPending) ...[
                    if (isSent && onCancel != null)
                      TextButton(
                        onPressed: onCancel,
                        child: const Text('Cancel'),
                      ),
                    if (!isSent) ...[
                      if (onDecline != null)
                        TextButton(
                          onPressed: onDecline,
                          child: const Text('Decline'),
                        ),
                      if (onAccept != null) ...[
                        const SizedBox(width: AppSpacing.sm),
                        FilledButton(
                          onPressed: onAccept,
                          child: const Text('Accept'),
                        ),
                      ],
                    ],
                  ],
                ],
              ),
              // Response message if any
              if (request.responseMessage != null) ...[
                const Divider(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.reply,
                      size: 16,
                      color: AppColors.secondaryText,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        request.responseMessage!,
                        style: AppTypography.bodySmallSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final MentorshipRequestStatus status;

  Color get _color {
    switch (status) {
      case MentorshipRequestStatus.pending:
        return AppColors.warning;
      case MentorshipRequestStatus.accepted:
        return AppColors.success;
      case MentorshipRequestStatus.declined:
        return AppColors.danger;
      case MentorshipRequestStatus.cancelled:
        return AppColors.secondaryText;
      case MentorshipRequestStatus.completed:
        return AppColors.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status.label,
        style: AppTypography.labelSmall.copyWith(color: _color),
      ),
    );
  }
}

/// Card widget for displaying an active mentorship connection.
class MentorshipConnectionCard extends StatelessWidget {
  const MentorshipConnectionCard({
    super.key,
    required this.connection,
    this.onTap,
    this.onEnd,
  });

  final MentorshipConnection connection;
  final VoidCallback? onTap;
  final VoidCallback? onEnd;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              // Mentor avatar
              CircleAvatar(
                radius: 28,
                backgroundImage: connection.mentor.avatar != null
                    ? NetworkImage(connection.mentor.avatar!)
                    : null,
                child: connection.mentor.avatar == null
                    ? Text(
                        connection.mentor.initials,
                        style: AppTypography.titleMedium.copyWith(
                          color: Colors.white,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: AppSpacing.md),
              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      connection.mentor.name,
                      style: AppTypography.titleSmall,
                    ),
                    if (connection.mentor.title != null)
                      Text(
                        connection.mentor.title!,
                        style: AppTypography.bodySmallSecondary,
                      ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: AppColors.secondaryText,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Connected for ${connection.duration}',
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.secondaryText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Status/Actions
              if (connection.isActive && onEnd != null)
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'end') onEnd?.call();
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'end',
                      child: Text('End Mentorship'),
                    ),
                  ],
                )
              else
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 14,
                        color: AppColors.success,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Active',
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.success,
                        ),
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
