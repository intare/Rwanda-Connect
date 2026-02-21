import '../../core/network/api_endpoints.dart';
import '../../domain/entities/mentorship.dart';
import '../models/mentorship/mentorship_dto.dart';

/// Extension to convert MentorDto to Mentor entity.
extension MentorDtoMapper on MentorDto {
  Mentor toEntity() {
    // Parse avatar URL
    String? avatarUrl;
    if (avatar != null) {
      if (avatar is Map<String, dynamic>) {
        final url = avatar['url'] as String?;
        if (url != null) {
          avatarUrl = url.startsWith('http') ? url : '${ApiEndpoints.serverUrl}$url';
        }
      } else if (avatar is String) {
        avatarUrl = avatar.startsWith('http') ? avatar : '${ApiEndpoints.serverUrl}$avatar';
      }
    }

    return Mentor(
      id: id.toString(),
      userId: userId,
      name: name,
      avatar: avatarUrl,
      title: title,
      company: company,
      bio: bio,
      expertise: expertise.map((e) => MentorExpertise.fromString(e)).toList(),
      yearsExperience: yearsExperience,
      linkedinUrl: linkedinUrl,
      location: location,
      languages: languages,
      isAvailable: isAvailable,
      totalMentees: totalMentees,
      rating: rating,
      reviewCount: reviewCount,
      createdAt: createdAt != null ? DateTime.tryParse(createdAt!) : null,
    );
  }
}

/// Extension to convert list of MentorDto to list of Mentor.
extension MentorDtoListMapper on List<MentorDto> {
  List<Mentor> toEntities() {
    return map((dto) => dto.toEntity()).toList();
  }
}

/// Extension to convert MentorshipRequestDto to MentorshipRequest entity.
extension MentorshipRequestDtoMapper on MentorshipRequestDto {
  MentorshipRequest toEntity() {
    // Parse mentor info
    String mentorId;
    String? mentorName;
    String? mentorAvatar;
    String? mentorTitle;

    if (mentor is Map<String, dynamic>) {
      final mentorMap = mentor as Map<String, dynamic>;
      mentorId = mentorMap['id']?.toString() ?? '';
      mentorName = mentorMap['name'] as String?;
      mentorTitle = mentorMap['title'] as String?;

      final avatar = mentorMap['avatar'];
      if (avatar is Map<String, dynamic>) {
        final url = avatar['url'] as String?;
        if (url != null) {
          mentorAvatar = url.startsWith('http') ? url : '${ApiEndpoints.serverUrl}$url';
        }
      } else if (avatar is String) {
        mentorAvatar = avatar.startsWith('http') ? avatar : '${ApiEndpoints.serverUrl}$avatar';
      }
    } else {
      mentorId = mentor.toString();
    }

    // Parse mentee info
    String menteeId;
    String? menteeName;
    String? menteeAvatar;

    if (mentee is Map<String, dynamic>) {
      final menteeMap = mentee as Map<String, dynamic>;
      menteeId = menteeMap['id']?.toString() ?? '';
      menteeName = menteeMap['name'] as String?;

      final avatar = menteeMap['avatar'];
      if (avatar is Map<String, dynamic>) {
        final url = avatar['url'] as String?;
        if (url != null) {
          menteeAvatar = url.startsWith('http') ? url : '${ApiEndpoints.serverUrl}$url';
        }
      } else if (avatar is String) {
        menteeAvatar = avatar.startsWith('http') ? avatar : '${ApiEndpoints.serverUrl}$avatar';
      }
    } else {
      menteeId = mentee.toString();
    }

    return MentorshipRequest(
      id: id.toString(),
      mentorId: mentorId,
      menteeId: menteeId,
      status: MentorshipRequestStatus.fromString(status),
      message: message,
      mentorName: mentorName,
      mentorAvatar: mentorAvatar,
      mentorTitle: mentorTitle,
      menteeName: menteeName,
      menteeAvatar: menteeAvatar,
      responseMessage: responseMessage,
      createdAt: DateTime.tryParse(createdAt) ?? DateTime.now(),
      respondedAt: respondedAt != null ? DateTime.tryParse(respondedAt!) : null,
    );
  }
}

/// Extension to convert list of MentorshipRequestDto to list of MentorshipRequest.
extension MentorshipRequestDtoListMapper on List<MentorshipRequestDto> {
  List<MentorshipRequest> toEntities() {
    return map((dto) => dto.toEntity()).toList();
  }
}

/// Extension to convert MentorshipConnectionDto to MentorshipConnection entity.
extension MentorshipConnectionDtoMapper on MentorshipConnectionDto {
  MentorshipConnection toEntity() {
    // Parse mentor
    Mentor mentorEntity;
    if (mentor is Map<String, dynamic>) {
      mentorEntity = MentorDto.fromJson(mentor as Map<String, dynamic>).toEntity();
    } else {
      mentorEntity = Mentor(
        id: mentor.toString(),
        userId: '',
        name: 'Unknown Mentor',
        expertise: [],
      );
    }

    // Parse mentee info
    String menteeId;
    String? menteeName;
    String? menteeAvatar;

    if (mentee is Map<String, dynamic>) {
      final menteeMap = mentee as Map<String, dynamic>;
      menteeId = menteeMap['id']?.toString() ?? '';
      menteeName = menteeMap['name'] as String?;

      final avatar = menteeMap['avatar'];
      if (avatar is Map<String, dynamic>) {
        final url = avatar['url'] as String?;
        if (url != null) {
          menteeAvatar = url.startsWith('http') ? url : '${ApiEndpoints.serverUrl}$url';
        }
      } else if (avatar is String) {
        menteeAvatar = avatar.startsWith('http') ? avatar : '${ApiEndpoints.serverUrl}$avatar';
      }
    } else {
      menteeId = mentee.toString();
    }

    return MentorshipConnection(
      id: id.toString(),
      mentorId: mentorEntity.id,
      menteeId: menteeId,
      mentor: mentorEntity,
      menteeName: menteeName,
      menteeAvatar: menteeAvatar,
      startedAt: DateTime.tryParse(startedAt) ?? DateTime.now(),
      endedAt: endedAt != null ? DateTime.tryParse(endedAt!) : null,
      isActive: isActive,
      notes: notes,
    );
  }
}

/// Extension to convert list of MentorshipConnectionDto to list of MentorshipConnection.
extension MentorshipConnectionDtoListMapper on List<MentorshipConnectionDto> {
  List<MentorshipConnection> toEntities() {
    return map((dto) => dto.toEntity()).toList();
  }
}
