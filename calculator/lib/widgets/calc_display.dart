import 'package:calculator/constants/colors.dart';
import 'package:flutter/material.dart';

class Calcdisplay extends StatelessWidget {
  final String display;
  final String expression;
  
  const Calcdisplay({
    super.key,
    required this.display,
    required this.expression,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      alignment: Alignment.centerRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            expression,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w300,
              color: AppColors.expressionColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 8),
          Text(
            display,
            style: const TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.w300,
              color: AppColors.textdisplay,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}