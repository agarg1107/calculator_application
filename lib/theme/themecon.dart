import 'package:calculator_application/color.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light
);
ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
      EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0)),
        shape: MaterialStateProperty.all<OutlinedBorder>
        (
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0))
        ),
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xff191919))
        ),
      ),
);