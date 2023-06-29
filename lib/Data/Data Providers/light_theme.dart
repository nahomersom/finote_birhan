import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData lightTheme = ThemeData(
  fontFamily: 'Poppins',



  // primarySwatch: ColorResources.primaryColor,

  textTheme: TextTheme(
    headlineSmall: const TextStyle(
        fontSize: 20.0, color: ColorResources.textColor),
    headlineMedium: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color:  ColorResources.textColor),
    displaySmall: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        color:  ColorResources.textColor),
    displayMedium: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.w700,
        color:  ColorResources.textColor),
    displayLarge: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.w300,
        color:  ColorResources.textColor),
    titleMedium: TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.w500,
        color:  ColorResources.textColor),
    titleLarge: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color:  ColorResources.textColor),
    titleSmall: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color:  ColorResources.textColor),
    bodyMedium: TextStyle(
        fontSize: 12.0, color:  ColorResources.textColor),
    bodyLarge: TextStyle(
        fontSize: 14.0, color:  ColorResources.textColor),
    bodySmall: TextStyle(
        fontSize: 12.0, color: ColorResources.textColor),
  ),
);