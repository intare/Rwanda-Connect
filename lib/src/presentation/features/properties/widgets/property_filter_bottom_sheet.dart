import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../domain/entities/property.dart';
import '../providers/property_provider.dart';

/// Bottom sheet for filtering properties.
class PropertyFilterBottomSheet extends ConsumerStatefulWidget {
  const PropertyFilterBottomSheet({super.key});

  @override
  ConsumerState<PropertyFilterBottomSheet> createState() =>
      _PropertyFilterBottomSheetState();
}

class _PropertyFilterBottomSheetState
    extends ConsumerState<PropertyFilterBottomSheet> {
  PropertyType? _selectedType;
  String? _selectedLocation;
  double? _minPrice;
  double? _maxPrice;
  String _sortOption = 'createdAt:desc';

  final _minPriceController = TextEditingController();
  final _maxPriceController = TextEditingController();
  final _locationController = TextEditingController();

  static const List<String> _locations = [
    'Kigali',
    'Musanze',
    'Rubavu',
    'Huye',
    'Muhanga',
    'Nyagatare',
    'Rusizi',
    'Rwamagana',
  ];

  @override
  void initState() {
    super.initState();
    final state = ref.read(propertiesProvider);
    _selectedType = state.selectedType;
    _selectedLocation = state.selectedLocation;
    _minPrice = state.minPrice;
    _maxPrice = state.maxPrice;
    _sortOption = state.sortOption;

    if (_minPrice != null) {
      _minPriceController.text = _minPrice!.toStringAsFixed(0);
    }
    if (_maxPrice != null) {
      _maxPriceController.text = _maxPrice!.toStringAsFixed(0);
    }
    if (_selectedLocation != null) {
      _locationController.text = _selectedLocation!;
    }
  }

  @override
  void dispose() {
    _minPriceController.dispose();
    _maxPriceController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _applyFilters() {
    final notifier = ref.read(propertiesProvider.notifier);

    // Apply type filter
    notifier.filterByType(_selectedType);

    // Apply location filter
    final location = _locationController.text.trim();
    notifier.filterByLocation(location.isEmpty ? null : location);

    // Apply price filter
    final minPrice = double.tryParse(_minPriceController.text);
    final maxPrice = double.tryParse(_maxPriceController.text);
    notifier.filterByPrice(minPrice, maxPrice);

    // Apply sort
    notifier.changeSort(_sortOption);

    Navigator.pop(context);
  }

  void _clearFilters() {
    setState(() {
      _selectedType = null;
      _selectedLocation = null;
      _minPrice = null;
      _maxPrice = null;
      _sortOption = 'createdAt:desc';
      _minPriceController.clear();
      _maxPriceController.clear();
      _locationController.clear();
    });

    ref.read(propertiesProvider.notifier).clearFilters();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Handle
              Container(
                margin: const EdgeInsets.only(top: AppSpacing.sm),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Header
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Filter Properties',
                      style: AppTypography.titleMedium,
                    ),
                    TextButton(
                      onPressed: _clearFilters,
                      child: const Text('Clear All'),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              // Content
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(AppSpacing.md),
                  children: [
                    // Property Type
                    Text(
                      'Property Type',
                      style: AppTypography.titleSmall,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: [
                        _TypeChip(
                          label: 'All',
                          selected: _selectedType == null,
                          onTap: () => setState(() => _selectedType = null),
                        ),
                        ...PropertyType.values.map(
                          (type) => _TypeChip(
                            label: type.label,
                            selected: _selectedType == type,
                            onTap: () => setState(() => _selectedType = type),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Location
                    Text(
                      'Location',
                      style: AppTypography.titleSmall,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Autocomplete<String>(
                      initialValue: TextEditingValue(text: _locationController.text),
                      optionsBuilder: (textEditingValue) {
                        if (textEditingValue.text.isEmpty) {
                          return _locations;
                        }
                        return _locations.where((location) => location
                            .toLowerCase()
                            .contains(textEditingValue.text.toLowerCase()));
                      },
                      onSelected: (selection) {
                        _locationController.text = selection;
                        setState(() => _selectedLocation = selection);
                      },
                      fieldViewBuilder: (context, controller, focusNode, onSubmitted) {
                        // Sync with our controller
                        controller.text = _locationController.text;
                        controller.addListener(() {
                          _locationController.text = controller.text;
                        });
                        return TextField(
                          controller: controller,
                          focusNode: focusNode,
                          decoration: const InputDecoration(
                            hintText: 'Enter location',
                            prefixIcon: Icon(Icons.location_on_outlined),
                          ),
                          onSubmitted: (_) => onSubmitted(),
                        );
                      },
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Price Range
                    Text(
                      'Price Range (RWF)',
                      style: AppTypography.titleSmall,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _minPriceController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'Min',
                              prefixText: 'RWF ',
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                          child: Text('—'),
                        ),
                        Expanded(
                          child: TextField(
                            controller: _maxPriceController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'Max',
                              prefixText: 'RWF ',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Sort Options
                    Text(
                      'Sort By',
                      style: AppTypography.titleSmall,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    ...PropertySortOption.values.map(
                      (option) => ListTile(
                        title: Text(option.label),
                        contentPadding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                        leading: Radio<String>(
                          value: option.value,
                          groupValue: _sortOption,
                          onChanged: (value) {
                            if (value != null) {
                              setState(() => _sortOption = value);
                            }
                          },
                        ),
                        onTap: () => setState(() => _sortOption = option.value),
                      ),
                    ),
                  ],
                ),
              ),
              // Apply Button
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: FilledButton(
                    onPressed: _applyFilters,
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                    ),
                    child: const Text('Apply Filters'),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TypeChip extends StatelessWidget {
  const _TypeChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
    );
  }
}

/// Shows the property filter bottom sheet.
Future<void> showPropertyFilterBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const PropertyFilterBottomSheet(),
  );
}
