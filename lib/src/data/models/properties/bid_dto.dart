import 'package:freezed_annotation/freezed_annotation.dart';

part 'bid_dto.freezed.dart';
part 'bid_dto.g.dart';

/// Data transfer object for Bid from API.
@freezed
class BidDto with _$BidDto {
  const factory BidDto({
    required dynamic id,
    required String propertyId,
    required String userId,
    required double amount,
    @Default('pending') String status,
    required String createdAt,
    String? updatedAt,
    String? propertyTitle,
    String? propertyImage,
    String? message,
  }) = _BidDto;

  factory BidDto.fromJson(Map<String, dynamic> json) => _$BidDtoFromJson(json);
}

/// Response for bids list.
@freezed
class BidsListResponse with _$BidsListResponse {
  const factory BidsListResponse({
    required List<BidDto> docs,
    required int totalDocs,
    required int limit,
    required int page,
    required int totalPages,
    required bool hasNextPage,
    required bool hasPrevPage,
  }) = _BidsListResponse;

  factory BidsListResponse.fromJson(Map<String, dynamic> json) =>
      _$BidsListResponseFromJson(json);
}

/// Extension to get list of bids and hasNext flag.
extension BidsListResponseX on BidsListResponse {
  List<BidDto> get bids => docs;
  bool get hasNext => hasNextPage;
}

/// Request to place a bid.
@freezed
class PlaceBidRequest with _$PlaceBidRequest {
  const factory PlaceBidRequest({
    required double amount,
    String? message,
  }) = _PlaceBidRequest;

  factory PlaceBidRequest.fromJson(Map<String, dynamic> json) =>
      _$PlaceBidRequestFromJson(json);
}
