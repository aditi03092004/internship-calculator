import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tip_calculator/main.dart';

void main() {
  group('Tip Calculator Widget Tests', () {
    testWidgets('Renders all initial UI components properly',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(const TipCalculatorApp());
      await tester.pumpAndSettle();

      // Verify Header
      expect(find.text('Tip Calculator'), findsOneWidget);
      expect(
        find.text('Calculate your bill and split expenses easily.'),
        findsOneWidget,
      );

      // Verify Input Cards
      expect(find.text('Bill Amount'), findsOneWidget);
      expect(find.text('Tip Percentage'), findsOneWidget);
      expect(find.text('Split Bill'), findsOneWidget);

      // Verify Default Calculation Values (Bill: 0, Tip: 10%, People: 1)
      expect(find.text('AMOUNT PER PERSON'), findsOneWidget);
      expect(find.text('₹0.00'), findsNWidgets(4)); // Bill, Tip, Total, Per Person all 0.00
      expect(find.text('10%'), findsNWidgets(2)); // Badge and preset chip
      expect(find.text('1 Person'), findsOneWidget);
    });

    testWidgets('Calculates correct values with sample inputs (₹1000, 10%, 2 people)',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(const TipCalculatorApp());
      await tester.pumpAndSettle();

      // 1. Enter Bill Amount: 1000
      final billInputFinder = find.byType(TextField);
      expect(billInputFinder, findsOneWidget);
      await tester.enterText(billInputFinder, '1000');
      await tester.pumpAndSettle();

      // 2. Increment Number of People to 2
      final plusButtonFinder = find.byIcon(Icons.add_rounded);
      expect(plusButtonFinder, findsOneWidget);
      await tester.tap(plusButtonFinder);
      await tester.pumpAndSettle();

      // Verify Number of People is updated to 2
      expect(find.text('2 People'), findsOneWidget);

      // Verify Calculations:
      // Bill: ₹1000.00
      // Tip (10%): ₹100.00
      // Total (1000 + 100): ₹1100.00
      // Amount Per Person (1100 / 2): ₹550.00
      expect(find.text('₹1000.00'), findsOneWidget);
      expect(find.text('₹100.00'), findsOneWidget);
      expect(find.text('₹1100.00'), findsOneWidget);
      expect(find.text('₹550.00'), findsNWidgets(2)); // Hero badge & breakdown row
    });

    testWidgets('Enforces minimum limit of 1 person',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(const TipCalculatorApp());
      await tester.pumpAndSettle();

      // Initial count is 1
      expect(find.text('1 Person'), findsOneWidget);

      // Tapping minus button should not decrement below 1
      final minusButtonFinder = find.byIcon(Icons.remove_rounded);
      await tester.tap(minusButtonFinder);
      await tester.pumpAndSettle();

      expect(find.text('1 Person'), findsOneWidget);
      expect(find.text('0 People'), findsNothing);
    });

    testWidgets('Reset button clears bill and resets controls to defaults',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(const TipCalculatorApp());
      await tester.pumpAndSettle();

      // Enter Bill Amount: 500
      await tester.enterText(find.byType(TextField), '500');
      await tester.pumpAndSettle();

      // Increment people to 3
      final plusButton = find.byIcon(Icons.add_rounded);
      await tester.tap(plusButton);
      await tester.pumpAndSettle();
      await tester.tap(plusButton);
      await tester.pumpAndSettle();
      expect(find.text('3 People'), findsOneWidget);

      // Tap Reset Button
      final resetButton = find.text('Reset');
      expect(resetButton, findsOneWidget);
      await tester.tap(resetButton);
      await tester.pumpAndSettle();

      // Verify all fields are back to defaults
      expect(find.text('1 Person'), findsOneWidget);
      expect(find.text('₹0.00'), findsNWidgets(4));
    });
  });
}
