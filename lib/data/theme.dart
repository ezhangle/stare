import 'package:flutter/material.dart';

import 'style.dart';

final ThemeData lightTheme = ThemeData(
  colorScheme: const ColorScheme.light(
    primary: Colors.black,
    secondary: darkerGrey,
    tertiary: darkGrey,
    background: grey,
    surface: lightGrey,
    onPrimary: Colors.white,
  ),
  scaffoldBackgroundColor: lightGrey,
  fontFamily: "Poppins",
  textTheme: TextTheme(
    // displayLarge: display,
    headlineLarge: headline,
    headlineMedium: headline.copyWith(fontSize: 40),
    headlineSmall: headline.copyWith(fontSize: 36),
    titleLarge: title,
    titleMedium: title.copyWith(fontSize: 24),
    titleSmall: title.copyWith(fontSize: 18, fontWeight: FontWeight.w400),
    labelLarge: label,
    labelMedium: label.copyWith(fontSize: 20),
    labelSmall: label.copyWith(fontSize: 16),
    bodyLarge: body,
    bodyMedium: body.copyWith(fontSize: 16),
    bodySmall: body.copyWith(fontSize: 12),
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
  dividerTheme: const DividerThemeData(
    thickness: 1,
    space: 0,
    color: lightGrey,
  ),
);
