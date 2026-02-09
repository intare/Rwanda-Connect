import '../../domain/entities/opportunity.dart';
import '../models/opportunities/opportunity_dto.dart';

/// Mapper to convert between OpportunityDto and Opportunity domain entity.
extension OpportunityMapper on OpportunityDto {
  /// Convert DTO to domain entity.
  Opportunity toEntity() {
    return Opportunity(
      id: id.toString(),
      type: OpportunityType.fromString(type),
      title: title,
      company: company,
      location: location,
      deadline: deadline != null
          ? DateTime.tryParse(deadline!) ?? DateTime.now().add(const Duration(days: 30))
          : DateTime.now().add(const Duration(days: 30)),
      verified: verified ?? false,
      salary: salary,
      applyUrl: applyUrl,
      description: description,
    );
  }
}

/// Mapper to convert list of DTOs to entities.
extension OpportunityDtoListMapper on List<OpportunityDto> {
  /// Convert list of DTOs to domain entities.
  List<Opportunity> toEntities() {
    return map((dto) => dto.toEntity()).toList();
  }
}
