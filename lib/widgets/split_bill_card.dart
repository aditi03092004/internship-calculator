import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Card allowing users to increment or decrement the number of people splitting
/// the bill using plus and minus buttons.
class SplitBillCard extends StatelessWidget {
  final int numberOfPeople;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const SplitBillCard({
    super.key,
    required this.numberOfPeople,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    final bool canDecrement = numberOfPeople > 1;

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
          // Section Title
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.primaryLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.group_rounded,
                  size: 20,
                  color: AppTheme.primaryBlue,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Split Bill',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textPrimary,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Split Counter Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // People Description & Icon Indicator
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    numberOfPeople == 1 ? '1 Person' : '$numberOfPeople People',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Split expense evenly',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),

              // Plus and Minus Control Buttons
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.surfaceMuted,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.border),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                child: Row(
                  children: [
                    // Decrement Button (Minus)
                    _ControlButton(
                      icon: Icons.remove_rounded,
                      isEnabled: canDecrement,
                      onPressed: canDecrement ? onDecrement : null,
                      tooltip: 'Decrease people',
                    ),

                    // Counter Display
                    Container(
                      constraints: const BoxConstraints(minWidth: 42),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        '$numberOfPeople',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.primaryBlue,
                        ),
                      ),
                    ),

                    // Increment Button (Plus)
                    _ControlButton(
                      icon: Icons.add_rounded,
                      isEnabled: true,
                      onPressed: onIncrement,
                      tooltip: 'Increase people',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Helper button widget with rounded rectangle and tactile feedback.
class _ControlButton extends StatelessWidget {
  final IconData icon;
  final bool isEnabled;
  final VoidCallback? onPressed;
  final String tooltip;

  const _ControlButton({
    required this.icon,
    required this.isEnabled,
    required this.onPressed,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isEnabled ? AppTheme.surface : Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      elevation: isEnabled ? 1 : 0,
      shadowColor: Colors.black.withValues(alpha: 0.08),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isEnabled ? AppTheme.border : Colors.transparent,
            ),
          ),
          child: Icon(
            icon,
            size: 22,
            color: isEnabled ? AppTheme.primaryBlue : AppTheme.textSecondary.withValues(alpha: 0.4),
          ),
        ),
      ),
    );
  }
}
