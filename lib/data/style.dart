import 'package:flutter/material.dart';

// * color pallete
const Color lightGrey = Color(0xfff2f2f2);
const Color grey = Color(0xffa8a8a8);
const Color darkGrey = Color(0xff545454);
const Color darkerGrey = Color(0xff1a1a1a);

// * text styles
const TextStyle baseTextStyle = TextStyle(
  height: 1.2,
  color: darkerGrey,
);
final TextStyle headlineLarge = baseTextStyle.copyWith(fontSize: 48);
final TextStyle headlineMedium = baseTextStyle.copyWith(fontSize: 44);
final TextStyle headlineSmall = baseTextStyle.copyWith(fontSize: 40);
final TextStyle labelLarge = baseTextStyle.copyWith(fontSize: 32);
final TextStyle labelMedium = baseTextStyle.copyWith(fontSize: 28);
final TextStyle labelSmall = baseTextStyle.copyWith(fontSize: 24);
