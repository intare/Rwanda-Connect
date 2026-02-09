import 'package:freezed_annotation/freezed_annotation.dart';

part 'event.freezed.dart';

/// Domain entity representing an event.
@freezed
class Event with _$Event {
  const Event._();

  const factory Event({
    required String id,
    required String title,
    required String location,
    required DateTime date,
    required EventType type,
    required String organizer,
    required int rsvpCount,
    String? description,
    String? imageUrl,
  }) = _Event;

  /// Check if the event has already passed.
  bool get isPast => date.isBefore(DateTime.now());

  /// Check if the event is happening today.
  bool get isToday {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// Get days until the event.
  int get daysUntilEvent => date.difference(DateTime.now()).inDays;
}

/// Types of events available.
enum EventType {
  networking('networking', 'Networking'),
  seminar('seminar', 'Seminar'),
  workshop('workshop', 'Workshop'),
  conference('conference', 'Conference');

  const EventType(this.value, this.label);

  /// API value for this type.
  final String value;

  /// Display label for this type.
  final String label;

  /// Parse from API string value.
  static EventType fromString(String value) {
    return EventType.values.firstWhere(
      (e) => e.value.toLowerCase() == value.toLowerCase(),
      orElse: () => EventType.networking,
    );
  }
}

/// Sort options for events.
enum EventSortOption {
  dateAsc('date:asc', 'Date (soonest)'),
  dateDesc('date:desc', 'Date (latest)'),
  rsvpDesc('rsvpCount:desc', 'Most popular'),
  titleAsc('title:asc', 'Title (A-Z)');

  const EventSortOption(this.value, this.label);

  final String value;
  final String label;
}

/// RSVP status for events.
enum RsvpStatus {
  going('going', 'Going'),
  interested('interested', 'Interested'),
  notGoing('not_going', 'Not Going');

  const RsvpStatus(this.value, this.label);

  final String value;
  final String label;

  static RsvpStatus fromString(String value) {
    return RsvpStatus.values.firstWhere(
      (e) => e.value.toLowerCase() == value.toLowerCase(),
      orElse: () => RsvpStatus.interested,
    );
  }
}
