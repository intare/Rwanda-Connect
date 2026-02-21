import 'package:freezed_annotation/freezed_annotation.dart';

part 'bid.freezed.dart';

/// Bid status enum.
enum BidStatus {
  pending('pending', 'Pending'),
  accepted('accepted', 'Accepted'),
  rejected('rejected', 'Rejected'),
  withdrawn('withdrawn', 'Withdrawn');

  const BidStatus(this.value, this.label);
  final String value;
  final String label;

  static BidStatus fromString(String value) {
    return BidStatus.values.firstWhere(
      (e) => e.value == value.toLowerCase(),
      orElse: () => BidStatus.pending,
    );
  }
}

/// Domain entity representing a bid on a property.
@freezed
class Bid with _$Bid {
  const Bid._();

  const factory Bid({
    required String id,
    required String propertyId,
    required String userId,
    required double amount,
    required BidStatus status,
    required DateTime createdAt,
    DateTime? updatedAt,
    String? propertyTitle,
    String? propertyImage,
    String? message,
  }) = _Bid;

  /// Get formatted amount.
  String get formattedAmount {
    if (amount >= 1000000) {
      return '\$${(amount / 1000000).toStringAsFixed(2)}M';
    } else if (amount >= 1000) {
      return '\$${(amount / 1000).toStringAsFixed(0)}K';
    }
    return '\$${amount.toStringAsFixed(0)}';
  }

  /// Get time ago string.
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays > 30) {
      return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  /// Check if bid is active (can be withdrawn).
  bool get isActive => status == BidStatus.pending;

  /// Check if bid was successful.
  bool get isAccepted => status == BidStatus.accepted;

  /// Get formatted date string.
  String get formattedDate {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[createdAt.month - 1]} ${createdAt.day}, ${createdAt.year}';
  }
}
