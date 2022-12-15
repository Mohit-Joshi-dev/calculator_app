import 'package:calculator_app/provider/provider.dart';
import 'package:calculator_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            const _Header(),
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.4,
              child: Consumer<CalculationProvider>(
                  builder: (context, value, child) {
                if (value.isShowingHistory) {
                  return const HistoryWidget();
                } else {
                  return const CalculatorButtonsWidget(buttons: buttons);
                }
              }),
            )
          ],
        ),
      ),
    );
  }

  static const List<String> buttons = [
    'C',
    '()',
    '%',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    '+/-',
    '0',
    '.',
    '=',
  ];
}

/// Header UI
class _Header extends StatelessWidget {
  const _Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Consumer<CalculationProvider>(builder: (context, value, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 80,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  value.total.isEmpty ? '0' : value.total,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color ??
                        Colors.white,
                    fontSize: 80,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          value.setIsShowingHistory(!value.isShowingHistory);
                        },
                        icon: const Icon(
                          Icons.access_time,
                          // color: Colors.white,
                        )),
                    Consumer<ThemeNotifier>(
                        builder: (context, provider, child) {
                      return IconButton(
                          onPressed: () {
                            if (provider.getTheme()?.brightness ==
                                Brightness.dark) {
                              provider.setLightMode();
                            } else {
                              provider.setDarkMode();
                            }
                          },
                          icon: Icon(
                            provider.getTheme()?.brightness != Brightness.dark
                                ? Icons.dark_mode
                                : Icons.light_mode,
                            color: Colors.green,
                          ));
                    }),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    value.calculate('delete');
                  },
                  icon: const Icon(
                    Icons.backspace_outlined,
                    color: Colors.green,
                  ),
                )
              ],
            ),
            Divider(color: Theme.of(context).colorScheme.secondary, height: 1),
          ],
        );
      }),
    );
  }
}
