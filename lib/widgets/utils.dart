import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../data/style.dart';

class ColumnGap extends StatelessWidget {
  const ColumnGap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      const SizedBox(height: defaultPadding * 2);
}

class SmallColumnGap extends StatelessWidget {
  const SmallColumnGap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const SizedBox(height: defaultPadding);
}

class RowGap extends StatelessWidget {
  const RowGap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      const SizedBox(width: defaultPadding * 2);
}

class SmallRowGap extends StatelessWidget {
  const SmallRowGap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const SizedBox(width: defaultPadding);
}

class NavBar extends StatelessWidget {
  final Widget child;

  const NavBar({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: defaultPadding * 2,
        left: defaultPadding,
      ),
      child: Row(
        children: <Widget>[
          child,
          const Spacer(),
        ],
      ),
    );
  }
}

class NavWheel extends StatelessWidget {
  const NavWheel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/icons/nav-wheel.svg",
      width: 40,
      color: Theme.of(context).colorScheme.secondary,
    );
  }
}

class BackArrow extends StatelessWidget {
  const BackArrow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/icons/arrow-left.svg",
      width: 32,
      color: Theme.of(context).colorScheme.secondary,
    );
  }
}

class NextButton extends StatelessWidget {
  const NextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: SvgPicture.asset(
        "assets/icons/arrow-right.svg",
        width: 32.0,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}

class SimpleLabel extends StatelessWidget {
  final String text;
  final bool roundedTop;
  final bool highlighted;
  final bool roundedBottom;
  final double bottomMargin;

  const SimpleLabel({
    Key? key,
    required this.text,
    this.bottomMargin = 1.0,
    this.roundedTop = false,
    this.highlighted = false,
    this.roundedBottom = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: bottomMargin),
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: highlighted
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.vertical(
          top: roundedTop ? const Radius.circular(defaultPadding) : Radius.zero,
          bottom: roundedBottom
              ? const Radius.circular(defaultPadding)
              : Radius.zero,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: defaultPadding * 0.75,
          color: highlighted
              ? Theme.of(context).colorScheme.onPrimary
              : Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
