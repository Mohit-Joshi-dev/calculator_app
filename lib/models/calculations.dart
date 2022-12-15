import 'dart:convert';

/// [Calculations] Model
class Calculations {
  String total = '';
  String userInput = '';

  Calculations({required this.total, required this.userInput});

  Calculations.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    userInput = json['userInput'];
  }

  static Map<String, dynamic> toJson(Calculations value) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = value.total;
    data['userInput'] = value.userInput;
    return data;
  }

  static String encode(List<Calculations> value) => json.encode(
        value
            .map<Map<String, dynamic>>((value) => Calculations.toJson(value))
            .toList(),
      );

  static List<Calculations> decode(String value) =>
      (json.decode(value) as List<dynamic>)
          .map<Calculations>((item) => Calculations.fromJson(item))
          .toList();
}
