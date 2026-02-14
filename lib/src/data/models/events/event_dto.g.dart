// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventDto _$EventDtoFromJson(Map<String, dynamic> json) => EventDto(
  id: json['id'],
  title: json['title'] as String,
  location: json['location'] as String,
  date: json['date'] as String,
  type: json['type'] as String,
  organizer: json['organizer'] as String,
  description: json['description'],
  venue: json['venue'] as String?,
  endDate: json['endDate'] as String?,
  capacity: (json['capacity'] as num?)?.toInt(),
  price: (json['price'] as num?)?.toDouble(),
  currency: json['currency'] as String?,
  isVirtual: json['isVirtual'] as bool?,
  virtualLink: json['virtualLink'] as String?,
  registrationUrl: json['registrationUrl'] as String?,
  isFeatured: json['isFeatured'] as bool?,
  image: json['image'],
  tags: json['tags'] as List<dynamic>?,
);

Map<String, dynamic> _$EventDtoToJson(EventDto instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'location': instance.location,
  'date': instance.date,
  'type': instance.type,
  'organizer': instance.organizer,
  'description': instance.description,
  'venue': instance.venue,
  'endDate': instance.endDate,
  'capacity': instance.capacity,
  'price': instance.price,
  'currency': instance.currency,
  'isVirtual': instance.isVirtual,
  'virtualLink': instance.virtualLink,
  'registrationUrl': instance.registrationUrl,
  'isFeatured': instance.isFeatured,
  'image': instance.image,
  'tags': instance.tags,
};

RsvpResponseDto _$RsvpResponseDtoFromJson(Map<String, dynamic> json) =>
    RsvpResponseDto(
      eventId: json['eventId'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$RsvpResponseDtoToJson(RsvpResponseDto instance) =>
    <String, dynamic>{'eventId': instance.eventId, 'status': instance.status};
