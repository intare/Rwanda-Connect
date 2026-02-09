import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../providers/opportunity_provider.dart';

/// Bottom sheet for filtering opportunities.
class FilterBottomSheet extends ConsumerStatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  ConsumerState<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends ConsumerState<FilterBottomSheet> {
  late String? _selectedLocation;
  late String _selectedSort;

  // Common locations in Rwanda for filtering
  static const List<String> _locations = [
    'Kigali',
    'Remote',
    'Hybrid',
    'United States',
    'United Kingdom',
    'Canada',
    'Belgium',
    'France',
    'Germany',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    final state = ref.read(opportunitiesProvider);
    _selectedLocation = state.selectedLocation;
    _selectedSort = state.sortOption;
  }

  void _applyFilters() {
    final notifier = ref.read(opportunitiesProvider.notifier);

    // Apply location filter
    notifier.filterByLocation(_selectedLocation);

    // Apply sort option
    notifier.changeSort(_selectedSort);

    Navigator.of(context).pop();
  }

  void _clearFilters() {
    setState(() {
      _selectedLocation = null;
      _selectedSort = 'deadline:asc';
    });
  }

  @override
  Widget build(BuildContext context) {
    final sortOptions = ref.watch(opportunitySortOptionsProvider);

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          padding: AppSpacing.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: AppSpacing.lg),
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filter & Sort',
                    style: AppTypography.headlineSmall,
                  ),
                  TextButton(
                    onPressed: _clearFilters,
                    child: const Text('Reset'),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xxl),

              // Location section
              Text(
                'Location',
                style: AppTypography.titleSmall,
              ),
              const SizedBox(height: AppSpacing.md),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  FilterChip(
                    label: const Text('All Locations'),
                    selected: _selectedLocation == null,
                    onSelected: (_) {
                      setState(() {
                        _selectedLocation = null;
                      });
                    },
                  ),
                  ..._locations.map(
                    (location) => FilterChip(
                      label: Text(location),
                      selected: _selectedLocation == location,
                      onSelected: (_) {
                        setState(() {
                          _selectedLocation = location;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xxl),

              // Sort section
              Text(
                'Sort By',
                style: AppTypography.titleSmall,
              ),
              const SizedBox(height: AppSpacing.md),
              RadioGroup<String>(
                groupValue: _selectedSort,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedSort = value;
                    });
                  }
                },
                child: Column(
                  children: sortOptions.map(
                    (option) => RadioListTile<String>(
                      title: Text(option.label),
                      value: option.value,
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                    ),
                  ).toList(),
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),

              // Apply button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _applyFilters,
                  child: const Text('Apply Filters'),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        );
      },
    );
  }
}
