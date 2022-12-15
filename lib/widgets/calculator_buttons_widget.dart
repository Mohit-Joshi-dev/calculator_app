import 'package:calculator_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

/// [CalculatorButtonsWidget] to show all the calculation related buttons on the UI
class CalculatorButtonsWidget extends StatelessWidget {
  const CalculatorButtonsWidget({
    Key? key,
    required this.buttons,
  }) : super(key: key);

  final List<String> buttons;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      itemBuilder: (BuildContext context, int index) {
        return CustomButton(btnText: buttons[index]);
      },
      itemCount: buttons.length,
    );
  }
}
