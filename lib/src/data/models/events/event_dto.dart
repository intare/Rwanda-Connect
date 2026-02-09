import 'package:json_annotation/json_annotation.dart';

part 'event_dto.g.dart';

/// Data transfer object for Event from Payload CMS API.
@JsonSerializable()
class EventDto {
  const EventDto({
    required this.id,
    required this.title,
    required this.location,
    required this.date,
    required this.type,
    required this.organizer,
    this.description,
    this.venue,
    this.endDate,
    this.capacity,
    this.price,
    this.currency,
    this.isVirtual,
    this.virtualLink,
    this.registrationUrl,
    this.isFeatured,
    this.image,
    this.tags,
  });

  final dynamic id; // Can be int or String from Payload
  final String title;
  final String location;
  final String date;
  final String type;
  final String organizer;
  final String? description;
  final String? venue;
  final String? endDate;
  final int? capacity;
  final double? price;
  final String? currency;
  final bool? isVirtual;
  final String? virtualLink;
  final String? registrationUrl;
  final bool? isFeatured;
  final dynamic image; // Can be object or ID
  final List<dynamic>? tags;

  String get idString => id.toString();

  factory EventDto.fromJson(Map<String, dynamic> json) =>
      _$EventDtoFromJson(json);

  Map<String, dynamic> toJson() => _$EventDtoToJson(this);
}

/// Response from RSVP API.
@JsonSerializable()
class RsvpResponseDto {
  const RsvpResponseDto({
    required this.eventId,
    required this.status,
  });

  final String eventId;
  final String status;

  factory RsvpResponseDto.fromJson(Map<String, dynamic> json) =>
      _$RsvpResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RsvpResponseDtoToJson(this);
}
