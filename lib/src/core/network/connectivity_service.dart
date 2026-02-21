import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Service for monitoring network connectivity.
class ConnectivityService {
  ConnectivityService() {
    _init();
  }

  final Connectivity _connectivity = Connectivity();
  final _controller = StreamController<ConnectivityStatus>.broadcast();

  ConnectivityStatus _currentStatus = ConnectivityStatus.unknown;
  bool _initialCheckDone = false;

  /// Stream of connectivity status changes.
  Stream<ConnectivityStatus> get statusStream => _controller.stream;

  /// Current connectivity status.
  ConnectivityStatus get currentStatus => _currentStatus;

  /// Whether the initial connectivity check has completed.
  bool get isInitialized => _initialCheckDone;

  /// Whether the device is currently online.
  /// Returns true for unknown status (assume online until proven offline).
  bool get isOnline => _currentStatus != ConnectivityStatus.offline;

  /// Whether the device is currently offline (confirmed offline only).
  bool get isOffline => _currentStatus == ConnectivityStatus.offline;

  void _init() {
    // Check initial status
    checkConnectivity();

    // Listen to changes
    _connectivity.onConnectivityChanged.listen((results) {
      _updateStatus(results);
    });
  }

  /// Check current connectivity status.
  Future<ConnectivityStatus> checkConnectivity() async {
    final results = await _connectivity.checkConnectivity();
    _updateStatus(results);
    _initialCheckDone = true;
    return _currentStatus;
  }

  void _updateStatus(List<ConnectivityResult> results) {
    final newStatus = _mapToStatus(results);
    if (newStatus != _currentStatus) {
      _currentStatus = newStatus;
      _controller.add(newStatus);
    }
  }

  ConnectivityStatus _mapToStatus(List<ConnectivityResult> results) {
    if (results.contains(ConnectivityResult.none) || results.isEmpty) {
      return ConnectivityStatus.offline;
    }
    return ConnectivityStatus.online;
  }

  /// Dispose of resources.
  void dispose() {
    _controller.close();
  }
}

/// Connectivity status.
enum ConnectivityStatus {
  online,
  offline,
  unknown,
}

/// Provider for ConnectivityService.
final connectivityServiceProvider = Provider<ConnectivityService>((ref) {
  final service = ConnectivityService();
  ref.onDispose(() => service.dispose());
  return service;
});

/// Provider for current connectivity status.
final connectivityStatusProvider = StreamProvider<ConnectivityStatus>((ref) {
  final service = ref.watch(connectivityServiceProvider);
  return service.statusStream;
});

/// Provider for checking if online.
final isOnlineProvider = Provider<bool>((ref) {
  final service = ref.watch(connectivityServiceProvider);
  return service.isOnline;
});
