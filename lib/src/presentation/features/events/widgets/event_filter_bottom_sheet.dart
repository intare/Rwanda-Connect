import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../providers/event_provider.dart';

/// Bottom sheet for filtering events.
class EventFilterBottomSheet extends ConsumerStatefulWidget {
  const EventFilterBottomSheet({super.key});

  @override
  ConsumerState<EventFilterBottomSheet> createState() =>
      _EventFilterBottomSheetState();
}

class _EventFilterBottomSheetState
    extends ConsumerState<EventFilterBottomSheet> {
  late String? _selectedLocation;
  late String _selectedSort;
  late DateTime? _dateFrom;
  late DateTime? _dateTo;

  // Common locations for filtering
  static const List<String> _locations = [
    'Kigali',
    'Toronto',
    'London',
    'Brussels',
    'New York',
    'Paris',
    'Berlin',
    'Online',
  ];

  @override
  void initState() {
    super.initState();
    final state = ref.read(eventsProvider);
    _selectedLocation = state.selectedLocation;
    _selectedSort = state.sortOption;
    _dateFrom = state.dateFrom;
    _dateTo = state.dateTo;
  }

  void _applyFilters() {
    final notifier = ref.read(eventsProvider.notifier);

    // Apply location filter
    notifier.filterByLocation(_selectedLocation);

    // Apply date range filter
    notifier.filterByDateRange(_dateFrom, _dateTo);

    // Apply sort option
    notifier.changeSort(_selectedSort);

    Navigator.of(context).pop();
  }

  void _clearFilters() {
    setState(() {
      _selectedLocation = null;
      _selectedSort = 'date:asc';
      _dateFrom = null;
      _dateTo = null;
    });
  }

  Future<void> _selectDateFrom() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dateFrom ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _dateFrom = picked;
        // Ensure dateTo is after dateFrom
        if (_dateTo != null && _dateTo!.isBefore(picked)) {
          _dateTo = null;
        }
      });
    }
  }

  Future<void> _selectDateTo() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dateTo ?? _dateFrom ?? DateTime.now(),
      firstDate: _dateFrom ?? DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _dateTo = picked;
      });
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Select';
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final sortOptions = ref.watch(eventSortOptionsProvider);

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
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

              // Date range section
              Text(
                'Date Range',
                style: AppTypography.titleSmall,
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: _DateSelector(
                      label: 'From',
                      value: _formatDate(_dateFrom),
                      onTap: _selectDateFrom,
                      onClear: _dateFrom != null
                          ? () => setState(() => _dateFrom = null)
                          : null,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: _DateSelector(
                      label: 'To',
                      value: _formatDate(_dateTo),
                      onTap: _selectDateTo,
                      onClear: _dateTo != null
                          ? () => setState(() => _dateTo = null)
                          : null,
                    ),
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
                  children: sortOptions
                      .map(
                        (option) => RadioListTile<String>(
                          title: Text(option.label),
                          value: option.value,
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                        ),
                      )
                      .toList(),
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

class _DateSelector extends StatelessWidget {
  const _DateSelector({
    required this.label,
    required this.value,
    required this.onTap,
    this.onClear,
  });

  final String label;
  final String value;
  final VoidCallback onTap;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.bodySmallSecondary,
        ),
        const SizedBox(height: AppSpacing.xs),
        InkWell(
          onTap: onTap,
          borderRadius: AppRadius.inputRadius,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.md,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.border),
              borderRadius: AppRadius.inputRadius,
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_today,
                  size: AppSizes.iconSm,
                  color: AppColors.secondaryText,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    value,
                    style: AppTypography.bodyMedium,
                  ),
                ),
                if (onClear != null)
                  GestureDetector(
                    onTap: onClear,
                    child: const Icon(
                      Icons.close,
                      size: AppSizes.iconSm,
                      color: AppColors.secondaryText,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
