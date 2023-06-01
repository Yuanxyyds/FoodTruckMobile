import 'package:flutter/material.dart';

import 'constants.dart';

/// This class contains the [ThemeData] for the entire app
class FoodTruckThemeData {
  /// The primary [ThemeData] object of the app
  static ThemeData themeData = ThemeData(
    primaryColor: Constants.primaryColor,
    primaryColorLight: Constants.primaryColorLight,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Constants.backgroundColor,
    useMaterial3: true,
    fontFamily: 'Poppins',
    appBarTheme: const AppBarTheme(
      color: Constants.backgroundColor,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Constants.primaryColorLight,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    ),
    buttonTheme: ButtonThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Constants.primaryColorLight,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
    ),
  );
}
