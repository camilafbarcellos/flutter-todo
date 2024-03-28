import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.pink[700],
  scaffoldBackgroundColor: Colors.pink[50],
  appBarTheme: AppBarTheme(
    color: Colors.pink[50],
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.pink[800]),
    bodyMedium: TextStyle(color: Colors.pink[800]),
  ),
  hintColor: Colors.pink[700],
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.pink[200],
      foregroundColor: Colors.white,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.pink[200],
    foregroundColor: Colors.white,
  ),
  cardTheme: CardTheme(
    color: Colors.pink[100],
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.pink[100],
    selectedItemColor: Colors.pink[300],
    unselectedItemColor: Colors.pink[100],
  ),
  canvasColor: Colors.pink[50],
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.pink[100],
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.pinkAccent),
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  radioTheme: RadioThemeData(
    fillColor:
        MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return Colors.pinkAccent;
      }
      return null;
    }),
  ),
  dialogTheme: DialogTheme(
    backgroundColor: Colors.pink[50],
    titleTextStyle: TextStyle(
        color: Colors.pink[800], fontWeight: FontWeight.bold, fontSize: 24.0),
    contentTextStyle: TextStyle(color: Colors.pink[800]),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: Colors.pink[800]),
  ),
);
