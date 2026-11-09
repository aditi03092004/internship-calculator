/// Represents the state and calculations of the Tip Calculator.
///
/// Encapsulates calculation formulas:
/// - Tip Amount = Bill Amount * (Tip Percentage / 100)
/// - Total Bill = Bill Amount + Tip Amount
/// - Amount Per Person = Total Bill / Number of People
class CalculationResult {
  /// The base bill amount entered by the user.
  final double billAmount;

  /// The selected tip percentage (0% to 30%).
  final double tipPercentage;

  /// Number of people splitting the bill (minimum 1).
  final int numberOfPeople;

  const CalculationResult({
    this.billAmount = 0.0,
    this.tipPercentage = 10.0,
    this.numberOfPeople = 1,
  }) : assert(numberOfPeople >= 1, 'Number of people must be at least 1');

  /// Total tip amount calculated based on bill amount and tip percentage.
  double get tipAmount {
    if (billAmount <= 0) return 0.0;
    return billAmount * (tipPercentage / 100.0);
  }

  /// Total bill including both base bill amount and tip amount.
  double get totalBill {
    if (billAmount <= 0) return 0.0;
    return billAmount + tipAmount;
  }

  /// Amount to be paid by each individual person.
  double get amountPerPerson {
    if (numberOfPeople <= 0 || billAmount <= 0) return 0.0;
    return totalBill / numberOfPeople;
  }

  // --- Formatted Strings with Currency Prefix (₹) ---

  /// Formatted base bill with currency symbol.
  String get formattedBillAmount => '₹${billAmount.toStringAsFixed(2)}';

  /// Formatted tip percentage with percent symbol.
  String get formattedTipPercentage => '${tipPercentage.toStringAsFixed(0)}%';

  /// Formatted tip amount with currency symbol.
  String get formattedTipAmount => '₹${tipAmount.toStringAsFixed(2)}';

  /// Formatted total bill with currency symbol.
  String get formattedTotalBill => '₹${totalBill.toStringAsFixed(2)}';

  /// Formatted per-person amount with currency symbol.
  String get formattedAmountPerPerson => '₹${amountPerPerson.toStringAsFixed(2)}';

  CalculationResult copyWith({
    double? billAmount,
    double? tipPercentage,
    int? numberOfPeople,
  }) {
    return CalculationResult(
      billAmount: billAmount ?? this.billAmount,
      tipPercentage: tipPercentage ?? this.tipPercentage,
      numberOfPeople: numberOfPeople ?? this.numberOfPeople,
    );
  }
}

