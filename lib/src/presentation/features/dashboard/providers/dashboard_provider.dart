import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/providers/auth_provider.dart';
import '../../bookmarks/providers/bookmark_provider.dart';
import '../../events/providers/event_provider.dart';
import '../../profile/providers/subscription_provider.dart';

/// Dashboard stats aggregated from various providers.
class DashboardStats {
  const DashboardStats({
    this.bookmarksCount = 0,
    this.rsvpsCount = 0,
    this.subscriptionStatus = 'free',
    this.userName,
  });

  final int bookmarksCount;
  final int rsvpsCount;
  final String subscriptionStatus;
  final String? userName;

  DashboardStats copyWith({
    int? bookmarksCount,
    int? rsvpsCount,
    String? subscriptionStatus,
    String? userName,
  }) {
    return DashboardStats(
      bookmarksCount: bookmarksCount ?? this.bookmarksCount,
      rsvpsCount: rsvpsCount ?? this.rsvpsCount,
      subscriptionStatus: subscriptionStatus ?? this.subscriptionStatus,
      userName: userName ?? this.userName,
    );
  }
}

/// Provider for dashboard statistics.
final dashboardStatsProvider = Provider<DashboardStats>((ref) {
  // Get current user
  final user = ref.watch(currentUserProvider);
  final firstName = user?.name.split(' ').firstOrNull;

  // Get bookmarks count
  final bookmarksState = ref.watch(bookmarksProvider);
  final bookmarksCount = bookmarksState.bookmarks.length;

  // Get upcoming RSVPs count
  final rsvpsState = ref.watch(myRsvpsProvider);
  final rsvpsCount = rsvpsState.rsvps.where((r) {
    final eventDate = r.event.date;
    return eventDate.isAfter(DateTime.now());
  }).length;

  // Get subscription status from subscription provider
  final subscriptionState = ref.watch(subscriptionProvider);
  String subscriptionStatus = 'free';
  if (subscriptionState.isPaid) {
    subscriptionStatus = subscriptionState.subscription?.plan.value ?? 'monthly';
  } else if (subscriptionState.isTrial) {
    subscriptionStatus = 'trial';
  }

  return DashboardStats(
    bookmarksCount: bookmarksCount,
    rsvpsCount: rsvpsCount,
    subscriptionStatus: subscriptionStatus,
    userName: firstName,
  );
});
