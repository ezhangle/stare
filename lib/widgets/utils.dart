import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BigColumnGap extends StatelessWidget {
  const BigColumnGap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const SizedBox(height: 32.0);
}

class ColumnGap extends StatelessWidget {
  const ColumnGap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const SizedBox(height: 16.0);
}

class NavWheel extends StatelessWidget {
  const NavWheel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/icons/nav-wheel.svg",
      width: 40,
    );
  }
}
