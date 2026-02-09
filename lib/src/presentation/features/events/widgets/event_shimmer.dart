import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/theme/theme.dart';

/// Shimmer loading placeholder for events list.
class EventShimmerList extends StatelessWidget {
  const EventShimmerList({super.key, this.itemCount = 5});

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
            child: EventShimmerCard(),
          ),
        ),
      ),
    );
  }
}

/// Single shimmer card for event loading state.
class EventShimmerCard extends StatelessWidget {
  const EventShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Shimmer.fromColors(
        baseColor: AppColors.shimmerBase,
        highlightColor: AppColors.shimmerHighlight,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date badge placeholder
              Container(
                width: 56,
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: AppRadius.cardRadius,
                ),
              ),
              const SizedBox(width: AppSpacing.lg),

              // Event details placeholder
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Type badge placeholder
                    Row(
                      children: [
                        Container(
                          width: 70,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: AppRadius.pillRadius,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          width: 40,
                          height: 16,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: AppRadius.cardRadius,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),

                    // Title placeholder
                    Container(
                      width: double.infinity,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: AppRadius.cardRadius,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),

                    // Organizer placeholder
                    Container(
                      width: 120,
                      height: 14,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: AppRadius.cardRadius,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),

                    // Location placeholder
                    Container(
                      width: 150,
                      height: 14,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: AppRadius.cardRadius,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),

                    // Time placeholder
                    Container(
                      width: 100,
                      height: 14,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: AppRadius.cardRadius,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
