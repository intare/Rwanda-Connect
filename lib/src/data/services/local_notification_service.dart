import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../domain/entities/app_notification.dart';
import '../../domain/entities/notification_preferences.dart';

/// Service for managing local notifications.
class LocalNotificationService {
  LocalNotificationService(this._prefs);

  final SharedPreferences _prefs;
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static const _prefsKey = 'notification_preferences';
  static const _notificationsKey = 'notifications_history';
  static const _maxStoredNotifications = 50;

  bool _isInitialized = false;

  /// Initialize the notification service.
  Future<void> initialize() async {
    if (_isInitialized) return;

    // Initialize timezone
    tz.initializeTimeZones();

    // Android initialization settings
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS initialization settings
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );

    _isInitialized = true;
  }

  /// Handle notification tap.
  void _onNotificationTap(NotificationResponse response) {
    // Handle notification tap - can navigate to specific screen based on payload
    if (response.payload != null) {
      debugPrint('Notification tapped with payload: ${response.payload}');
    }
  }

  /// Request notification permissions.
  Future<bool> requestPermissions() async {
    if (Platform.isIOS) {
      final iosPlugin = _plugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>();
      final granted = await iosPlugin?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      return granted ?? false;
    } else if (Platform.isAndroid) {
      final androidPlugin = _plugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      final granted = await androidPlugin?.requestNotificationsPermission();
      return granted ?? false;
    }
    return true;
  }

  /// Check if notifications are permitted.
  Future<bool> areNotificationsEnabled() async {
    if (Platform.isAndroid) {
      final androidPlugin = _plugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      return await androidPlugin?.areNotificationsEnabled() ?? false;
    }
    return true;
  }

  /// Show a local notification.
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
    NotificationType type = NotificationType.system,
  }) async {
    final prefs = getPreferences();
    if (!prefs.pushEnabled) return;

    // Check type-specific preferences
    switch (type) {
      case NotificationType.opportunity:
        if (!prefs.opportunityAlerts) return;
        break;
      case NotificationType.event:
        if (!prefs.eventReminders) return;
        break;
      case NotificationType.community:
        if (!prefs.communityUpdates) return;
        break;
      case NotificationType.subscription:
        if (!prefs.subscriptionAlerts) return;
        break;
      case NotificationType.system:
        // System notifications are always allowed if push is enabled
        break;
    }

    const androidDetails = AndroidNotificationDetails(
      'rwanda_connect_default',
      'General Notifications',
      channelDescription: 'General app notifications',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _plugin.show(id, title, body, details, payload: payload);

    // Store notification in history
    await _storeNotification(
      AppNotification(
        id: id.toString(),
        title: title,
        body: body,
        type: type,
        createdAt: DateTime.now(),
        data: payload != null ? {'payload': payload} : null,
      ),
    );
  }

  /// Schedule a notification for later.
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
    String? payload,
    NotificationType type = NotificationType.system,
  }) async {
    final prefs = getPreferences();
    if (!prefs.pushEnabled) return;

    const androidDetails = AndroidNotificationDetails(
      'rwanda_connect_scheduled',
      'Scheduled Notifications',
      channelDescription: 'Scheduled reminders and alerts',
      importance: Importance.high,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _plugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
    );
  }

  /// Cancel a scheduled notification.
  Future<void> cancelNotification(int id) async {
    await _plugin.cancel(id);
  }

  /// Cancel all notifications.
  Future<void> cancelAllNotifications() async {
    await _plugin.cancelAll();
  }

  // ==================== Preferences ====================

  /// Get notification preferences.
  NotificationPreferences getPreferences() {
    final json = _prefs.getString(_prefsKey);
    if (json != null) {
      try {
        return NotificationPreferences.fromJson(jsonDecode(json));
      } catch (_) {
        return const NotificationPreferences();
      }
    }
    return const NotificationPreferences();
  }

  /// Save notification preferences.
  Future<void> savePreferences(NotificationPreferences preferences) async {
    await _prefs.setString(_prefsKey, jsonEncode(preferences.toJson()));
  }

  // ==================== Notification History ====================

  /// Store a notification in history.
  Future<void> _storeNotification(AppNotification notification) async {
    final notifications = await getNotificationHistory();
    notifications.insert(0, notification);

    // Keep only the most recent notifications
    final trimmed = notifications.take(_maxStoredNotifications).toList();

    final jsonList = trimmed.map((n) => _notificationToJson(n)).toList();
    await _prefs.setString(_notificationsKey, jsonEncode(jsonList));
  }

  /// Get notification history.
  Future<List<AppNotification>> getNotificationHistory() async {
    final json = _prefs.getString(_notificationsKey);
    if (json != null) {
      try {
        final list = jsonDecode(json) as List;
        return list
            .map((item) => _notificationFromJson(item as Map<String, dynamic>))
            .toList();
      } catch (_) {
        return [];
      }
    }
    return [];
  }

  /// Mark notification as read.
  Future<void> markAsRead(String notificationId) async {
    final notifications = await getNotificationHistory();
    final index = notifications.indexWhere((n) => n.id == notificationId);
    if (index != -1) {
      final updated = notifications[index].copyWith(isRead: true);
      notifications[index] = updated;

      final jsonList = notifications.map((n) => _notificationToJson(n)).toList();
      await _prefs.setString(_notificationsKey, jsonEncode(jsonList));
    }
  }

  /// Mark all notifications as read.
  Future<void> markAllAsRead() async {
    final notifications = await getNotificationHistory();
    final updated = notifications.map((n) => n.copyWith(isRead: true)).toList();

    final jsonList = updated.map((n) => _notificationToJson(n)).toList();
    await _prefs.setString(_notificationsKey, jsonEncode(jsonList));
  }

  /// Clear notification history.
  Future<void> clearHistory() async {
    await _prefs.remove(_notificationsKey);
  }

  /// Get unread count.
  Future<int> getUnreadCount() async {
    final notifications = await getNotificationHistory();
    return notifications.where((n) => !n.isRead).length;
  }

  // ==================== JSON Serialization ====================

  Map<String, dynamic> _notificationToJson(AppNotification notification) {
    return {
      'id': notification.id,
      'title': notification.title,
      'body': notification.body,
      'type': notification.type.name,
      'createdAt': notification.createdAt.toIso8601String(),
      'isRead': notification.isRead,
      'actionUrl': notification.actionUrl,
      'imageUrl': notification.imageUrl,
      'data': notification.data,
    };
  }

  AppNotification _notificationFromJson(Map<String, dynamic> json) {
    return AppNotification(
      id: json['id'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      type: NotificationType.values.firstWhere(
        (t) => t.name == json['type'],
        orElse: () => NotificationType.system,
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      isRead: json['isRead'] as bool? ?? false,
      actionUrl: json['actionUrl'] as String?,
      imageUrl: json['imageUrl'] as String?,
      data: json['data'] as Map<String, dynamic>?,
    );
  }
}

/// Provider for SharedPreferences.
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Must be overridden in ProviderScope');
});

/// Provider for LocalNotificationService.
final localNotificationServiceProvider = Provider<LocalNotificationService>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return LocalNotificationService(prefs);
});
