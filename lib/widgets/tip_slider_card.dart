import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Card containing the tip percentage [Slider] (0% to 30%) with live value badge
/// and fast-select preset chips.
class TipSliderCard extends StatelessWidget {
  final double tipPercentage;
  final ValueChanged<double> onChanged;

  const TipSliderCard({
    super.key,
    required this.tipPercentage,
    required this.onChanged,
  });

  // Common quick-select preset values
  static const List<double> presetPercentages = [0, 5, 10, 15, 20, 25];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.border, width: 1),
        boxShadow: AppTheme.cardShadow,
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header with Selected Percentage Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryLight,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.percent_rounded,
                      size: 20,
                      color: AppTheme.primaryBlue,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Tip Percentage',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary,
                      letterSpacing: -0.2,
                    ),
                  ),
                ],
              ),

              // Live Percentage Highlight Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.primaryBlue,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryBlue.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  '${tipPercentage.toStringAsFixed(0)}%',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Tip Slider (0% to 30%)
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 6,
              thumbShape: const RoundSliderThumbShape(
                enabledThumbRadius: 10,
                elevation: 4,
              ),
            ),
            child: Slider(
              value: tipPercentage.clamp(0.0, 30.0),
              min: 0.0,
              max: 30.0,
              divisions: 30, // 1% precision increments
              label: '${tipPercentage.toStringAsFixed(0)}%',
              activeColor: AppTheme.primaryBlue,
              inactiveColor: AppTheme.primaryLight,
              onChanged: (double newValue) {
                onChanged(newValue.roundToDouble());
              },
            ),
          ),

          // Slider Range Labels: 0% and 30%
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '0%',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textSecondary,
                  ),
                ),
                Text(
                  '15%',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textSecondary,
                  ),
                ),
                Text(
                  '30%',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Preset Quick-Select Chips
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: presetPercentages.map((preset) {
              final isSelected = (tipPercentage.round() == preset.round());
              return InkWell(
                onTap: () => onChanged(preset),
                borderRadius: BorderRadius.circular(10),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? AppTheme.primaryLight : AppTheme.surfaceMuted,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected ? AppTheme.primaryBlue : AppTheme.border,
                      width: isSelected ? 1.5 : 1.0,
                    ),
                  ),
                  child: Text(
                    '${preset.toInt()}%',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      color: isSelected ? AppTheme.primaryBlue : AppTheme.textSecondary,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
