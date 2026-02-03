import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workspace/main.dart';

void main() {
  group('Calculator UI Tests', () {
    testWidgets('Calculator app starts with display showing 0',
        (WidgetTester tester) async {
      await tester.pumpWidget(const CalculatorApp());

      // Verify the initial display
      expect(find.text('0'), findsWidgets);
      expect(find.text('Calculator - Adam Savastano'), findsOneWidget);
    });

    testWidgets('Number button press updates display',
        (WidgetTester tester) async {
      await tester.pumpWidget(const CalculatorApp());

      // Press number 5
      await tester.tap(find.text('5'));
      await tester.pump();

      // Display should show 5
      expect(find.text('5'), findsWidgets);
    });

    testWidgets('Multiple number presses concatenate',
        (WidgetTester tester) async {
      await tester.pumpWidget(const CalculatorApp());

      // Press 1, 2, 3
      await tester.tap(find.text('1'));
      await tester.pump();
      await tester.tap(find.text('2'));
      await tester.pump();
      await tester.tap(find.text('3'));
      await tester.pump();

      // Display should show 123
      expect(find.text('123'), findsWidgets);
    });

    testWidgets('Clear button resets calculator',
        (WidgetTester tester) async {
      await tester.pumpWidget(const CalculatorApp());

      // Press some numbers
      await tester.tap(find.text('5'));
      await tester.pump();
      await tester.tap(find.text('6'));
      await tester.pump();

      // Press clear button
      await tester.tap(find.text('C'));
      await tester.pump();

      // Display should be 0
      expect(find.text('0'), findsWidgets);
    });

    testWidgets('Decimal point can be added to display',
        (WidgetTester tester) async {
      await tester.pumpWidget(const CalculatorApp());

      // Press 5
      await tester.tap(find.text('5'));
      await tester.pump();

      // Press decimal point
      await tester.tap(find.text('.'));
      await tester.pump();

      // Press 3
      await tester.tap(find.text('3'));
      await tester.pump();

      // Display should show 5.3
      expect(find.text('5.3'), findsWidgets);
    });

    testWidgets('Backspace removes last digit',
        (WidgetTester tester) async {
      await tester.pumpWidget(const CalculatorApp());

      // Press 1, 2, 3
      await tester.tap(find.text('1'));
      await tester.pump();
      await tester.tap(find.text('2'));
      await tester.pump();
      await tester.tap(find.text('3'));
      await tester.pump();

      // Press backspace
      await tester.tap(find.text('⌫'));
      await tester.pump();

      // Display should show 12
      expect(find.text('12'), findsWidgets);
    });

    testWidgets('Operator buttons are accessible and colored',
        (WidgetTester tester) async {
      await tester.pumpWidget(const CalculatorApp());

      // Check that all operator buttons exist
      expect(find.text('+'), findsOneWidget);
      expect(find.text('-'), findsOneWidget);
      expect(find.text('*'), findsOneWidget);
      expect(find.text('/'), findsOneWidget);
      expect(find.text('='), findsOneWidget);
    });

    testWidgets('Simple addition calculates correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(const CalculatorApp());

      // Perform 2 + 3 =
      await tester.tap(find.text('2'));
      await tester.pump();
      await tester.tap(find.text('+'));
      await tester.pump();
      await tester.tap(find.text('3'));
      await tester.pump();
      await tester.tap(find.text('='));
      await tester.pump();

      // Display should show 5
      expect(find.text('5'), findsWidgets);
    });

    testWidgets('Order of operations is respected',
        (WidgetTester tester) async {
      await tester.pumpWidget(const CalculatorApp());

      // Perform 2 + 3 * 4 =
      await tester.tap(find.text('2'));
      await tester.pump();
      await tester.tap(find.text('+'));
      await tester.pump();
      await tester.tap(find.text('3'));
      await tester.pump();
      await tester.tap(find.text('*'));
      await tester.pump();
      await tester.tap(find.text('4'));
      await tester.pump();
      await tester.tap(find.text('='));
      await tester.pump();

      // Display should show 14 (not 20) due to PEMDAS
      expect(find.text('14'), findsWidgets);
    });

    testWidgets('Title is displayed correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(const CalculatorApp());

      // Check that the app bar has the correct title
      expect(find.text('Calculator - Alex Johnson'), findsOneWidget);
    });

    testWidgets('Expression accumulator shows ongoing calculation',
        (WidgetTester tester) async {
      await tester.pumpWidget(const CalculatorApp());

      // Perform some calculation
      await tester.tap(find.text('5'));
      await tester.pump();
      await tester.tap(find.text('+'));
      await tester.pump();
      await tester.tap(find.text('3'));
      await tester.pump();

      // The expression should be displayed showing "5 + "
      expect(find.byType(Text), findsWidgets);
    });

    testWidgets('Division operation works', (WidgetTester tester) async {
      await tester.pumpWidget(const CalculatorApp());

      // Perform 20 / 4 =
      await tester.tap(find.text('2'));
      await tester.pump();
      await tester.tap(find.text('0'));
      await tester.pump();
      await tester.tap(find.text('/'));
      await tester.pump();
      await tester.tap(find.text('4'));
      await tester.pump();
      await tester.tap(find.text('='));
      await tester.pump();

      // Display should show 5
      expect(find.text('5'), findsWidgets);
    });

    testWidgets('Subtraction operation works', (WidgetTester tester) async {
      await tester.pumpWidget(const CalculatorApp());

      // Perform 10 - 3 =
      await tester.tap(find.text('1'));
      await tester.pump();
      await tester.tap(find.text('0'));
      await tester.pump();
      await tester.tap(find.text('-'));
      await tester.pump();
      await tester.tap(find.text('3'));
      await tester.pump();
      await tester.tap(find.text('='));
      await tester.pump();

      // Display should show 7
      expect(find.text('7'), findsWidgets);
    });

    testWidgets('Multiplication operation works',
        (WidgetTester tester) async {
      await tester.pumpWidget(const CalculatorApp());

      // Perform 6 * 7 =
      await tester.tap(find.text('6'));
      await tester.pump();
      await tester.tap(find.text('*'));
      await tester.pump();
      await tester.tap(find.text('7'));
      await tester.pump();
      await tester.tap(find.text('='));
      await tester.pump();

      // Display should show 42
      expect(find.text('42'), findsWidgets);
    });
  });
}
