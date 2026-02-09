import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/theme/theme.dart';

/// Shimmer loading placeholder for opportunities list.
class OpportunityShimmerList extends StatelessWidget {
  const OpportunityShimmerList({super.key, this.itemCount = 5});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.horizontalLg,
      child: Column(
        children: List.generate(
          itemCount,
          (index) => const Padding(
            padding: EdgeInsets.only(bottom: AppSpacing.md),
            child: OpportunityShimmerCard(),
          ),
        ),
      ),
    );
  }
}

/// Single shimmer card for opportunity loading state.
class OpportunityShimmerCard extends StatelessWidget {
  const OpportunityShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Shimmer.fromColors(
        baseColor: AppColors.shimmerBase,
        highlightColor: AppColors.shimmerHighlight,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row
              Row(
                children: [
                  // Type badge placeholder
                  Container(
                    width: 60,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: AppRadius.pillRadius,
                    ),
                  ),
                  const Spacer(),
                  // Deadline placeholder
                  Container(
                    width: 80,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: AppRadius.cardRadius,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),

              // Title placeholder
              Container(
                width: double.infinity,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: AppRadius.cardRadius,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),

              // Title second line placeholder
              Container(
                width: 200,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: AppRadius.cardRadius,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),

              // Company placeholder
              Container(
                width: 150,
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: AppRadius.cardRadius,
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // Footer row
              Row(
                children: [
                  // Location placeholder
                  Container(
                    width: 120,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: AppRadius.cardRadius,
                    ),
                  ),
                  const Spacer(),
                  // Salary placeholder
                  Container(
                    width: 70,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: AppRadius.cardRadius,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
