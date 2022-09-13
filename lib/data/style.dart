import 'package:flutter/material.dart';

// * color pallete
const Color lightGrey = Color(0xfff2f2f2);
const Color grey = Color(0xffcccccc);
const Color darkGrey = Color(0xff545454);
const Color darkerGrey = Color(0xff1a1a1a);

// * text styles
const double buttonFontSize = 18;
const TextStyle baseTextStyle = TextStyle(
  height: 1.25,
  fontFamily: "Poppins",
  color: Colors.black,
);
final TextStyle headline = baseTextStyle.copyWith(
  fontSize: 44,
  fontWeight: FontWeight.w800,
);
final TextStyle title = baseTextStyle.copyWith(
  fontSize: 24,
  fontWeight: FontWeight.w600,
);
final TextStyle label = baseTextStyle.copyWith(
  fontSize: 24,
  color: darkerGrey,
  letterSpacing: 0,
  fontWeight: FontWeight.w400,
);
final TextStyle body = baseTextStyle.copyWith(
  fontSize: 16,
  height: 1.5,
  color: darkGrey,
  letterSpacing: 0,
  fontWeight: FontWeight.w400,
);

// * size and spacing
const double defaultPadding = 20.0;

// * animation
const Duration defaultTransitionDuration = Duration(milliseconds: 400);
