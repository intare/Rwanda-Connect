import 'package:freezed_annotation/freezed_annotation.dart';

part 'opportunity.freezed.dart';

/// Domain entity representing an opportunity (job, investment, scholarship, tender).
@freezed
class Opportunity with _$Opportunity {
  const Opportunity._();

  const factory Opportunity({
    required String id,
    required OpportunityType type,
    required String title,
    required String company,
    required String location,
    required DateTime deadline,
    required bool verified,
    int? salary,
    String? applyUrl,
    String? description,
  }) = _Opportunity;

  /// Check if the opportunity deadline has passed.
  bool get isExpired => deadline.isBefore(DateTime.now());

  /// Get days until deadline.
  int get daysUntilDeadline => deadline.difference(DateTime.now()).inDays;
}

/// Types of opportunities available.
enum OpportunityType {
  job('job', 'Job'),
  investment('investment', 'Investment'),
  scholarship('scholarship', 'Scholarship'),
  tender('tender', 'Tender');

  const OpportunityType(this.value, this.label);

  /// API value for this type.
  final String value;

  /// Display label for this type.
  final String label;

  /// Parse from API string value.
  static OpportunityType fromString(String value) {
    return OpportunityType.values.firstWhere(
      (e) => e.value.toLowerCase() == value.toLowerCase(),
      orElse: () => OpportunityType.job,
    );
  }
}

/// Sort options for opportunities.
enum OpportunitySortOption {
  deadlineAsc('deadline:asc', 'Deadline (soonest)'),
  deadlineDesc('deadline:desc', 'Deadline (latest)'),
  datePostedDesc('datePosted:desc', 'Recently posted'),
  salaryDesc('salary:desc', 'Highest salary'),
  salaryAsc('salary:asc', 'Lowest salary'),
  titleAsc('title:asc', 'Title (A-Z)');

  const OpportunitySortOption(this.value, this.label);

  final String value;
  final String label;
}
