import 'package:flutter/material.dart';

import 'style.dart';

final ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: lightGrey,
  fontFamily: "Poppins",
  textTheme: TextTheme(
    headlineLarge: headlineLarge,
    headlineMedium: headlineMedium,
    headlineSmall: headlineSmall,
    labelLarge: labelLarge,
    labelMedium: labelMedium,
    labelSmall: labelSmall,
  ),
  cardTheme: CardTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(32.0),
    ),
  ),
);
