import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeData? _themeData;
  ThemeData? getTheme() => _themeData;

  ThemeNotifier() {
    SharedPreferences.getInstance().then((value) {
      var themeMode = value.getString('themeMode') ?? 'light';
      if (themeMode == 'light') {
        _themeData = lightTheme;
      } else {
        _themeData = darkTheme;
      }
      notifyListeners();
    });
  }

  /// Set Dark Theme Mode
  void setDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('themeMode', 'dark');
    _themeData = darkTheme;
    notifyListeners();
  }

  /// Set Light Theme Mode
  void setLightMode() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('themeMode', 'light');
    _themeData = lightTheme;
    notifyListeners();
  }

  /// Dark Theme
  final darkTheme = ThemeData(
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Colors.black,
    iconTheme: const IconThemeData(color: Colors.white),
    brightness: Brightness.dark,
    backgroundColor: Colors.black,
    dividerColor: Colors.white30,
    textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey).copyWith(
      secondary: Colors.white,
      brightness: Brightness.dark,
    ),
  );

  /// Light Theme
  final lightTheme = ThemeData(
    primaryColor: Colors.white,
    brightness: Brightness.light,
    iconTheme: const IconThemeData(color: Colors.black),
    backgroundColor: const Color(0xFFE5E5E5),
    textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.black)),
    dividerColor: Colors.white54,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey).copyWith(
      secondary: Colors.black,
      brightness: Brightness.light,
    ),
  );
}
