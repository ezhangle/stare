import 'package:flutter/material.dart';

import 'style.dart';

final ThemeData lightTheme = ThemeData(
  // colorScheme: const ColorScheme.light(
  //   primary: darkerGrey,
  //   secondary: darkGrey,
  //   background: grey,
  //   tertiary: lightGrey,
  // ),
  scaffoldBackgroundColor: Colors.white,
  fontFamily: "Poppins",
  textTheme: const TextTheme(
    displayLarge: display,
    headlineLarge: headline,
    titleLarge: title,
    labelLarge: label,
    bodyLarge: body,
  ),
);
