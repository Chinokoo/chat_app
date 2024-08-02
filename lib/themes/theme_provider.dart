import 'package:chat_app/themes/dark_mode.dart';
import 'package:chat_app/themes/light_mode.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  // Initial theme data
  ThemeData _themeData = lightMode;
  //getting the theme data
  ThemeData get themeData => _themeData;
  // if is dark mode.
  bool get isDarkMode => _themeData == darkMode;

  //setting the theme data
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  //toggle the theme mode
  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
