import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  scaffoldBackgroundColor: Colors.grey.shade900,
  colorScheme: ColorScheme.dark(
    surface: const Color.fromARGB(255, 20, 20, 20),
    primary: const Color.fromARGB(255, 122, 122, 122),
    secondary: Colors.amber.shade400,
    inverseSurface: Colors.amber.shade400,
    tertiary: const Color.fromRGBO(47, 47, 47, 1),
    inversePrimary: Colors.black45,
    onTertiary: Colors.white,
  ),
);
