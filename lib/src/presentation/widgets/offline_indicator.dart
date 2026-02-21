import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/connectivity_service.dart';
import '../../core/theme/theme.dart';

/// A banner that shows when the app is offline.
class OfflineBanner extends ConsumerWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectivityService = ref.watch(connectivityServiceProvider);

    // Initial check
    if (connectivityService.isOnline) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      color: AppColors.warning,
      child: SafeArea(
        bottom: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.cloud_off,
              size: 16,
              color: Colors.white,
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              'You\'re offline. Showing cached data.',
              style: AppTypography.labelMedium.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A widget that listens to connectivity changes and shows a snackbar.
class ConnectivityListener extends ConsumerStatefulWidget {
  const ConnectivityListener({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  ConsumerState<ConnectivityListener> createState() =>
      _ConnectivityListenerState();
}

class _ConnectivityListenerState extends ConsumerState<ConnectivityListener> {
  bool _wasOffline = false;

  @override
  void initState() {
    super.initState();
    _setupListener();
  }

  void _setupListener() {
    final service = ref.read(connectivityServiceProvider);
    _wasOffline = service.isOffline;

    service.statusStream.listen((status) {
      if (!mounted) return;

      if (status == ConnectivityStatus.online && _wasOffline) {
        // Back online
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.cloud_done, color: Colors.white, size: 18),
                SizedBox(width: 8),
                Text('Back online'),
              ],
            ),
            backgroundColor: AppColors.success,
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else if (status == ConnectivityStatus.offline && !_wasOffline) {
        // Went offline
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.cloud_off, color: Colors.white, size: 18),
                SizedBox(width: 8),
                Text('You\'re offline'),
              ],
            ),
            backgroundColor: AppColors.warning,
            duration: const Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }

      _wasOffline = status == ConnectivityStatus.offline;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

/// A small indicator chip showing cached data status.
class CachedDataIndicator extends StatelessWidget {
  const CachedDataIndicator({
    super.key,
    this.label = 'Cached',
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: AppColors.warning.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.cloud_off,
            size: 12,
            color: AppColors.warning,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTypography.labelSmall.copyWith(
              color: AppColors.warning,
            ),
          ),
        ],
      ),
    );
  }
}
