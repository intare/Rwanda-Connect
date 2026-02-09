import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/theme.dart';
import '../../../../domain/entities/event.dart';
import '../../../../domain/repositories/event_repository.dart';
import '../../../../data/repositories/event_repository_impl.dart';
import '../providers/event_provider.dart';

/// Detail screen for viewing a single event with RSVP functionality.
class EventDetailScreen extends ConsumerStatefulWidget {
  const EventDetailScreen({
    super.key,
    required this.eventId,
  });

  final String eventId;

  @override
  ConsumerState<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends ConsumerState<EventDetailScreen> {
  RsvpStatus? _currentRsvpStatus;
  bool _isSubmittingRsvp = false;

  Future<void> _submitRsvp(RsvpStatus status) async {
    if (_isSubmittingRsvp) return;

    setState(() {
      _isSubmittingRsvp = true;
    });

    final repository = ref.read(eventRepositoryProvider);
    final result = await repository.rsvpToEvent(widget.eventId, status);

    if (!mounted) return;

    switch (result) {
      case EventSuccess(:final data):
        setState(() {
          _currentRsvpStatus = data;
          _isSubmittingRsvp = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('You are now ${status.label.toLowerCase()} this event'),
            backgroundColor: AppColors.success,
          ),
        );
      case EventFailure(:final message):
        setState(() {
          _isSubmittingRsvp = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: AppColors.danger,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final eventAsync = ref.watch(eventDetailProvider(widget.eventId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // TODO: Implement share functionality
            },
          ),
        ],
      ),
      body: eventAsync.when(
        data: (event) {
          if (event == null) {
            return const _NotFoundState();
          }
          return _EventDetailContent(
            event: event,
            currentRsvpStatus: _currentRsvpStatus,
            isSubmittingRsvp: _isSubmittingRsvp,
            onRsvp: _submitRsvp,
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => _ErrorState(
          message: error.toString(),
          onRetry: () => ref.refresh(eventDetailProvider(widget.eventId)),
        ),
      ),
    );
  }
}

class _EventDetailContent extends StatelessWidget {
  const _EventDetailContent({
    required this.event,
    required this.currentRsvpStatus,
    required this.isSubmittingRsvp,
    required this.onRsvp,
  });

  final Event event;
  final RsvpStatus? currentRsvpStatus;
  final bool isSubmittingRsvp;
  final Function(RsvpStatus) onRsvp;

  String _formatDateTime(DateTime date) {
    return DateFormat('EEEE, MMMM d, yyyy \'at\' h:mm a').format(date);
  }

  String _getTimeUntil(DateTime date) {
    final now = DateTime.now();
    final difference = date.difference(now);

    if (difference.isNegative) {
      return 'This event has ended';
    } else if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return 'Starting in ${difference.inMinutes} minutes';
      }
      return 'Starting in ${difference.inHours} hours';
    } else if (difference.inDays == 1) {
      return 'Tomorrow';
    } else if (difference.inDays < 7) {
      return 'In ${difference.inDays} days';
    } else {
      return 'In ${(difference.inDays / 7).floor()} weeks';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPast = event.isPast;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: AppSpacing.screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSpacing.md),

                // Type badge and time until
                Row(
                  children: [
                    _TypeBadge(type: event.type),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Text(
                        _getTimeUntil(event.date),
                        style: AppTypography.labelMedium.copyWith(
                          color: isPast ? AppColors.danger : AppColors.success,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),

                // Title
                Text(
                  event.title,
                  style: AppTypography.headlineMedium,
                ),
                const SizedBox(height: AppSpacing.sm),

                // Organizer
                Row(
                  children: [
                    const Icon(
                      Icons.business,
                      size: AppSizes.iconSm,
                      color: AppColors.secondaryText,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      'Organized by ${event.organizer}',
                      style: AppTypography.bodyMediumSecondary,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xxl),

                // Info cards
                _InfoCard(
                  children: [
                    _InfoRow(
                      icon: Icons.calendar_today,
                      label: 'Date & Time',
                      value: _formatDateTime(event.date),
                    ),
                    const Divider(height: AppSpacing.xxl),
                    _InfoRow(
                      icon: Icons.location_on_outlined,
                      label: 'Location',
                      value: event.location,
                    ),
                    const Divider(height: AppSpacing.xxl),
                    _InfoRow(
                      icon: Icons.people_outline,
                      label: 'Attendees',
                      value: '${event.rsvpCount} people going',
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xxl),

                // Description
                if (event.description != null &&
                    event.description!.isNotEmpty) ...[
                  Text(
                    'About this event',
                    style: AppTypography.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    event.description!,
                    style: AppTypography.bodyMedium,
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                ],

                // RSVP status indicator
                if (currentRsvpStatus != null) ...[
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.success.withValues(alpha: 0.1),
                      borderRadius: AppRadius.cardRadius,
                      border: Border.all(
                        color: AppColors.success.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: AppColors.success,
                          size: AppSizes.iconMd,
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Text(
                          'You are ${currentRsvpStatus!.label.toLowerCase()} to this event',
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.success,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                ],
              ],
            ),
          ),
        ),

        // Bottom action bar
        if (!isPast)
          _BottomActionBar(
            currentStatus: currentRsvpStatus,
            isSubmitting: isSubmittingRsvp,
            onRsvp: onRsvp,
          ),
      ],
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
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: AppRadius.pillRadius,
      ),
      child: Text(
        type.label,
        style: AppTypography.labelMedium.copyWith(color: color),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: children,
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: AppSizes.iconMd,
          color: AppColors.secondaryText,
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTypography.bodySmallSecondary,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                value,
                style: AppTypography.bodyLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BottomActionBar extends StatelessWidget {
  const _BottomActionBar({
    required this.currentStatus,
    required this.isSubmitting,
    required this.onRsvp,
  });

  final RsvpStatus? currentStatus;
  final bool isSubmitting;
  final Function(RsvpStatus) onRsvp;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Interested button
            Expanded(
              child: OutlinedButton(
                onPressed: isSubmitting || currentStatus == RsvpStatus.interested
                    ? null
                    : () => onRsvp(RsvpStatus.interested),
                child: isSubmitting && currentStatus != RsvpStatus.interested
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(
                        currentStatus == RsvpStatus.interested
                            ? 'Interested'
                            : 'Interested',
                      ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            // Going button
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: isSubmitting || currentStatus == RsvpStatus.going
                    ? null
                    : () => onRsvp(RsvpStatus.going),
                child: isSubmitting && currentStatus != RsvpStatus.going
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        currentStatus == RsvpStatus.going
                            ? 'Going'
                            : 'RSVP - Going',
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotFoundState extends StatelessWidget {
  const _NotFoundState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.screenPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.event_busy,
            size: 64,
            color: AppColors.secondaryText,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Event Not Found',
            style: AppTypography.titleMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'This event may have been removed or is no longer available.',
            style: AppTypography.bodyMediumSecondary,
            textAlign: TextAlign.center,
          ),
        ],
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
    return Padding(
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
    );
  }
}
