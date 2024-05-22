import 'package:flutter/material.dart';

const baseSpacing = 8.0;

class Spacing {
  static const double xxs = baseSpacing * 0.25;
  static const double xs = baseSpacing * 0.5;
  static const double s = baseSpacing;
  static const double m = baseSpacing * 2;
  static const double l = baseSpacing * 3;
  static const double xl = baseSpacing * 4;
  static const double xxl = baseSpacing * 5;
}

final theme = ThemeData(
  useMaterial3: true,
  primarySwatch: Colors.blueGrey,
  primaryColor: Colors.white,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.teal,
    brightness: Brightness.light,
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 72,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: TextStyle(
      fontSize: 30,
      fontStyle: FontStyle.italic,
    ),
    bodyMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
  ),
);
