import 'package:calculator_app/models/models.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// [CalculationProvider] used to calculate the numbers
class CalculationProvider extends ChangeNotifier {
  // Getters
  String get total => _total;
  String get userInput => _userInput;
  String? get operand => op;
  bool get isShowingHistory => _isShowingHistory;
  List<Calculations> get historyData => _historyData;

  // Variables
  bool _isShowingHistory = false;
  String _total = '';
  String _userInput = '';
  String showText = '0';

  List<Calculations> _historyData = [];

  // Holders
  num num1 = 0;
  num num2 = 0;
  String? op;
  String cache = '';
  String result = '';

  /// Calculation Function [CalculationProvider]
  void calculate(String btnText) {
    // Clear one digit
    if (btnText == "delete") {
      result = result.substring(0, result.length - 1);
      showText = result;
      _total = showText;
      notifyListeners();
      return;
    }
    // All clear
    else if (btnText == 'C') {
      result = '';
      num1 = 0;
      num2 = 0;
      op = '';
      cache = '';
      showText = '';
      _total = showText;
      _userInput = '';
      notifyListeners();
      return;
    } // +/-
    else if (btnText == '+/-') {
      if (result != '0') {
        num n = num.parse(showText.isEmpty ? '0' : showText) * -1;
        result = (n).toString();
      } else {
        result = '';
      }
    } // %
    else if (btnText == '%') {
      num1 = num.parse(showText);
      double n = (num1 / 100);
      result = n.toStringAsFixed(2);
      showText = result;
      cache = '$num1 %';
      _total = showText;
      notifyListeners();
      return;
    } // ÷
    else if (btnText == '/') {
      num1 = num.parse(showText);
      op = btnText;
      notifyListeners();
      result = '';
    } // X
    else if (btnText == '*') {
      num1 = num.parse(showText);
      op = btnText;
      notifyListeners();
      result = '';
    } // -
    else if (btnText == '-') {
      num1 = num.parse(showText);
      op = btnText;
      notifyListeners();
      result = '';
    } // +
    else if (btnText == '+') {
      // add Number 1 and add op later clear result
      num1 = num.parse(showText);
      op = btnText;
      notifyListeners();
      result = '';
    } // =
    else if (btnText == '=') {
      // +
      if (op == '+') {
        num2 = num.parse(showText);
        result = (num1 + num2).toString();
        cache = '$num1 $op $num2';
      } // -
      else if (op == '-') {
        num2 = num.parse(showText);
        result = (num1 - num2).toString();
        cache = '$num1 $op $num2';
      } // ÷
      else if (op == '/') {
        num2 = num.parse(showText);
        result = (num1 / num2).toString();
        showText = result;
        cache = '$num1 $op $num2';
      } // X
      else if (op == '*') {
        num2 = num.parse(showText);
        result = (num1 * num2).toString();
        showText = result;
        cache = '$num1 $op $num2';
      }
      _userInput = cache;
      showText = result;
      _total = showText;
      op = '';
      notifyListeners();
      setHistory(Calculations(total: _total, userInput: _userInput));
    } else {
      if (result == 'error') {
        showText = '';
        result = num.parse(showText + btnText).toString();
      } else {
        result = num.parse(showText + btnText).toString();
      }
    }
    showText = result;
    _total = num.tryParse(showText)?.toString() ?? '';
    notifyListeners();

    if (_total.endsWith(".00")) {
      _total = _total.replaceAll(".00", "");
      notifyListeners();
    } else if (_total.endsWith(".0")) {
      _total = _total.replaceAll(".0", "");
      notifyListeners();
    }
  }

  // All Setters
  /// [setIsShowingHistory] used to keep track of the UI currently showing i.e. Calculator or History
  void setIsShowingHistory(bool showHistory) {
    _isShowingHistory = showHistory;
    notifyListeners();
  }

  /// Set calculation to history
  setHistory(Calculations value) async {
    final prefs = await SharedPreferences.getInstance();

    final calculations = await getHistory();
    if (calculations.length == 10) {
      calculations.removeAt(0);
    }
    calculations.add(value);

    final String encodedData = Calculations.encode(calculations);
    prefs.setString('history', encodedData);

    await getHistory();
  }

  /// Get calculations for history
  Future<List<Calculations>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();

    // Fetch and decode data
    final String dataString = prefs.getString('history') ?? '';
    final List<Calculations> calculations = [];
    if (dataString.isNotEmpty) {
      calculations.addAll(Calculations.decode(dataString));
    }
    _historyData = calculations;
    notifyListeners();

    return calculations;
  }

  /// Clear all history
  Future clearHistory() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('history');
    _historyData = [];
    notifyListeners();
  }
}
