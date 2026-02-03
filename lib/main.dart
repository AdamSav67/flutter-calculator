import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _display = '0';
  String _expression = '';
  bool _shouldResetDisplay = false;

  void _onNumberPressed(String number) {
    setState(() {
      if (_shouldResetDisplay) {
        _display = number;
        _shouldResetDisplay = false;
      } else {
        if (_display == '0' && number != '.') {
          _display = number;
        } else if (number == '.' && _display.contains('.')) {
          return; // Prevent multiple decimal points
        } else {
          _display += number;
        }
      }
    });
  }

  void _onOperatorPressed(String operator) {
    setState(() {
      if (_expression.isEmpty) {
        _expression = _display + ' $operator ';
      } else {
        // Calculate the current expression if there's a complete operation
        _expression += _display + ' $operator ';
      }
      _shouldResetDisplay = true;
    });
  }

  void _onEqualsPressed() {
    setState(() {
      if (_expression.isEmpty) {
        return;
      }

      try {
        String fullExpression = _expression + _display;

        // Evaluate the expression using the expressions package
        Expression expr = Expression.parse(fullExpression);
        final evaluator = const ExpressionEvaluator();
        var result = evaluator.eval(expr, {});

        // Handle different result types
        String resultString;
        if (result is double) {
          // Check if the result is a whole number
          if (result == result.toInt()) {
            resultString = result.toInt().toString();
          } else {
            // Format to remove trailing zeros
            resultString = result
                .toStringAsFixed(10)
                .replaceAll(RegExp(r'0*$'), '')
                .replaceAll(RegExp(r'\.$'), '');
          }
        } else {
          resultString = result.toString();
        }

        _display = resultString;
        _expression = '';
        _shouldResetDisplay = true;
      } catch (e) {
        _display = 'Error';
        _expression = '';
        _shouldResetDisplay = true;
      }
    });
  }

  void _onClearPressed() {
    setState(() {
      _display = '0';
      _expression = '';
      _shouldResetDisplay = false;
    });
  }

  void _onBackspacePressed() {
    setState(() {
      if (_display.length > 1) {
        _display = _display.substring(0, _display.length - 1);
      } else {
        _display = '0';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator - Alex Johnson'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Display Section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Expression Display
                  Text(
                    _expression,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  // Result Display
                  Text(
                    _display,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Buttons Section
            Expanded(
              child: Column(
                children: [
                  // Row 1: C, Backspace, /
                  _buildButtonRow([
                    _buildButton('C', Colors.red, _onClearPressed),
                    _buildButton('⌫', Colors.orange, _onBackspacePressed),
                    _buildButton(
                      '/',
                      Colors.blue,
                      () => _onOperatorPressed('/'),
                    ),
                  ]),
                  const SizedBox(height: 12),
                  // Row 2: 7, 8, 9, *
                  _buildButtonRow([
                    _buildButton(
                      '7',
                      Colors.grey[700]!,
                      () => _onNumberPressed('7'),
                    ),
                    _buildButton(
                      '8',
                      Colors.grey[700]!,
                      () => _onNumberPressed('8'),
                    ),
                    _buildButton(
                      '9',
                      Colors.grey[700]!,
                      () => _onNumberPressed('9'),
                    ),
                    _buildButton(
                      '*',
                      Colors.blue,
                      () => _onOperatorPressed('*'),
                    ),
                  ]),
                  const SizedBox(height: 12),
                  // Row 3: 4, 5, 6, -
                  _buildButtonRow([
                    _buildButton(
                      '4',
                      Colors.grey[700]!,
                      () => _onNumberPressed('4'),
                    ),
                    _buildButton(
                      '5',
                      Colors.grey[700]!,
                      () => _onNumberPressed('5'),
                    ),
                    _buildButton(
                      '6',
                      Colors.grey[700]!,
                      () => _onNumberPressed('6'),
                    ),
                    _buildButton(
                      '-',
                      Colors.blue,
                      () => _onOperatorPressed('-'),
                    ),
                  ]),
                  const SizedBox(height: 12),
                  // Row 4: 1, 2, 3, +
                  _buildButtonRow([
                    _buildButton(
                      '1',
                      Colors.grey[700]!,
                      () => _onNumberPressed('1'),
                    ),
                    _buildButton(
                      '2',
                      Colors.grey[700]!,
                      () => _onNumberPressed('2'),
                    ),
                    _buildButton(
                      '3',
                      Colors.grey[700]!,
                      () => _onNumberPressed('3'),
                    ),
                    _buildButton(
                      '+',
                      Colors.blue,
                      () => _onOperatorPressed('+'),
                    ),
                  ]),
                  const SizedBox(height: 12),
                  // Row 5: 0, ., =
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: _buildButton(
                          '0',
                          Colors.grey[700]!,
                          () => _onNumberPressed('0'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildButton(
                          '.',
                          Colors.grey[700]!,
                          () => _onNumberPressed('.'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildButton(
                          '=',
                          Colors.green,
                          _onEqualsPressed,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonRow(List<Widget> buttons) {
    return Row(
      children: [
        for (int i = 0; i < buttons.length; i++) ...[
          Expanded(child: buttons[i]),
          if (i < buttons.length - 1) const SizedBox(width: 12),
        ],
      ],
    );
  }

  Widget _buildButton(
    String label,
    Color backgroundColor,
    VoidCallback onPressed,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
