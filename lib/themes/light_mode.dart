import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade300,
    primary: Colors.grey,
    secondary: Colors.blue,
    inverseSurface: Colors.grey,
    tertiary: Colors.white,
    inversePrimary: Colors.grey.shade200,
    onTertiary: Colors.black,
  ),
);
