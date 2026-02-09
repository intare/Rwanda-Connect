import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/theme/theme.dart';

/// Shimmer loading placeholder for posts list.
class PostShimmerList extends StatelessWidget {
  const PostShimmerList({super.key, this.itemCount = 5});

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
            child: PostShimmerCard(),
          ),
        ),
      ),
    );
  }
}

/// Single shimmer card for post loading state.
class PostShimmerCard extends StatelessWidget {
  const PostShimmerCard({super.key});

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
              // Author row placeholder
              Row(
                children: [
                  // Avatar placeholder
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  // Author info placeholder
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 120,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: AppRadius.cardRadius,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Container(
                        width: 80,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: AppRadius.cardRadius,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),

              // Content placeholder - multiple lines
              Container(
                width: double.infinity,
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: AppRadius.cardRadius,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Container(
                width: double.infinity,
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: AppRadius.cardRadius,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Container(
                width: 200,
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: AppRadius.cardRadius,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Actions placeholder
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: AppRadius.cardRadius,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.lg),
                  Container(
                    width: 80,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: AppRadius.cardRadius,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.lg),
                  Container(
                    width: 60,
                    height: 24,
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
