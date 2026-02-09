import '../../domain/entities/event.dart';
import '../models/events/event_dto.dart';

/// Extension to convert EventDto to Event entity.
extension EventDtoMapper on EventDto {
  Event toEntity() {
    return Event(
      id: id.toString(),
      title: title,
      location: location,
      date: DateTime.tryParse(date) ?? DateTime.now(),
      type: EventType.fromString(type),
      organizer: organizer,
      rsvpCount: 0, // RSVP count not returned in Payload response by default
      description: description,
      imageUrl: _getImageUrl(),
    );
  }

  String? _getImageUrl() {
    if (image == null) return null;
    if (image is Map<String, dynamic>) {
      return image['url'] as String?;
    }
    return null;
  }
}

/// Extension to convert list of EventDto to list of Event entities.
extension EventDtoListMapper on List<EventDto> {
  List<Event> toEntities() {
    return map((dto) => dto.toEntity()).toList();
  }
}
