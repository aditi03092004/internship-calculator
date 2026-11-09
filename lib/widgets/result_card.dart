import 'package:flutter/material.dart';
import '../models/calculation_result.dart';
import '../theme/app_theme.dart';

/// Premium results card displaying the live calculation summary.
///
/// Prominently highlights the "Amount Per Person" as the primary hero figure,
/// followed by an organized, formatted breakdown:
/// 1. Bill Amount
/// 2. Tip Percentage
/// 3. Total Tip Amount
/// 4. Total Bill (Bill + Tip)
/// 5. Amount Per Person
class ResultCard extends StatelessWidget {
  final CalculationResult result;
  final VoidCallback onReset;

  const ResultCard({
    super.key,
    required this.result,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: AppTheme.heroShadow,
      ),
      child: Stack(
        children: [
          // Subtle background decorative circles for visual depth
          Positioned(
            right: -24,
            top: -24,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.06),
              ),
            ),
          ),
          Positioned(
            left: -30,
            bottom: -30,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.04),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top Row: Card Title & Reset Action
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.18),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.insights_rounded,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Payment Breakdown',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white70,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),

                    // Reset Button (Text/IconButton)
                    InkWell(
                      onTap: onReset,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.refresh_rounded,
                              size: 14,
                              color: Colors.white,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Reset',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Hero Highlight: Amount Per Person
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.25),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'AMOUNT PER PERSON',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white70,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 6),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          result.formattedAmountPerPerson,
                          style: const TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: -1.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        result.numberOfPeople == 1
                            ? 'Single payment'
                            : 'Equally split among ${result.numberOfPeople} people',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Divider Line
                Divider(
                  color: Colors.white.withOpacity(0.18),
                  thickness: 1,
                  height: 1,
                ),
                const SizedBox(height: 16),

                // Breakdown Items
                _BreakdownRow(
                  label: '1. Bill Amount',
                  value: result.formattedBillAmount,
                ),
                const SizedBox(height: 10),
                _BreakdownRow(
                  label: '2. Tip Percentage',
                  value: result.formattedTipPercentage,
                ),
                const SizedBox(height: 10),
                _BreakdownRow(
                  label: '3. Total Tip Amount',
                  value: result.formattedTipAmount,
                ),
                const SizedBox(height: 10),
                _BreakdownRow(
                  label: '4. Total Bill',
                  value: result.formattedTotalBill,
                  isEmphasized: true,
                ),
                const SizedBox(height: 10),
                _BreakdownRow(
                  label: '5. Amount Per Person',
                  value: result.formattedAmountPerPerson,
                  isEmphasized: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Helper row for displaying individual breakdown items in the result card.
class _BreakdownRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isEmphasized;

  const _BreakdownRow({
    required this.label,
    required this.value,
    this.isEmphasized = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isEmphasized ? 15 : 14,
            fontWeight: isEmphasized ? FontWeight.w700 : FontWeight.w500,
            color: isEmphasized ? Colors.white : Colors.white70,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isEmphasized ? 16 : 14,
            fontWeight: isEmphasized ? FontWeight.w800 : FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
