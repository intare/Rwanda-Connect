import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/theme.dart';
import '../../../../domain/entities/event.dart';
import '../../../../domain/repositories/event_repository.dart';
import '../providers/event_provider.dart';

/// Screen showing user's RSVPs (events they've RSVP'd to).
class MyRsvpsScreen extends ConsumerWidget {
  const MyRsvpsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(myRsvpsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My RSVPs'),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(myRsvpsProvider.notifier).refresh(),
        child: _buildContent(context, ref, state),
      ),
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref, MyRsvpsState state) {
    if (state.isLoading && state.rsvps.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null && state.rsvps.isEmpty) {
      return _ErrorState(
        message: state.error!,
        onRetry: () => ref.read(myRsvpsProvider.notifier).loadRsvps(),
      );
    }

    if (state.rsvps.isEmpty) {
      return const _EmptyState();
    }

    return _RsvpsList(
      rsvps: state.rsvps,
      hasMore: state.hasMore,
      isLoadingMore: state.isLoadingMore,
      onLoadMore: () => ref.read(myRsvpsProvider.notifier).loadMore(),
    );
  }
}

class _RsvpsList extends StatelessWidget {
  const _RsvpsList({
    required this.rsvps,
    required this.hasMore,
    required this.isLoadingMore,
    required this.onLoadMore,
  });

  final List<UserRsvp> rsvps;
  final bool hasMore;
  final bool isLoadingMore;
  final VoidCallback onLoadMore;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification &&
            notification.metrics.extentAfter < 200 &&
            hasMore &&
            !isLoadingMore) {
          onLoadMore();
        }
        return false;
      },
      child: ListView.builder(
        padding: AppSpacing.screenPadding,
        itemCount: rsvps.length + (hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == rsvps.length) {
            return const Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final rsvp = rsvps[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: _RsvpCard(rsvp: rsvp),
          );
        },
      ),
    );
  }
}

class _RsvpCard extends ConsumerWidget {
  const _RsvpCard({required this.rsvp});

  final UserRsvp rsvp;

  String _formatDate(DateTime date) {
    return DateFormat('EEE, MMM d \'at\' h:mm a').format(date);
  }

  Color _getTypeColor(EventType type) {
    return switch (type) {
      EventType.networking => AppColors.accent,
      EventType.seminar => AppColors.success,
      EventType.workshop => AppColors.warning,
      EventType.conference => AppColors.info,
    };
  }

  Color _getStatusColor(RsvpStatus status) {
    return switch (status) {
      RsvpStatus.going => AppColors.success,
      RsvpStatus.interested => AppColors.accent,
      RsvpStatus.notGoing => AppColors.secondaryText,
    };
  }

  IconData _getStatusIcon(RsvpStatus status) {
    return switch (status) {
      RsvpStatus.going => Icons.check_circle,
      RsvpStatus.interested => Icons.star,
      RsvpStatus.notGoing => Icons.cancel,
    };
  }

  Future<void> _handleCancelRsvp(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel RSVP'),
        content: const Text('Are you sure you want to cancel your RSVP?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            child: const Text('Yes, Cancel'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      final notifier = ref.read(eventRsvpProvider(rsvp.event.id).notifier);
      final success = await notifier.cancel();

      if (context.mounted) {
        if (success) {
          ref.read(myRsvpsProvider.notifier).removeRsvp(rsvp.id);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('RSVP cancelled'),
              backgroundColor: AppColors.success,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to cancel RSVP'),
              backgroundColor: AppColors.danger,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final event = rsvp.event;
    final isPast = event.isPast;
    final typeColor = _getTypeColor(event.type);
    final statusColor = _getStatusColor(rsvp.status);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push(
          AppRoutes.eventDetail.replaceFirst(':id', event.id),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Type badge + RSVP status
              Row(
                children: [
                  // Type badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: typeColor.withValues(alpha: 0.1),
                      borderRadius: AppRadius.pillRadius,
                    ),
                    child: Text(
                      event.type.label,
                      style: AppTypography.labelSmall.copyWith(color: typeColor),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  // RSVP status
                  Icon(
                    _getStatusIcon(rsvp.status),
                    size: AppSizes.iconSm,
                    color: statusColor,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    rsvp.status.label,
                    style: AppTypography.labelSmall.copyWith(color: statusColor),
                  ),
                  const Spacer(),
                  // Past indicator
                  if (isPast)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryText.withValues(alpha: 0.1),
                        borderRadius: AppRadius.pillRadius,
                      ),
                      child: Text(
                        'Past',
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.secondaryText,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),

              // Title
              Text(
                event.title,
                style: AppTypography.titleMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSpacing.sm),

              // Date
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: AppSizes.iconSm,
                    color: isPast ? AppColors.secondaryText : AppColors.primaryText,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    _formatDate(event.date),
                    style: isPast
                        ? AppTypography.bodySmallSecondary
                        : AppTypography.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),

              // Location
              Row(
                children: [
                  const Icon(
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

              // Cancel button for upcoming events
              if (!isPast && rsvp.status != RsvpStatus.notGoing) ...[
                const SizedBox(height: AppSpacing.md),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => _handleCancelRsvp(context, ref),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.danger,
                      ),
                      child: const Text('Cancel RSVP'),
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

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppSpacing.screenPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.event_available,
              size: 64,
              color: AppColors.secondaryText,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'No RSVPs yet',
              style: AppTypography.titleMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Events you RSVP to will appear here',
              style: AppTypography.bodyMediumSecondary,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xxl),
            ElevatedButton.icon(
              onPressed: () => context.go(AppRoutes.events),
              icon: const Icon(Icons.explore),
              label: const Text('Browse Events'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppSpacing.screenPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: AppColors.secondaryText,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Something went wrong',
              style: AppTypography.titleMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              message,
              style: AppTypography.bodyMediumSecondary,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xxl),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}
