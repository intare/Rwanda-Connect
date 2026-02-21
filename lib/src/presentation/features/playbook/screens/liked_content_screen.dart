import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/theme.dart';
import '../../../../data/repositories/playbook_repository_impl.dart';
import '../../../../domain/entities/playbook.dart';
import '../../../../domain/repositories/playbook_repository.dart';
import '../../../widgets/offline_indicator.dart';
import '../widgets/playbook_content_card.dart';
import '../widgets/playbook_shimmer.dart';

/// State for liked content.
class LikedContentState {
  const LikedContentState({
    this.content = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
    this.hasMore = true,
    this.currentPage = 1,
  });

  final List<PlaybookContent> content;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;
  final bool hasMore;
  final int currentPage;

  LikedContentState copyWith({
    List<PlaybookContent>? content,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
    bool? hasMore,
    int? currentPage,
  }) {
    return LikedContentState(
      content: content ?? this.content,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

/// Notifier for liked content.
class LikedContentNotifier extends StateNotifier<LikedContentState> {
  LikedContentNotifier(this._repository) : super(const LikedContentState()) {
    loadContent();
  }

  final PlaybookRepository _repository;
  static const int _pageSize = 20;

  Future<void> loadContent({bool refresh = false}) async {
    if (state.isLoading && !refresh) return;

    state = state.copyWith(
      isLoading: true,
      error: null,
      currentPage: 1,
      content: refresh ? [] : state.content,
    );

    final result = await _repository.getLikedContent(
      page: 1,
      limit: _pageSize,
    );

    switch (result) {
      case PlaybookSuccess(:final data, :final hasMore):
        state = state.copyWith(
          content: data,
          isLoading: false,
          hasMore: hasMore,
          currentPage: 1,
        );
      case PlaybookFailure(:final message):
        state = state.copyWith(
          isLoading: false,
          error: message,
        );
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore || state.isLoading) return;

    state = state.copyWith(isLoadingMore: true);

    final nextPage = state.currentPage + 1;
    final result = await _repository.getLikedContent(
      page: nextPage,
      limit: _pageSize,
    );

    switch (result) {
      case PlaybookSuccess(:final data, :final hasMore):
        state = state.copyWith(
          content: [...state.content, ...data],
          isLoadingMore: false,
          hasMore: hasMore,
          currentPage: nextPage,
        );
      case PlaybookFailure(:final message):
        state = state.copyWith(
          isLoadingMore: false,
          error: message,
        );
    }
  }

  Future<void> refresh() async {
    await loadContent(refresh: true);
  }
}

/// Provider for liked content.
final likedContentProvider =
    StateNotifierProvider<LikedContentNotifier, LikedContentState>((ref) {
  final repository = ref.watch(playbookRepositoryProvider);
  return LikedContentNotifier(repository);
});

/// Screen displaying user's liked playbook content.
class LikedContentScreen extends ConsumerStatefulWidget {
  const LikedContentScreen({super.key});

  @override
  ConsumerState<LikedContentScreen> createState() => _LikedContentScreenState();
}

class _LikedContentScreenState extends ConsumerState<LikedContentScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(likedContentProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(likedContentProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Liked Content'),
      ),
      body: Column(
        children: [
          const OfflineBanner(),
          Expanded(child: _buildContent(state)),
        ],
      ),
    );
  }

  Widget _buildContent(LikedContentState state) {
    if (state.isLoading && state.content.isEmpty) {
      return const PlaybookShimmerList();
    }

    if (state.error != null && state.content.isEmpty) {
      return _ErrorView(
        message: state.error!,
        onRetry: () => ref.read(likedContentProvider.notifier).refresh(),
      );
    }

    if (state.content.isEmpty) {
      return const _EmptyView();
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(likedContentProvider.notifier).refresh(),
      child: ListView.separated(
        controller: _scrollController,
        padding: const EdgeInsets.all(AppSpacing.md),
        itemCount: state.content.length + (state.isLoadingMore ? 1 : 0),
        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
        itemBuilder: (context, index) {
          if (index >= state.content.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.md),
                child: CircularProgressIndicator(),
              ),
            );
          }

          final content = state.content[index];
          return PlaybookContentCard(
            content: content,
            onTap: () => context.push('/playbook/${content.id}'),
          );
        },
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({
    required this.message,
    required this.onRetry,
  });

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
            const Icon(
              Icons.error_outline,
              size: 64,
              color: AppColors.secondaryText,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              message,
              style: AppTypography.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.md),
            FilledButton.tonal(
              onPressed: onRetry,
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.favorite_border,
              size: 64,
              color: AppColors.secondaryText,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'No liked content yet',
              style: AppTypography.titleMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Like articles, videos, and guides to save them here for easy access.',
              style: AppTypography.bodyMediumSecondary,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.md),
            FilledButton.tonal(
              onPressed: () => context.go('/playbook'),
              child: const Text('Explore Playbook'),
            ),
          ],
        ),
      ),
    );
  }
}
