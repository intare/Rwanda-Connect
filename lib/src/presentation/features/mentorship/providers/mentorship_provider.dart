import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/repositories/mentorship_repository_impl.dart';
import '../../../../domain/entities/mentorship.dart';
import '../../../../domain/repositories/mentorship_repository.dart';

/// State for the mentors list.
class MentorsState {
  const MentorsState({
    this.mentors = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
    this.hasMore = true,
    this.currentPage = 1,
    this.selectedExpertise,
    this.searchQuery,
    this.showAvailableOnly = true,
    this.sortOption = 'rating:desc',
  });

  final List<Mentor> mentors;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;
  final bool hasMore;
  final int currentPage;
  final MentorExpertise? selectedExpertise;
  final String? searchQuery;
  final bool showAvailableOnly;
  final String sortOption;

  MentorsState copyWith({
    List<Mentor>? mentors,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
    bool? hasMore,
    int? currentPage,
    MentorExpertise? selectedExpertise,
    String? searchQuery,
    bool? showAvailableOnly,
    String? sortOption,
    bool clearExpertise = false,
    bool clearSearch = false,
  }) {
    return MentorsState(
      mentors: mentors ?? this.mentors,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      selectedExpertise:
          clearExpertise ? null : (selectedExpertise ?? this.selectedExpertise),
      searchQuery: clearSearch ? null : (searchQuery ?? this.searchQuery),
      showAvailableOnly: showAvailableOnly ?? this.showAvailableOnly,
      sortOption: sortOption ?? this.sortOption,
    );
  }

  bool get hasActiveFilters =>
      selectedExpertise != null ||
      (searchQuery != null && searchQuery!.isNotEmpty);
}

/// Notifier for managing mentors list state.
class MentorsNotifier extends StateNotifier<MentorsState> {
  MentorsNotifier(this._repository) : super(const MentorsState()) {
    loadMentors();
  }

  final MentorshipRepository _repository;
  static const int _pageSize = 20;

  Future<void> loadMentors({bool refresh = false}) async {
    if (state.isLoading && !refresh) return;

    state = state.copyWith(
      isLoading: true,
      error: null,
      currentPage: 1,
      mentors: refresh ? [] : state.mentors,
    );

    final params = GetMentorsParams(
      page: 1,
      limit: _pageSize,
      expertise: state.selectedExpertise,
      search: state.searchQuery,
      isAvailable: state.showAvailableOnly ? true : null,
      sort: state.sortOption,
    );

    final result = await _repository.getMentors(params);

    switch (result) {
      case MentorshipSuccess(:final data, :final hasMore):
        state = state.copyWith(
          mentors: data,
          isLoading: false,
          hasMore: hasMore,
          currentPage: 1,
        );
      case MentorshipFailure(:final message):
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
    final params = GetMentorsParams(
      page: nextPage,
      limit: _pageSize,
      expertise: state.selectedExpertise,
      search: state.searchQuery,
      isAvailable: state.showAvailableOnly ? true : null,
      sort: state.sortOption,
    );

    final result = await _repository.getMentors(params);

    switch (result) {
      case MentorshipSuccess(:final data, :final hasMore):
        state = state.copyWith(
          mentors: [...state.mentors, ...data],
          isLoadingMore: false,
          hasMore: hasMore,
          currentPage: nextPage,
        );
      case MentorshipFailure(:final message):
        state = state.copyWith(
          isLoadingMore: false,
          error: message,
        );
    }
  }

  Future<void> filterByExpertise(MentorExpertise? expertise) async {
    if (state.selectedExpertise == expertise) return;

    state = state.copyWith(
      selectedExpertise: expertise,
      clearExpertise: expertise == null,
      mentors: [],
      currentPage: 1,
      hasMore: true,
    );

    await loadMentors();
  }

  Future<void> search(String? query) async {
    final trimmedQuery = query?.trim();
    if (state.searchQuery == trimmedQuery) return;

    state = state.copyWith(
      searchQuery: trimmedQuery,
      clearSearch: trimmedQuery == null || trimmedQuery.isEmpty,
      mentors: [],
      currentPage: 1,
      hasMore: true,
    );

    await loadMentors();
  }

  Future<void> toggleAvailableOnly() async {
    state = state.copyWith(
      showAvailableOnly: !state.showAvailableOnly,
      mentors: [],
      currentPage: 1,
      hasMore: true,
    );

    await loadMentors();
  }

  Future<void> changeSort(String sortOption) async {
    if (state.sortOption == sortOption) return;

    state = state.copyWith(
      sortOption: sortOption,
      mentors: [],
      currentPage: 1,
      hasMore: true,
    );

    await loadMentors();
  }

  Future<void> clearFilters() async {
    state = state.copyWith(
      clearExpertise: true,
      clearSearch: true,
      mentors: [],
      currentPage: 1,
      hasMore: true,
    );

    await loadMentors();
  }

  Future<void> refresh() async {
    await loadMentors(refresh: true);
  }
}

/// Provider for MentorsNotifier.
final mentorsProvider =
    StateNotifierProvider<MentorsNotifier, MentorsState>((ref) {
  final repository = ref.watch(mentorshipRepositoryProvider);
  return MentorsNotifier(repository);
});

/// Provider for single mentor detail.
final mentorDetailProvider =
    FutureProvider.family<Mentor?, String>((ref, id) async {
  final repository = ref.watch(mentorshipRepositoryProvider);
  final result = await repository.getMentorById(id);

  return switch (result) {
    MentorshipSuccess(:final data) => data,
    MentorshipFailure() => null,
  };
});

/// Provider for featured mentors.
final featuredMentorsProvider = FutureProvider<List<Mentor>>((ref) async {
  final repository = ref.watch(mentorshipRepositoryProvider);
  final result = await repository.getFeaturedMentors();

  return switch (result) {
    MentorshipSuccess(:final data) => data,
    MentorshipFailure() => [],
  };
});

/// Provider for remaining request quota.
final mentorshipQuotaProvider = FutureProvider<int>((ref) async {
  final repository = ref.watch(mentorshipRepositoryProvider);
  final result = await repository.getRemainingRequestQuota();

  return switch (result) {
    MentorshipSuccess(:final data) => data,
    MentorshipFailure() => 0,
  };
});

/// Provider for user's mentor profile.
final myMentorProfileProvider = FutureProvider<Mentor?>((ref) async {
  final repository = ref.watch(mentorshipRepositoryProvider);
  final result = await repository.getMyMentorProfile();

  return switch (result) {
    MentorshipSuccess(:final data) => data,
    MentorshipFailure() => null,
  };
});

/// State for mentorship requests.
class MentorshipRequestsState {
  const MentorshipRequestsState({
    this.sentRequests = const [],
    this.receivedRequests = const [],
    this.isLoadingSent = false,
    this.isLoadingReceived = false,
    this.errorSent,
    this.errorReceived,
  });

  final List<MentorshipRequest> sentRequests;
  final List<MentorshipRequest> receivedRequests;
  final bool isLoadingSent;
  final bool isLoadingReceived;
  final String? errorSent;
  final String? errorReceived;

  MentorshipRequestsState copyWith({
    List<MentorshipRequest>? sentRequests,
    List<MentorshipRequest>? receivedRequests,
    bool? isLoadingSent,
    bool? isLoadingReceived,
    String? errorSent,
    String? errorReceived,
  }) {
    return MentorshipRequestsState(
      sentRequests: sentRequests ?? this.sentRequests,
      receivedRequests: receivedRequests ?? this.receivedRequests,
      isLoadingSent: isLoadingSent ?? this.isLoadingSent,
      isLoadingReceived: isLoadingReceived ?? this.isLoadingReceived,
      errorSent: errorSent,
      errorReceived: errorReceived,
    );
  }

  int get pendingSentCount =>
      sentRequests.where((r) => r.isPending).length;

  int get pendingReceivedCount =>
      receivedRequests.where((r) => r.isPending).length;
}

/// Notifier for mentorship requests.
class MentorshipRequestsNotifier extends StateNotifier<MentorshipRequestsState> {
  MentorshipRequestsNotifier(this._repository)
      : super(const MentorshipRequestsState()) {
    loadRequests();
  }

  final MentorshipRepository _repository;

  Future<void> loadRequests() async {
    await Future.wait([
      loadSentRequests(),
      loadReceivedRequests(),
    ]);
  }

  Future<void> loadSentRequests() async {
    state = state.copyWith(isLoadingSent: true, errorSent: null);

    final result = await _repository.getSentRequests();

    switch (result) {
      case MentorshipSuccess(:final data):
        state = state.copyWith(
          sentRequests: data,
          isLoadingSent: false,
        );
      case MentorshipFailure(:final message):
        state = state.copyWith(
          isLoadingSent: false,
          errorSent: message,
        );
    }
  }

  Future<void> loadReceivedRequests() async {
    state = state.copyWith(isLoadingReceived: true, errorReceived: null);

    final result = await _repository.getReceivedRequests();

    switch (result) {
      case MentorshipSuccess(:final data):
        state = state.copyWith(
          receivedRequests: data,
          isLoadingReceived: false,
        );
      case MentorshipFailure(:final message):
        state = state.copyWith(
          isLoadingReceived: false,
          errorReceived: message,
        );
    }
  }

  Future<bool> cancelRequest(String requestId) async {
    final result = await _repository.cancelRequest(requestId);

    if (result is MentorshipSuccess) {
      state = state.copyWith(
        sentRequests: state.sentRequests
            .where((r) => r.id != requestId)
            .toList(),
      );
      return true;
    }
    return false;
  }

  Future<bool> acceptRequest(String requestId, {String? message}) async {
    final result = await _repository.acceptRequest(requestId, message: message);

    if (result is MentorshipSuccess) {
      await loadReceivedRequests();
      return true;
    }
    return false;
  }

  Future<bool> declineRequest(String requestId, {String? message}) async {
    final result = await _repository.declineRequest(requestId, message: message);

    if (result is MentorshipSuccess) {
      await loadReceivedRequests();
      return true;
    }
    return false;
  }
}

/// Provider for MentorshipRequestsNotifier.
final mentorshipRequestsProvider =
    StateNotifierProvider<MentorshipRequestsNotifier, MentorshipRequestsState>(
        (ref) {
  final repository = ref.watch(mentorshipRepositoryProvider);
  return MentorshipRequestsNotifier(repository);
});

/// Provider for active connections.
final mentorshipConnectionsProvider =
    FutureProvider<List<MentorshipConnection>>((ref) async {
  final repository = ref.watch(mentorshipRepositoryProvider);
  final result = await repository.getConnections();

  return switch (result) {
    MentorshipSuccess(:final data) => data,
    MentorshipFailure() => [],
  };
});

/// Sort options for mentors.
enum MentorSortOption {
  topRated('rating:desc', 'Top Rated'),
  mostExperienced('yearsExperience:desc', 'Most Experienced'),
  mostMentees('totalMentees:desc', 'Most Mentees'),
  newest('createdAt:desc', 'Newest');

  const MentorSortOption(this.value, this.label);
  final String value;
  final String label;
}
