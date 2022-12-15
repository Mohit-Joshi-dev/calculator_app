import 'package:calculator_app/provider/calculation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// [CustomButton] used to create all the calculator buttons
class CustomButton extends StatelessWidget {
  const CustomButton(
      {this.readOnly = false, required this.btnText, this.btnColor, super.key});

  final Color? btnColor;
  final String btnText;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CalculationProvider>();
    return Container(
      padding: const EdgeInsets.all(8),
      child: ElevatedButton(
        onPressed: () {
          if (!readOnly) {
            provider.calculate(btnText);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: provider.operand == btnText
              ? Colors.white
              : btnText == "="
                  ? Colors.green
                  : Colors.grey.shade900,
          shape: const CircleBorder(),
        ),
        child: Text(
          btnText == '*' ? 'x' : btnText,
          style: TextStyle(fontSize: 24, color: _getColor(btnText)),
        ),
      ),
    );
  }

  /// [_getColor] used to get the color according to the text passed
  _getColor(String text) {
    if (text == "/" ||
        text == "*" ||
        text == "+" ||
        text == "-" ||
        text == "%" ||
        text == "()") {
      return Colors.green;
    }
    if (text == "C") {
      return Colors.red;
    }
    return Colors.white;
  }
}
