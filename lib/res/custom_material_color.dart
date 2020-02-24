import 'package:flutter/material.dart';

class CustomMaterialColor
{
  static const MaterialColor main_color = MaterialColor(
    _mainColor,
    <int, Color>{
      50: Color(_mainColor),
      100: Color(_mainColor),
      200: Color(_mainColor),
      300: Color(_mainColor),
      400: Color(_mainColor),
      500: Color(_mainColor),
      600: Color(_mainColor),
      700: Color(_mainColor),
      800: Color(_mainColor),
      900: Color(_mainColor),
    },
  );
  static const int _mainColor = 0xffffd337;
}

