import 'package:flutter/material.dart';

// * color pallete
const Color lightGrey = Color(0xfff2f2f2);
const Color grey = Color(0xffa8a8a8);
const Color darkGrey = Color(0xff545454);
const Color darkerGrey = Color(0xff1a1a1a);

// * text styles
const TextStyle baseTextStyle = TextStyle(
  height: 1.25,
  fontFamily: "Poppins",
  color: Colors.black,
);
final TextStyle display = baseTextStyle.copyWith(
  fontSize: 64,
  fontWeight: FontWeight.w800,
);
final TextStyle headline = baseTextStyle.copyWith(
  fontSize: 48,
  fontWeight: FontWeight.w800,
);
final TextStyle title = baseTextStyle.copyWith(
  fontSize: 32,
  fontWeight: FontWeight.w600,
);
final TextStyle label = baseTextStyle.copyWith(
  fontSize: 32,
  fontWeight: FontWeight.w400,
);
final TextStyle body = baseTextStyle.copyWith(
  fontSize: 24,
  height: 1.5,
  color: darkGrey,
  fontWeight: FontWeight.w400,
);

// * size and spacing
const double defaultPadding = 16.0;
