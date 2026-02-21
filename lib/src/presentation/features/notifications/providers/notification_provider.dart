import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/services/local_notification_service.dart';
import '../../../../domain/entities/app_notification.dart';
import '../../../../domain/entities/notification_preferences.dart';

/// State for notifications.
class NotificationsState {
  const NotificationsState({
    this.notifications = const [],
    this.isLoading = false,
    this.unreadCount = 0,
  });

  final List<AppNotification> notifications;
  final bool isLoading;
  final int unreadCount;

  NotificationsState copyWith({
    List<AppNotification>? notifications,
    bool? isLoading,
    int? unreadCount,
  }) {
    return NotificationsState(
      notifications: notifications ?? this.notifications,
      isLoading: isLoading ?? this.isLoading,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }
}

/// Notifier for managing notifications.
class NotificationsNotifier extends StateNotifier<NotificationsState> {
  NotificationsNotifier(this._service) : super(const NotificationsState()) {
    loadNotifications();
  }

  final LocalNotificationService _service;

  /// Load notifications from storage.
  Future<void> loadNotifications() async {
    state = state.copyWith(isLoading: true);

    final notifications = await _service.getNotificationHistory();
    final unreadCount = await _service.getUnreadCount();

    state = state.copyWith(
      notifications: notifications,
      isLoading: false,
      unreadCount: unreadCount,
    );
  }

  /// Mark a notification as read.
  Future<void> markAsRead(String notificationId) async {
    await _service.markAsRead(notificationId);

    final updated = state.notifications.map((n) {
      if (n.id == notificationId) {
        return n.copyWith(isRead: true);
      }
      return n;
    }).toList();

    final unreadCount = updated.where((n) => !n.isRead).length;
    state = state.copyWith(notifications: updated, unreadCount: unreadCount);
  }

  /// Mark all notifications as read.
  Future<void> markAllAsRead() async {
    await _service.markAllAsRead();

    final updated = state.notifications.map((n) => n.copyWith(isRead: true)).toList();
    state = state.copyWith(notifications: updated, unreadCount: 0);
  }

  /// Clear all notifications.
  Future<void> clearAll() async {
    await _service.clearHistory();
    state = state.copyWith(notifications: [], unreadCount: 0);
  }

  /// Refresh unread count.
  Future<void> refreshUnreadCount() async {
    final unreadCount = await _service.getUnreadCount();
    state = state.copyWith(unreadCount: unreadCount);
  }
}

/// Provider for NotificationsNotifier.
final notificationsProvider =
    StateNotifierProvider<NotificationsNotifier, NotificationsState>((ref) {
  final service = ref.watch(localNotificationServiceProvider);
  return NotificationsNotifier(service);
});

/// Provider for unread notification count.
final unreadNotificationCountProvider = Provider<int>((ref) {
  return ref.watch(notificationsProvider).unreadCount;
});

/// State for notification preferences.
class NotificationPreferencesState {
  const NotificationPreferencesState({
    this.preferences = const NotificationPreferences(),
    this.isSaving = false,
  });

  final NotificationPreferences preferences;
  final bool isSaving;

  NotificationPreferencesState copyWith({
    NotificationPreferences? preferences,
    bool? isSaving,
  }) {
    return NotificationPreferencesState(
      preferences: preferences ?? this.preferences,
      isSaving: isSaving ?? this.isSaving,
    );
  }
}

/// Notifier for managing notification preferences.
class NotificationPreferencesNotifier
    extends StateNotifier<NotificationPreferencesState> {
  NotificationPreferencesNotifier(this._service)
      : super(const NotificationPreferencesState()) {
    _loadPreferences();
  }

  final LocalNotificationService _service;

  void _loadPreferences() {
    final prefs = _service.getPreferences();
    state = state.copyWith(preferences: prefs);
  }

  /// Update push notification preference.
  Future<void> setPushEnabled(bool enabled) async {
    if (enabled) {
      // Request permissions when enabling
      final granted = await _service.requestPermissions();
      if (!granted) return;
    }

    final updated = state.preferences.copyWith(pushEnabled: enabled);
    await _savePreferences(updated);
  }

  /// Update email notification preference.
  Future<void> setEmailEnabled(bool enabled) async {
    final updated = state.preferences.copyWith(emailEnabled: enabled);
    await _savePreferences(updated);
  }

  /// Update opportunity alerts preference.
  Future<void> setOpportunityAlerts(bool enabled) async {
    final updated = state.preferences.copyWith(opportunityAlerts: enabled);
    await _savePreferences(updated);
  }

  /// Update event reminders preference.
  Future<void> setEventReminders(bool enabled) async {
    final updated = state.preferences.copyWith(eventReminders: enabled);
    await _savePreferences(updated);
  }

  /// Update community updates preference.
  Future<void> setCommunityUpdates(bool enabled) async {
    final updated = state.preferences.copyWith(communityUpdates: enabled);
    await _savePreferences(updated);
  }

  /// Update subscription alerts preference.
  Future<void> setSubscriptionAlerts(bool enabled) async {
    final updated = state.preferences.copyWith(subscriptionAlerts: enabled);
    await _savePreferences(updated);
  }

  Future<void> _savePreferences(NotificationPreferences preferences) async {
    state = state.copyWith(isSaving: true);
    await _service.savePreferences(preferences);
    state = state.copyWith(preferences: preferences, isSaving: false);
  }
}

/// Provider for NotificationPreferencesNotifier.
final notificationPreferencesProvider = StateNotifierProvider<
    NotificationPreferencesNotifier, NotificationPreferencesState>((ref) {
  final service = ref.watch(localNotificationServiceProvider);
  return NotificationPreferencesNotifier(service);
});
