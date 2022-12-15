import 'package:calculator_app/provider/provider.dart';
import 'package:calculator_app/views/views.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider<ThemeNotifier>(
    create: (_) => ThemeNotifier(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, provider, child) {
      return MaterialApp(
        title: 'Calculator App',
        theme: provider.getTheme(),
        debugShowCheckedModeBanner: false,
        home: ChangeNotifierProvider(
          create: (context) => CalculationProvider(),
          child: const HomePage(),
        ),
      );
    });
  }
}
