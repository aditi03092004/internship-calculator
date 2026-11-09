// ignore_for_file: avoid_print
import '../lib/models/calculation_result.dart';

void main() {
  print('=== Running Tip Calculator Verification Tests ===');

  // Test Case 1: Standard Sample Inputs specified in requirements
  // Bill amount: ₹1000, Tip: 10%, People: 2
  const test1 = CalculationResult(
    billAmount: 1000.0,
    tipPercentage: 10.0,
    numberOfPeople: 2,
  );

  assert(test1.tipAmount == 100.0, 'Expected tip: 100.0, got: ${test1.tipAmount}');
  assert(test1.totalBill == 1100.0, 'Expected total: 1100.0, got: ${test1.totalBill}');
  assert(test1.amountPerPerson == 550.0, 'Expected per person: 550.0, got: ${test1.amountPerPerson}');
  assert(test1.formattedTipAmount == '₹100.00', 'Got: ${test1.formattedTipAmount}');
  assert(test1.formattedTotalBill == '₹1100.00', 'Got: ${test1.formattedTotalBill}');
  assert(test1.formattedAmountPerPerson == '₹550.00', 'Got: ${test1.formattedAmountPerPerson}');
  print('✓ Test Case 1 (₹1000, 10%, 2 people) PASSED:');
  print('    Tip: ${test1.formattedTipAmount}');
  print('    Total Bill: ${test1.formattedTotalBill}');
  print('    Amount Per Person: ${test1.formattedAmountPerPerson}');

  // Test Case 2: Zero Bill Amount
  const test2 = CalculationResult(
    billAmount: 0.0,
    tipPercentage: 15.0,
    numberOfPeople: 4,
  );
  assert(test2.tipAmount == 0.0, 'Tip should be 0.0 for 0 bill');
  assert(test2.totalBill == 0.0, 'Total bill should be 0.0 for 0 bill');
  assert(test2.amountPerPerson == 0.0, 'Amount per person should be 0.0 for 0 bill');
  print('✓ Test Case 2 (Zero bill amount) PASSED');

  // Test Case 3: 0% Tip
  const test3 = CalculationResult(
    billAmount: 500.0,
    tipPercentage: 0.0,
    numberOfPeople: 1,
  );
  assert(test3.tipAmount == 0.0, 'Expected tip 0');
  assert(test3.totalBill == 500.0, 'Expected total 500');
  assert(test3.amountPerPerson == 500.0, 'Expected per person 500');
  print('✓ Test Case 3 (0% tip) PASSED');

  // Test Case 4: Maximum 30% Tip
  const test4 = CalculationResult(
    billAmount: 2500.0,
    tipPercentage: 30.0,
    numberOfPeople: 5,
  );
  assert(test4.tipAmount == 750.0, 'Expected tip 750');
  assert(test4.totalBill == 3250.0, 'Expected total 3250');
  assert(test4.amountPerPerson == 650.0, 'Expected per person 650');
  print('✓ Test Case 4 (30% tip, 5 people) PASSED: Per Person = ₹${test4.amountPerPerson}');

  // Test Case 5: Decimal Precision & Rounding Verification
  const test5 = CalculationResult(
    billAmount: 149.99,
    tipPercentage: 18.0,
    numberOfPeople: 3,
  );
  assert(test5.formattedTipAmount == '₹27.00');
  assert(test5.formattedTotalBill == '₹176.99');
  assert(test5.formattedAmountPerPerson == '₹59.00');
  print('✓ Test Case 5 (Decimal precision and currency formatting) PASSED');

  print('\nALL CALCULATION VERIFICATION TESTS PASSED SUCCESSFULLY! (5/5)');
}
