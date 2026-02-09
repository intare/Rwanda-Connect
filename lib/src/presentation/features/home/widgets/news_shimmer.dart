import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/theme/theme.dart';

/// Shimmer loading placeholder for news list.
class NewsShimmerList extends StatelessWidget {
  const NewsShimmerList({
    this.itemCount = 5,
    super.key,
  });

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
            child: NewsShimmerCard(),
          ),
        ),
      ),
    );
  }
}

/// Shimmer loading placeholder for a single news card.
class NewsShimmerCard extends StatelessWidget {
  const NewsShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Shimmer.fromColors(
        baseColor: AppColors.border,
        highlightColor: AppColors.surface,
        child: Padding(
          padding: AppSpacing.paddingLg,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row
              Row(
                children: [
                  Container(
                    width: 70,
                    height: 24,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: AppRadius.pillRadius,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: 80,
                    height: 16,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: AppRadius.pillRadius,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),

              // Title
              Container(
                width: double.infinity,
                height: 20,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: AppRadius.cardRadius,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Container(
                width: 200,
                height: 20,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: AppRadius.cardRadius,
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // Summary
              Container(
                width: double.infinity,
                height: 16,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: AppRadius.cardRadius,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Container(
                width: 250,
                height: 16,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: AppRadius.cardRadius,
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // Footer
              Row(
                children: [
                  Container(
                    width: 100,
                    height: 14,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: AppRadius.pillRadius,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: 80,
                    height: 14,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: AppRadius.pillRadius,
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
