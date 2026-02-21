import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';
import '../models/service_item.dart';
import 'service_card.dart';

/// A section displaying services grouped by category.
class ServiceCategorySection extends StatelessWidget {
  const ServiceCategorySection({
    super.key,
    required this.category,
    required this.services,
    required this.onServiceTap,
  });

  final ServiceCategory category;
  final List<ServiceItem> services;
  final void Function(ServiceItem service) onServiceTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category header
        Padding(
          padding: AppSpacing.horizontalLg,
          child: Text(
            category.label,
            style: AppTypography.titleMedium.copyWith(
              color: category.accentColor,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        // Services grid
        Padding(
          padding: AppSpacing.horizontalLg,
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: AppSpacing.md,
              mainAxisSpacing: AppSpacing.md,
              childAspectRatio: 1.1,
            ),
            itemCount: services.length,
            itemBuilder: (context, index) {
              final service = services[index];
              return ServiceCard(
                service: service,
                onTap: () => onServiceTap(service),
              );
            },
          ),
        ),
      ],
    );
  }
}
