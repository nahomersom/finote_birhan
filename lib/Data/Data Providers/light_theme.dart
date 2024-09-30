import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData lightTheme = ThemeData(
  fontFamily: 'CenturyGothic',
  scaffoldBackgroundColor: ColorResources.scaffoldColor,
  appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xffffffff), surfaceTintColor: Colors.transparent),
  // primarySwatch: ColorResources.primaryColor,
  colorScheme: ThemeData().colorScheme.copyWith(
        primary: ColorResources.scaffoldColor,
      ),
  radioTheme: RadioThemeData(
    fillColor:
        WidgetStateColor.resolveWith((states) => ColorResources.textColor),
  ),
  // Define TextButton theme
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      padding: const EdgeInsets.all(0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      backgroundColor:
          ColorResources.secondaryColor, // Secondary color for buttons
    ),
  ),

  textTheme: const TextTheme(
    headlineSmall: TextStyle(fontSize: 18.0, color: ColorResources.textColor),
    headlineMedium: TextStyle(fontSize: 28.0, color: ColorResources.textColor),
    displaySmall: TextStyle(fontSize: 18.0, color: ColorResources.textColor),
    displayMedium: TextStyle(fontSize: 28.0, color: ColorResources.textColor),
    displayLarge: TextStyle(fontSize: 36.0, color: ColorResources.textColor),
    titleMedium: TextStyle(
        fontSize: 17.0,
        fontWeight: FontWeight.w500,
        color: ColorResources.textColor),
    titleLarge: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.normal,
        color: ColorResources.textColor),
    titleSmall: TextStyle(
        fontSize: 11.0,
        fontWeight: FontWeight.w500,
        color: ColorResources.textColor),
    bodyMedium: TextStyle(fontSize: 19.0, color: ColorResources.textColor),
    bodyLarge: TextStyle(fontSize: 14.0, color: ColorResources.textColor),
    bodySmall: TextStyle(fontSize: 14.0, color: ColorResources.textColor),
  ),
);
