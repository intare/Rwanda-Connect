import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/theme.dart';
import '../../../../data/repositories/mentorship_repository_impl.dart';
import '../../../../domain/repositories/mentorship_repository.dart';
import '../../../widgets/offline_indicator.dart';
import '../providers/mentorship_provider.dart';
import '../widgets/mentorship_request_card.dart';

/// Screen displaying user's mentorship requests and connections.
class MyMentorshipsScreen extends ConsumerStatefulWidget {
  const MyMentorshipsScreen({super.key});

  @override
  ConsumerState<MyMentorshipsScreen> createState() => _MyMentorshipsScreenState();
}

class _MyMentorshipsScreenState extends ConsumerState<MyMentorshipsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final requestsState = ref.watch(mentorshipRequestsProvider);
    final connectionsAsync = ref.watch(mentorshipConnectionsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Mentorships'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Connections'),
                  if (connectionsAsync.valueOrNull?.isNotEmpty ?? false) ...[
                    const SizedBox(width: 4),
                    _Badge(count: connectionsAsync.value!.length),
                  ],
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Sent'),
                  if (requestsState.pendingSentCount > 0) ...[
                    const SizedBox(width: 4),
                    _Badge(count: requestsState.pendingSentCount),
                  ],
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Received'),
                  if (requestsState.pendingReceivedCount > 0) ...[
                    const SizedBox(width: 4),
                    _Badge(count: requestsState.pendingReceivedCount),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const OfflineBanner(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _ConnectionsTab(connectionsAsync: connectionsAsync),
                _SentRequestsTab(state: requestsState),
                _ReceivedRequestsTab(state: requestsState),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        '$count',
        style: AppTypography.labelSmall.copyWith(color: Colors.white),
      ),
    );
  }
}

class _ConnectionsTab extends ConsumerWidget {
  const _ConnectionsTab({required this.connectionsAsync});

  final AsyncValue connectionsAsync;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return connectionsAsync.when(
      data: (connections) {
        if (connections.isEmpty) {
          return const _EmptyView(
            icon: Icons.people_outline,
            title: 'No active mentorships',
            subtitle: 'Connect with mentors to start your journey.',
          );
        }

        return RefreshIndicator(
          onRefresh: () async => ref.invalidate(mentorshipConnectionsProvider),
          child: ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.md),
            itemCount: connections.length,
            separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (context, index) {
              final connection = connections[index];
              return MentorshipConnectionCard(
                connection: connection,
                onTap: () => context.push('/mentorship/mentor/${connection.mentorId}'),
                onEnd: () => _confirmEndConnection(context, ref, connection.id),
              );
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Error: $error')),
    );
  }

  Future<void> _confirmEndConnection(
    BuildContext context,
    WidgetRef ref,
    String connectionId,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('End Mentorship'),
        content: const Text('Are you sure you want to end this mentorship connection?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('End')),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      final repository = ref.read(mentorshipRepositoryProvider);
      final result = await repository.endConnection(connectionId);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result is MentorshipSuccess
                ? 'Mentorship ended'
                : 'Failed to end mentorship'),
          ),
        );
        ref.invalidate(mentorshipConnectionsProvider);
      }
    }
  }
}

class _SentRequestsTab extends ConsumerWidget {
  const _SentRequestsTab({required this.state});

  final MentorshipRequestsState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (state.isLoadingSent && state.sentRequests.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.sentRequests.isEmpty) {
      return const _EmptyView(
        icon: Icons.send_outlined,
        title: 'No sent requests',
        subtitle: 'Find a mentor and send a request.',
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(mentorshipRequestsProvider.notifier).loadSentRequests(),
      child: ListView.separated(
        padding: const EdgeInsets.all(AppSpacing.md),
        itemCount: state.sentRequests.length,
        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
        itemBuilder: (context, index) {
          final request = state.sentRequests[index];
          return MentorshipRequestCard(
            request: request,
            isSent: true,
            onCancel: request.isPending
                ? () => _cancelRequest(context, ref, request.id)
                : null,
            onTap: () => context.push('/mentorship/mentor/${request.mentorId}'),
          );
        },
      ),
    );
  }

  Future<void> _cancelRequest(BuildContext context, WidgetRef ref, String requestId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Request'),
        content: const Text('Are you sure you want to cancel this request?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('No')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Yes')),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      final success = await ref.read(mentorshipRequestsProvider.notifier).cancelRequest(requestId);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(success ? 'Request cancelled' : 'Failed to cancel')),
        );
      }
    }
  }
}

class _ReceivedRequestsTab extends ConsumerWidget {
  const _ReceivedRequestsTab({required this.state});

  final MentorshipRequestsState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (state.isLoadingReceived && state.receivedRequests.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.receivedRequests.isEmpty) {
      return const _EmptyView(
        icon: Icons.inbox_outlined,
        title: 'No received requests',
        subtitle: 'Mentorship requests from others will appear here.',
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(mentorshipRequestsProvider.notifier).loadReceivedRequests(),
      child: ListView.separated(
        padding: const EdgeInsets.all(AppSpacing.md),
        itemCount: state.receivedRequests.length,
        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
        itemBuilder: (context, index) {
          final request = state.receivedRequests[index];
          return MentorshipRequestCard(
            request: request,
            isSent: false,
            onAccept: request.isPending
                ? () => _acceptRequest(context, ref, request.id)
                : null,
            onDecline: request.isPending
                ? () => _declineRequest(context, ref, request.id)
                : null,
          );
        },
      ),
    );
  }

  Future<void> _acceptRequest(BuildContext context, WidgetRef ref, String requestId) async {
    final success = await ref.read(mentorshipRequestsProvider.notifier).acceptRequest(requestId);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(success ? 'Request accepted!' : 'Failed to accept'),
          backgroundColor: success ? AppColors.success : AppColors.danger,
        ),
      );
      if (success) ref.invalidate(mentorshipConnectionsProvider);
    }
  }

  Future<void> _declineRequest(BuildContext context, WidgetRef ref, String requestId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Decline Request'),
        content: const Text('Are you sure you want to decline this request?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Decline')),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      final success = await ref.read(mentorshipRequestsProvider.notifier).declineRequest(requestId);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(success ? 'Request declined' : 'Failed to decline')),
        );
      }
    }
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView({required this.icon, required this.title, required this.subtitle});

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 64, color: AppColors.secondaryText),
            const SizedBox(height: AppSpacing.md),
            Text(title, style: AppTypography.titleMedium),
            const SizedBox(height: AppSpacing.sm),
            Text(subtitle, style: AppTypography.bodyMediumSecondary, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
