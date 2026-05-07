import 'package:calculator/constants/button_colors.dart';
import 'package:calculator/constants/colors.dart';
import 'package:flutter/material.dart';

class CalcButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  
  const CalcButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final buttonColor = _getButtonColors(text);
    
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            foregroundColor: buttonColor.text,
            backgroundColor: buttonColor.background,
            elevation: 0,
            padding: const EdgeInsets.all(24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  ButtonColors _getButtonColors(String text) {
    if (text == 'C' || text == '⌫') {
      return ButtonColors(
        background: AppColors.clear,
        text: AppColors.background,
      );
    } else if (['+', '-', '×', '÷', '='].contains(text)) {
      return ButtonColors(
        background: AppColors.textPrime,
        text: AppColors.button,
      );
    } else {
      return ButtonColors(
        background: AppColors.button,
        text: AppColors.textPrime,
      );
    }
  }
}