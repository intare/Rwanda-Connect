import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';
import '../../../../domain/entities/playbook.dart';

/// Card widget for displaying a playbook category.
class PlaybookCategoryCard extends StatelessWidget {
  const PlaybookCategoryCard({
    super.key,
    required this.category,
    required this.onTap,
    this.isSelected = false,
  });

  final PlaybookCategory category;
  final VoidCallback onTap;
  final bool isSelected;

  IconData _getIcon() {
    // Map category name to icon
    final name = category.name.toLowerCase();
    if (name.contains('career')) return Icons.work_outline;
    if (name.contains('skill')) return Icons.psychology_outlined;
    if (name.contains('network')) return Icons.people_outline;
    if (name.contains('leadership')) return Icons.leaderboard_outlined;
    if (name.contains('interview')) return Icons.record_voice_over_outlined;
    if (name.contains('resume') || name.contains('cv')) return Icons.description_outlined;
    if (name.contains('success')) return Icons.emoji_events_outlined;
    if (name.contains('business')) return Icons.business_center_outlined;
    if (name.contains('finance')) return Icons.account_balance_outlined;
    if (name.contains('tech')) return Icons.computer_outlined;
    return Icons.auto_stories_outlined;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isSelected ? AppColors.primary : null,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                category.icon != null ? _parseIcon(category.icon!) : _getIcon(),
                size: 32,
                color: isSelected ? Colors.white : AppColors.primary,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                category.name,
                style: AppTypography.labelMedium.copyWith(
                  color: isSelected ? Colors.white : AppColors.primaryText,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (category.contentCount > 0) ...[
                const SizedBox(height: 4),
                Text(
                  '${category.contentCount} items',
                  style: AppTypography.labelSmall.copyWith(
                    color: isSelected
                        ? Colors.white.withValues(alpha: 0.8)
                        : AppColors.secondaryText,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  IconData _parseIcon(String iconName) {
    // Map icon names to Material icons
    switch (iconName.toLowerCase()) {
      case 'work':
        return Icons.work_outline;
      case 'school':
        return Icons.school_outlined;
      case 'people':
        return Icons.people_outline;
      case 'star':
        return Icons.star_outline;
      case 'trending_up':
        return Icons.trending_up;
      case 'psychology':
        return Icons.psychology_outlined;
      case 'lightbulb':
        return Icons.lightbulb_outline;
      case 'book':
        return Icons.menu_book_outlined;
      default:
        return _getIcon();
    }
  }
}

/// Horizontal scrolling list of category chips.
class PlaybookCategoryChips extends StatelessWidget {
  const PlaybookCategoryChips({
    super.key,
    required this.categories,
    this.selectedCategory,
    required this.onCategorySelected,
  });

  final List<PlaybookCategory> categories;
  final PlaybookCategory? selectedCategory;
  final ValueChanged<PlaybookCategory?> onCategorySelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        children: [
          // All chip
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.sm),
            child: FilterChip(
              label: const Text('All'),
              selected: selectedCategory == null,
              onSelected: (_) => onCategorySelected(null),
            ),
          ),
          // Category chips
          ...categories.map(
            (category) => Padding(
              padding: const EdgeInsets.only(right: AppSpacing.sm),
              child: FilterChip(
                label: Text(category.name),
                selected: selectedCategory?.id == category.id,
                onSelected: (_) => onCategorySelected(
                  selectedCategory?.id == category.id ? null : category,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
