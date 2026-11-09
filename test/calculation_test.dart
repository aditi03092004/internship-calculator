import 'package:flutter_test/flutter_test.dart';
import 'package:tip_calculator/models/calculation_result.dart';

void main() {
  group('CalculationResult Business Logic Unit Tests', () {
    test('Calculates standard sample scenario (₹1000, 10%, 2 people)', () {
      const result = CalculationResult(
        billAmount: 1000.0,
        tipPercentage: 10.0,
        numberOfPeople: 2,
      );

      expect(result.tipAmount, equals(100.0));
      expect(result.totalBill, equals(1100.0));
      expect(result.amountPerPerson, equals(550.0));
      expect(result.formattedTipAmount, equals('₹100.00'));
      expect(result.formattedTotalBill, equals('₹1100.00'));
      expect(result.formattedAmountPerPerson, equals('₹550.00'));
    });

    test('Handles zero bill amount gracefully', () {
      const result = CalculationResult(
        billAmount: 0.0,
        tipPercentage: 15.0,
        numberOfPeople: 4,
      );

      expect(result.tipAmount, equals(0.0));
      expect(result.totalBill, equals(0.0));
      expect(result.amountPerPerson, equals(0.0));
      expect(result.formattedTipAmount, equals('₹0.00'));
      expect(result.formattedTotalBill, equals('₹0.00'));
      expect(result.formattedAmountPerPerson, equals('₹0.00'));
    });

    test('Calculates 0% tip boundary', () {
      const result = CalculationResult(
        billAmount: 500.0,
        tipPercentage: 0.0,
        numberOfPeople: 1,
      );

      expect(result.tipAmount, equals(0.0));
      expect(result.totalBill, equals(500.0));
      expect(result.amountPerPerson, equals(500.0));
    });

    test('Calculates maximum 30% tip boundary with 5 people', () {
      const result = CalculationResult(
        billAmount: 2500.0,
        tipPercentage: 30.0,
        numberOfPeople: 5,
      );

      expect(result.tipAmount, equals(750.0));
      expect(result.totalBill, equals(3250.0));
      expect(result.amountPerPerson, equals(650.0));
      expect(result.formattedAmountPerPerson, equals('₹650.00'));
    });

    test('Verifies decimal precision and rounding to 2 decimal places', () {
      const result = CalculationResult(
        billAmount: 149.99,
        tipPercentage: 18.0,
        numberOfPeople: 3,
      );

      expect(result.formattedTipAmount, equals('₹27.00'));
      expect(result.formattedTotalBill, equals('₹176.99'));
      expect(result.formattedAmountPerPerson, equals('₹59.00'));
    });
  });
}
