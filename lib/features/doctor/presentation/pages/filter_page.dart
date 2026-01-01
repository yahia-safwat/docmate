import 'package:flutter/material.dart';
import '../../../../core/enums/doctor_category.dart';
import '../../domain/usecases/filter_doctors_usecase.dart';

class FilterPage extends StatefulWidget {
  final FilterParams initialFilters;

  const FilterPage({super.key, required this.initialFilters});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  late List<DoctorCategory> _selectedCategories;
  late double _minRating;
  late double _maxPrice;

  @override
  void initState() {
    super.initState();
    _selectedCategories = List.from(widget.initialFilters.categories ?? []);
    _minRating = widget.initialFilters.minRating ?? 0.0;
    _maxPrice = widget.initialFilters.maxPrice ?? 500.0;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _selectedCategories.clear();
                _minRating = 0.0;
                _maxPrice = 500.0;
              });
            },
            child: const Text('Reset'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Categories',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: DoctorCategory.values.map((category) {
                final isSelected = _selectedCategories.contains(category);
                return FilterChip(
                  selected: isSelected,
                  label: Text(category.name),
                  labelStyle: TextStyle(
                    color: isSelected
                        ? colorScheme.onPrimary
                        : colorScheme.onSurface,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedCategories.add(category);
                      } else {
                        _selectedCategories.remove(category);
                      }
                    });
                  },
                  selectedColor: colorScheme.primary,
                  checkmarkColor: colorScheme.onPrimary,
                  showCheckmark: true,
                );
              }).toList(),
            ),
            const SizedBox(height: 32),
            Text(
              'Minimum Rating',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 20),
                const SizedBox(width: 8),
                Text(_minRating.toStringAsFixed(1), style: textTheme.bodyLarge),
                Expanded(
                  child: Slider(
                    value: _minRating,
                    min: 0,
                    max: 5,
                    divisions: 10,
                    onChanged: (value) => setState(() => _minRating = value),
                  ),
                ),
                const Text('5.0'),
              ],
            ),
            const SizedBox(height: 32),
            Text(
              'Maximum Price',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text('\$0', style: textTheme.bodyLarge),
                Expanded(
                  child: Slider(
                    value: _maxPrice,
                    min: 0,
                    max: 500,
                    divisions: 50,
                    onChanged: (value) => setState(() => _maxPrice = value),
                  ),
                ),
                Text('\$${_maxPrice.toInt()}', style: textTheme.bodyLarge),
              ],
            ),
            const SizedBox(height: 32),
            FilledButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  FilterParams(
                    categories: _selectedCategories.isEmpty
                        ? null
                        : _selectedCategories,
                    minRating: _minRating == 0.0 ? null : _minRating,
                    maxPrice: _maxPrice == 500.0 ? null : _maxPrice,
                  ),
                );
              },
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text('Show Results'),
            ),
          ],
        ),
      ),
    );
  }
}
