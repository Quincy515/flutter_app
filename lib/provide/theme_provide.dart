import 'package:flutter/material.dart';

class ThemeProvide with ChangeNotifier {
  ThemeData themeData;
  ThemeType themeType;

  ThemeProvide({this.themeData, this.themeType});

  void change() {
    if (themeType == ThemeType.light) {
      themeData = ThemeData.dark();
      themeType = ThemeType.dark;
    } else {
      themeData = ThemeData.light();
      themeType = ThemeType.light;
    }
    notifyListeners();
  }
}

enum ThemeType {
  light,
  dark,
}
