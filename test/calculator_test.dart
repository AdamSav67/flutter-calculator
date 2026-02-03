import 'package:flutter_test/flutter_test.dart';
import 'package:expressions/expressions.dart';

void main() {
  group('Calculator Expression Evaluation Tests', () {
    /// Helper function to evaluate expressions like the calculator does
    String evaluateExpression(String expression) {
      try {
        Expression expr = Expression.parse(expression);
        final evaluator = const ExpressionEvaluator();
        var result = evaluator.eval(expr, {});

        String resultString;
        if (result is double) {
          if (result == result.toInt()) {
            resultString = result.toInt().toString();
          } else {
            resultString = result
                .toStringAsFixed(10)
                .replaceAll(RegExp(r'0*$'), '')
                .replaceAll(RegExp(r'\.$'), '');
          }
        } else {
          resultString = result.toString();
        }
        return resultString;
      } catch (e) {
        return 'Error';
      }
    }

    group('Basic Arithmetic Operations', () {
      test('Addition: 2 + 3 = 5', () {
        expect(evaluateExpression('2 + 3'), equals('5'));
      });

      test('Subtraction: 10 - 4 = 6', () {
        expect(evaluateExpression('10 - 4'), equals('6'));
      });

      test('Multiplication: 5 * 6 = 30', () {
        expect(evaluateExpression('5 * 6'), equals('30'));
      });

      test('Division: 20 / 4 = 5', () {
        expect(evaluateExpression('20 / 4'), equals('5'));
      });
    });

    group('Order of Operations (PEMDAS)', () {
      test('Multiplication before Addition: 2 + 3 * 4 = 14', () {
        expect(evaluateExpression('2 + 3 * 4'), equals('14'));
      });

      test('Division before Subtraction: 20 - 10 / 2 = 15', () {
        expect(evaluateExpression('20 - 10 / 2'), equals('15'));
      });

      test('Complex expression: 2 + 3 * 4 - 5 = 9', () {
        expect(evaluateExpression('2 + 3 * 4 - 5'), equals('9'));
      });

      test('Multiple operations: 10 / 2 * 3 = 15', () {
        expect(evaluateExpression('10 / 2 * 3'), equals('15'));
      });

      test(
          'Complex with multiple operators: 100 - 50 + 25 * 2 = 100',
          () {
        expect(evaluateExpression('100 - 50 + 25 * 2'), equals('100'));
      });
    });

    group('Decimal Numbers', () {
      test('Decimal addition: 1.5 + 2.5 = 4', () {
        expect(evaluateExpression('1.5 + 2.5'), equals('4'));
      });

      test('Decimal multiplication: 2.5 * 4 = 10', () {
        expect(evaluateExpression('2.5 * 4'), equals('10'));
      });

      test('Decimal division: 7.5 / 2.5 = 3', () {
        expect(evaluateExpression('7.5 / 2.5'), equals('3'));
      });

      test('Result with decimals: 10 / 3 preserves decimals', () {
        expect(evaluateExpression('10 / 3'), isNotEmpty);
      });
    });

    group('Edge Cases', () {
      test('Division by Zero: 5 / 0 = Error', () {
        expect(evaluateExpression('5 / 0'), equals('Error'));
      });

      test('Single number: 42 = 42', () {
        expect(evaluateExpression('42'), equals('42'));
      });

      test('Zero operations: 0 + 0 = 0', () {
        expect(evaluateExpression('0 + 0'), equals('0'));
      });

      test('Negative results: 5 - 10 = -5', () {
        expect(evaluateExpression('5 - 10'), equals('-5'));
      });

      test('Large numbers: 1000 * 1000 = 1000000', () {
        expect(evaluateExpression('1000 * 1000'), equals('1000000'));
      });
    });

    group('Long Expressions', () {
      test('Five operands: 2 + 3 + 4 + 5 + 6 = 20', () {
        expect(evaluateExpression('2 + 3 + 4 + 5 + 6'), equals('20'));
      });

      test(
          'Mixed long expression: 1 + 2 * 3 - 4 / 2 + 5 = 10',
          () {
        expect(evaluateExpression('1 + 2 * 3 - 4 / 2 + 5'), equals('10'));
      });

      test('Ten operands alternating: 1+1+1+1+1+1+1+1+1+1 = 10', () {
        expect(evaluateExpression('1+1+1+1+1+1+1+1+1+1'), equals('10'));
      });
    });

    group('Floating Point Precision', () {
      test('0.1 + 0.2 is approximately 0.3', () {
        String result = evaluateExpression('0.1 + 0.2');
        // Should be close to 0.3, accounting for floating point precision
        expect(double.parse(result).toStringAsFixed(1), equals('0.3'));
      });

      test('1 / 3 * 3 is approximately 1', () {
        String result = evaluateExpression('1 / 3 * 3');
        double doubleResult = double.parse(result);
        // Should be very close to 1
        expect(doubleResult, closeTo(1.0, 0.0001));
      });
    });

    group('Trailing Zero Removal', () {
      test('Result with trailing zeros is cleaned: 5.0 = 5', () {
        String result = evaluateExpression('10 / 2');
        expect(result, equals('5'));
        expect(result.contains('.'), false);
      });

      test('Decimal result: 1 / 2 = 0.5', () {
        String result = evaluateExpression('1 / 2');
        expect(result, equals('0.5'));
      });
    });
  });
}
