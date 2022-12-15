import 'package:calculator_app/provider/calculation_provider.dart';
import 'package:calculator_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// [HistoryWidget] shows recent 10 calculations in the UI
class HistoryWidget extends StatelessWidget {
  const HistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final buttons = ['/', '*', '+', '-', '='];
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width - 115,
          child: Column(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Consumer<CalculationProvider>(
                            builder: (context, provider, child) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: provider.historyData
                                .map((e) => Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, right: 10),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            e.userInput,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary),
                                          ),
                                          Text(
                                            '= ${e.total}',
                                            style: const TextStyle(
                                                color: Colors.green,
                                                fontSize: 18),
                                          )
                                        ],
                                      ),
                                    ))
                                .toList(),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              MaterialButton(
                onPressed: () {
                  context.read<CalculationProvider>().clearHistory();
                },
                shape: const StadiumBorder(),
                color: Colors.grey.shade800,
                child: const Text(
                  'Clear History',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: VerticalDivider(
            color: Theme.of(context).colorScheme.secondary,
            thickness: 1,
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, mainAxisExtent: 88),
            itemBuilder: (BuildContext context, int index) {
              return CustomButton(
                btnText: buttons[index],
                readOnly: true,
              );
            },
            itemCount: buttons.length,
          ),
        ),
      ],
    );
  }
}
