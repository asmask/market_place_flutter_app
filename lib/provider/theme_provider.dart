import 'package:flutter/material.dart';

import 'theme_component.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  bool get isDarkMode => themeMode == ThemeMode.dark;
  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: Colors.white,
    selectedRowColor: Colors.deepPurple,
    primarySwatch: Colors.deepPurple,
    appBarTheme: darkAppBarTheme(),
    canvasColor: Colors.deepPurple,
    iconTheme: const IconThemeData(color: Colors.deepPurple),
    colorScheme: const ColorScheme.dark(primary: Colors.deepPurple)
        .copyWith(secondary: Colors.deepPurple),
    brightness: Brightness.dark,
    //unselectedWidgetColor: Colors.white60,

    //disabledColor: Colors.blue
  );
  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primaryColor: Colors.black,
      colorScheme: const ColorScheme.light(primary: Colors.deepPurple)
          .copyWith(secondary: Colors.deepPurple),
      selectedRowColor: Colors.deepPurple,
      appBarTheme: lightAppBarTheme(),
      //canvasColor: Colors.deepPurple,
      primarySwatch: Colors.deepPurple,
      iconTheme: const IconThemeData(color: Colors.deepPurple),
      cardColor: Colors.brown.shade50,
      brightness: Brightness.light);
}
