import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/theme.dart';
import '../../../../domain/entities/mentorship.dart';
import '../../../widgets/offline_indicator.dart';
import '../providers/mentorship_provider.dart';
import '../widgets/mentor_card.dart';
import '../widgets/mentor_shimmer.dart';

/// Screen displaying the list of mentors.
class MentorsScreen extends ConsumerStatefulWidget {
  const MentorsScreen({super.key});

  @override
  ConsumerState<MentorsScreen> createState() => _MentorsScreenState();
}

class _MentorsScreenState extends ConsumerState<MentorsScreen> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(mentorsProvider.notifier).loadMore();
    }
  }

  void _onSearch() {
    ref.read(mentorsProvider.notifier).search(_searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(mentorsProvider);
    final quotaAsync = ref.watch(mentorshipQuotaProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Find a Mentor'),
        actions: [
          IconButton(
            icon: const Icon(Icons.people_outline),
            tooltip: 'My Mentorships',
            onPressed: () => context.push('/mentorship/my'),
          ),
        ],
      ),
      body: Column(
        children: [
          const OfflineBanner(),

          // Quota banner
          quotaAsync.when(
            data: (quota) => quota > 0
                ? Container(
                    margin: const EdgeInsets.all(AppSpacing.md),
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: AppColors.info.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline, color: AppColors.info),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          'You have $quota mentorship request${quota == 1 ? '' : 's'} remaining',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.info,
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),

          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search mentors...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _onSearch();
                        },
                      )
                    : null,
              ),
              onSubmitted: (_) => _onSearch(),
              onChanged: (value) => setState(() {}),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          // Expertise filter chips
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              children: [
                FilterChip(
                  label: const Text('All'),
                  selected: state.selectedExpertise == null,
                  onSelected: (_) =>
                      ref.read(mentorsProvider.notifier).filterByExpertise(null),
                ),
                const SizedBox(width: AppSpacing.sm),
                ...MentorExpertise.values.take(6).map(
                      (expertise) => Padding(
                        padding: const EdgeInsets.only(right: AppSpacing.sm),
                        child: FilterChip(
                          label: Text(expertise.label),
                          selected: state.selectedExpertise == expertise,
                          onSelected: (_) => ref
                              .read(mentorsProvider.notifier)
                              .filterByExpertise(
                                state.selectedExpertise == expertise
                                    ? null
                                    : expertise,
                              ),
                        ),
                      ),
                    ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          // Available only toggle
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Row(
              children: [
                Text(
                  'Available only',
                  style: AppTypography.bodySmall,
                ),
                const Spacer(),
                Switch(
                  value: state.showAvailableOnly,
                  onChanged: (_) =>
                      ref.read(mentorsProvider.notifier).toggleAvailableOnly(),
                ),
              ],
            ),
          ),

          // Mentors list
          Expanded(child: _buildContent(state)),
        ],
      ),
    );
  }

  Widget _buildContent(MentorsState state) {
    if (state.isLoading && state.mentors.isEmpty) {
      return const MentorShimmerList();
    }

    if (state.error != null && state.mentors.isEmpty) {
      return _ErrorView(
        message: state.error!,
        onRetry: () => ref.read(mentorsProvider.notifier).refresh(),
      );
    }

    if (state.mentors.isEmpty) {
      return _EmptyView(
        hasFilters: state.hasActiveFilters,
        onClearFilters: () => ref.read(mentorsProvider.notifier).clearFilters(),
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(mentorsProvider.notifier).refresh(),
      child: ListView.separated(
        controller: _scrollController,
        padding: const EdgeInsets.all(AppSpacing.md),
        itemCount: state.mentors.length + (state.isLoadingMore ? 1 : 0),
        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
        itemBuilder: (context, index) {
          if (index >= state.mentors.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.md),
                child: CircularProgressIndicator(),
              ),
            );
          }

          final mentor = state.mentors[index];
          return MentorCard(
            mentor: mentor,
            onTap: () => context.push('/mentorship/mentor/${mentor.id}'),
          );
        },
      ),
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

class _EmptyView extends StatelessWidget {
  const _EmptyView({required this.hasFilters, required this.onClearFilters});

  final bool hasFilters;
  final VoidCallback onClearFilters;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.people_outline, size: 64, color: AppColors.secondaryText),
            const SizedBox(height: AppSpacing.md),
            Text(
              hasFilters ? 'No mentors match your filters' : 'No mentors available',
              style: AppTypography.bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (hasFilters) ...[
              const SizedBox(height: AppSpacing.md),
              FilledButton.tonal(onPressed: onClearFilters, child: const Text('Clear Filters')),
            ],
          ],
        ),
      ),
    );
  }
}
