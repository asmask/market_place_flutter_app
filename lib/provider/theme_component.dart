import 'package:flutter/material.dart';

AppBarTheme lightAppBarTheme() {
  return const AppBarTheme(
    color: Colors.white,
    elevation: 0,
    // ignore: deprecated_member_use
    brightness: Brightness.light,
    // ignore: prefer_const_constructors
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black,
      height: 1.5,
    ),
  );
}

AppBarTheme darkAppBarTheme() {
  return AppBarTheme(
    color: Colors.grey.shade900,
    elevation: 0,
    // ignore: deprecated_member_use
    brightness: Brightness.dark,
    // ignore: prefer_const_constructors
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      height: 1.5,
    ),
  );
}
