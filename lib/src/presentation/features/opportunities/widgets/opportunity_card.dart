import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';
import '../../../../domain/entities/opportunity.dart';

/// Card widget displaying an opportunity summary.
class OpportunityCard extends StatelessWidget {
  const OpportunityCard({
    super.key,
    required this.opportunity,
    this.onTap,
  });

  final Opportunity opportunity;
  final VoidCallback? onTap;

  String _formatSalary(int? salary) {
    if (salary == null) return '';
    if (salary >= 1000) {
      return '\$${(salary / 1000).toStringAsFixed(0)}k/year';
    }
    return '\$$salary/year';
  }

  String _formatDeadline(DateTime deadline) {
    final now = DateTime.now();
    final difference = deadline.difference(now).inDays;

    if (difference < 0) {
      return 'Expired';
    } else if (difference == 0) {
      return 'Due today';
    } else if (difference == 1) {
      return 'Tomorrow';
    } else if (difference < 7) {
      return '$difference days left';
    } else {
      return '${deadline.day}/${deadline.month}/${deadline.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isExpired = opportunity.isExpired;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row: Type badge + Verified + Deadline
              Row(
                children: [
                  // Type badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: _getTypeColor(opportunity.type).withValues(alpha: 0.1),
                      borderRadius: AppRadius.pillRadius,
                    ),
                    child: Text(
                      opportunity.type.label,
                      style: AppTypography.labelSmall.copyWith(
                        color: _getTypeColor(opportunity.type),
                      ),
                    ),
                  ),
                  if (opportunity.verified) ...[
                    const SizedBox(width: AppSpacing.sm),
                    const Icon(
                      Icons.verified,
                      size: AppSizes.iconSm,
                      color: AppColors.success,
                    ),
                  ],
                  const Spacer(),
                  // Deadline
                  Icon(
                    Icons.schedule,
                    size: AppSizes.iconSm,
                    color: isExpired ? AppColors.danger : AppColors.secondaryText,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    _formatDeadline(opportunity.deadline),
                    style: AppTypography.labelSmall.copyWith(
                      color: isExpired ? AppColors.danger : AppColors.secondaryText,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),

              // Title
              Text(
                opportunity.title,
                style: AppTypography.titleMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSpacing.xs),

              // Company
              Text(
                opportunity.company,
                style: AppTypography.bodyMediumSecondary,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSpacing.md),

              // Footer row: Location + Salary
              Row(
                children: [
                  // Location
                  const Icon(
                    Icons.location_on_outlined,
                    size: AppSizes.iconSm,
                    color: AppColors.secondaryText,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: Text(
                      opportunity.location,
                      style: AppTypography.bodySmallSecondary,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // Salary if available
                  if (opportunity.salary != null) ...[
                    const SizedBox(width: AppSpacing.md),
                    Text(
                      _formatSalary(opportunity.salary),
                      style: AppTypography.labelMedium.copyWith(
                        color: AppColors.accent,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getTypeColor(OpportunityType type) {
    return switch (type) {
      OpportunityType.job => AppColors.accent,
      OpportunityType.investment => AppColors.success,
      OpportunityType.scholarship => AppColors.warning,
      OpportunityType.tender => AppColors.info,
    };
  }
}
