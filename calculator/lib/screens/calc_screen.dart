import 'package:calculator/widgets/calc_button.dart';
import 'package:calculator/widgets/calc_display.dart';
import 'package:flutter/material.dart';

class Calcscreen extends StatefulWidget {
  const Calcscreen({super.key});

  @override
  State<Calcscreen> createState() => _CalcscreenState();
}

class _CalcscreenState extends State<Calcscreen> {
  String _display = '0';
  String _expression = '';
  double? _previousValue;
  String? _pendingOperation;
  bool _shouldResetDisplay = false;

  void _onButtonPressed(String value) {
    setState(() {
      // Clear
      if (value == 'C') {
        _resetCalculator();
        return;
      }

      // Backspace
      if (value == '⌫') {
        _handleBackspace();
        return;
      }

      // Equals
      if (value == '=') {
        _calculateResult();
        return;
      }

      // Operators
      if (['+', '-', '×', '÷'].contains(value)) {
        _handleOperator(value);
        return;
      }

      // Decimal point
      if (value == '.') {
        _handleDecimal();
        return;
      }

      // Numbers
      _handleNumber(value);
    });
  }

  void _resetCalculator() {
    _display = '0';
    _expression = '';
    _previousValue = null;
    _pendingOperation = null;
    _shouldResetDisplay = false;
  }

  void _handleBackspace() {
    if (_display.length > 1 && !_shouldResetDisplay) {
      _display = _display.substring(0, _display.length - 1);
    } else {
      _display = '0';
    }
  }

  void _handleNumber(String number) {
    if (_shouldResetDisplay || _display == '0') {
      _display = number;
      _shouldResetDisplay = false;
    } else {
      _display += number;
    }
  }

  void _handleDecimal() {
    if (_shouldResetDisplay) {
      _display = '0.';
      _shouldResetDisplay = false;
    } else if (!_display.contains('.')) {
      _display += '.';
    }
  }

  void _handleOperator(String operator) {
    final currentValue = double.tryParse(_display);
    if (currentValue == null) return;

    if (_previousValue == null) {
      _previousValue = currentValue;
    } else if (_pendingOperation != null) {
      final result = _calculate(_previousValue!, currentValue, _pendingOperation!);
      _previousValue = result;
      _display = _formatNumber(result);
    }

    _pendingOperation = operator;
    _expression = '${_formatNumber(_previousValue!)} $operator';
    _shouldResetDisplay = true;
  }

  void _calculateResult() {
    if (_previousValue == null || _pendingOperation == null) return;

    final currentValue = double.tryParse(_display);
    if (currentValue == null) return;

    final result = _calculate(_previousValue!, currentValue, _pendingOperation!);
    
    _expression = '${_formatNumber(_previousValue!)} $_pendingOperation ${_formatNumber(currentValue)} =';
    _display = _formatNumber(result);
    
    _previousValue = null;
    _pendingOperation = null;
    _shouldResetDisplay = true;
  }

  double _calculate(double first, double second, String operator) {
    switch (operator) {
      case '+':
        return first + second;
      case '-':
        return first - second;
      case '×':
        return first * second;
      case '÷':
        return second != 0 ? first / second : 0;
      default:
        return 0;
    }
  }

  String _formatNumber(double number) {
    return number % 1 == 0 ? number.toInt().toString() : number.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Calcdisplay(display: _display, expression: _expression),
            ),
            Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    _buildButtonRow(['C', '⌫', '÷']),
                    _buildButtonRow(['7', '8', '9', '×']),
                    _buildButtonRow(['4', '5', '6', '-']),
                    _buildButtonRow(['1', '2', '3', '+']),
                    _buildButtonRow(['0', '.', '=']),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildButtonRow(List<String> buttons) {
    return Expanded(
      child: Row(
        children: buttons
            .map((button) => CalcButton(
                  text: button,
                  onPressed: () => _onButtonPressed(button),
                ))
            .toList(),
      ),
    );
  }
}