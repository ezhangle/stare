import 'package:flutter/material.dart';

import 'style.dart';

final ThemeData lightTheme = ThemeData(
  colorScheme: const ColorScheme.light(
    primary: darkerGrey,
    secondary: darkGrey,
    tertiary: grey,
    background: lightGrey,
    onPrimary: Colors.white,
    onBackground: Colors.black,
  ),
  scaffoldBackgroundColor: Colors.white,
  fontFamily: "Poppins",
  textTheme: TextTheme(
    displayLarge: display,
    headlineLarge: headline,
    headlineMedium: headline.copyWith(fontSize: 44),
    headlineSmall: headline.copyWith(fontSize: 40),
    titleLarge: title,
    titleMedium: title.copyWith(fontSize: 28),
    titleSmall: title.copyWith(fontSize: 24),
    labelLarge: label,
    labelMedium: label.copyWith(fontSize: 28),
    labelSmall: label.copyWith(fontSize: 24),
    bodyLarge: body,
    bodyMedium: body.copyWith(fontSize: 20),
    bodySmall: body.copyWith(fontSize: 16),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        vertical: defaultPadding * 0.75,
        horizontal: defaultPadding * 2,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultPadding),
      ),
    ),
  ),
);
