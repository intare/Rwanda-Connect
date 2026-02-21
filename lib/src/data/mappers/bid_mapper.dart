import '../../domain/entities/bid.dart';
import '../models/properties/bid_dto.dart';

/// Mapper to convert between BidDto and Bid domain entity.
extension BidMapper on BidDto {
  /// Convert DTO to domain entity.
  Bid toEntity() {
    return Bid(
      id: id.toString(),
      propertyId: propertyId,
      userId: userId,
      amount: amount,
      status: BidStatus.fromString(status),
      createdAt: DateTime.parse(createdAt),
      updatedAt: updatedAt != null ? DateTime.tryParse(updatedAt!) : null,
      propertyTitle: propertyTitle,
      propertyImage: propertyImage,
      message: message,
    );
  }
}

/// Mapper to convert list of DTOs to entities.
extension BidDtoListMapper on List<BidDto> {
  /// Convert list of DTOs to domain entities.
  List<Bid> toEntities() {
    return map((dto) => dto.toEntity()).toList();
  }
}

/// Helper class for creating BidDto from various sources.
class BidDtoMapper {
  /// Create BidDto from JSON map.
  static BidDto fromJson(Map<String, dynamic> json) {
    return BidDto.fromJson(json);
  }
}
