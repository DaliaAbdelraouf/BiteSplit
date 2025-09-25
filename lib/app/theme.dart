import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.white,   
    primary: Colors.black,   
    secondary: Color(0xff4B5563)
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Color(0xFF171717), 
    primary: Colors.black,
    secondary: Color(0xff4B5563),
    secondaryContainer: Color(0xFF242B33),
    tertiaryContainer:Color.fromARGB(255, 34, 33, 33)
  ),

);


class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
