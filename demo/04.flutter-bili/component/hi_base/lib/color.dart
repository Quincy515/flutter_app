import 'package:flutter/material.dart';

const MaterialColor white = const MaterialColor(
  0xFFFFFFFF,
  <int, Color>{
    50: Color(0xFFFFFFFF),
    100: Color(0xFFFFFFFF),
    200: Color(0xFFFFFFFF),
    300: Color(0xFFFFFFFF),
    400: Color(0xFFFFFFFF),
    500: Color(0xFFFFFFFF),
    600: Color(0xFFFFFFFF),
    700: Color(0xFFFFFFFF),
    800: Color(0xFFFFFFFF),
    900: Color(0xFFFFFFFF),
  },
);

/// 主色调
const MaterialColor primary = const MaterialColor(
  0xff00B9AD,
  const <int, Color>{
    50: const Color.fromRGBO(43, 184, 146, 0.5),
  },
);

class HiColor {
  static const Color green = Color(0xFF00B9AD);
  static const Color dark_green = Color(0xFF00A69C);
  static const Color red = Color(0xFFF64346);
  static const Color dark_red = Color(0xFFDF494B);
  static const Color dark_bg = Color(0xFF18191A);
}
