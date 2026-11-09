import 'package:flutter/material.dart';
import '../models/calculation_result.dart';
import '../theme/app_theme.dart';
import '../widgets/app_header.dart';
import '../widgets/bill_input_card.dart';
import '../widgets/result_card.dart';
import '../widgets/split_bill_card.dart';
import '../widgets/tip_slider_card.dart';

/// The primary single-screen calculator view.
///
/// Implements state management using [StatefulWidget] and [setState].
/// Manages live synchronization between user inputs and calculation results.
class TipCalculatorScreen extends StatefulWidget {
  const TipCalculatorScreen({super.key});

  @override
  State<TipCalculatorScreen> createState() => _TipCalculatorScreenState();
}

class _TipCalculatorScreenState extends State<TipCalculatorScreen> {
  // Input state variables
  double _billAmount = 0.0;
  double _tipPercentage = 10.0;
  int _numberOfPeople = 1;

  late final TextEditingController _billController;

  @override
  void initState() {
    super.initState();
    _billController = TextEditingController();
  }

  @override
  void dispose() {
    _billController.dispose();
    super.dispose();
  }

  /// Handles real-time updates when the user edits the bill amount text field.
  /// Safely parses the string, handling empty, zero, and invalid inputs gracefully.
  void _onBillAmountChanged(String value) {
    setState(() {
      if (value.trim().isEmpty) {
        _billAmount = 0.0;
      } else {
        // Safe numerical parse: if parsing fails or amount is negative, fall back to 0.0
        final parsed = double.tryParse(value.trim());
        _billAmount = (parsed != null && parsed >= 0) ? parsed : 0.0;
      }
    });
  }

  /// Clears the bill amount input and synchronizes state.
  void _clearBillAmount() {
    _billController.clear();
    setState(() {
      _billAmount = 0.0;
    });
  }

  /// Handles real-time updates when the tip percentage slider changes.
  void _onTipPercentageChanged(double newPercentage) {
    setState(() {
      _tipPercentage = newPercentage.clamp(0.0, 30.0);
    });
  }

  /// Increments the number of people splitting the bill.
  void _incrementPeople() {
    setState(() {
      _numberOfPeople++;
    });
  }

  /// Decrements the number of people splitting the bill, enforcing a minimum of 1.
  void _decrementPeople() {
    if (_numberOfPeople > 1) {
      setState(() {
        _numberOfPeople--;
      });
    }
  }

  /// Resets all inputs and calculation values to default initial state.
  void _resetAll() {
    _billController.clear();
    setState(() {
      _billAmount = 0.0;
      _tipPercentage = 10.0;
      _numberOfPeople = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Current calculation output based on reactive state
    final calculationResult = CalculationResult(
      billAmount: _billAmount,
      tipPercentage: _tipPercentage,
      numberOfPeople: _numberOfPeople,
    );

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 540),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 1. App Header
                  const AppHeader(),
                  const SizedBox(height: 20),

                  // 2. Live Calculation Hero Results Card
                  ResultCard(
                    result: calculationResult,
                    onReset: _resetAll,
                  ),
                  const SizedBox(height: 20),

                  // 3. Bill Amount Input Card
                  BillInputCard(
                    controller: _billController,
                    onChanged: _onBillAmountChanged,
                    onClear: _clearBillAmount,
                  ),
                  const SizedBox(height: 16),

                  // 4. Tip Percentage Slider Card
                  TipSliderCard(
                    tipPercentage: _tipPercentage,
                    onChanged: _onTipPercentageChanged,
                  ),
                  const SizedBox(height: 16),

                  // 5. Split Bill Between People Card
                  SplitBillCard(
                    numberOfPeople: _numberOfPeople,
                    onIncrement: _incrementPeople,
                    onDecrement: _decrementPeople,
                  ),
                  const SizedBox(height: 24),

                  // Footer Badge for Internship Project
                  Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.verified_rounded,
                            size: 16,
                            color: AppTheme.primaryBlue.withValues(alpha: 0.7),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Tip Calculator • Material 3 • Flutter Internship',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textSecondary.withValues(alpha: 0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
