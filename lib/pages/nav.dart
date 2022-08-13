import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../widgets/utils.dart';

class NavPage extends StatelessWidget {
  const NavPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        const RiveAnimation.asset(
          "assets/rive/ocean.riv",
          fit: BoxFit.fitHeight,
          animations: ["light_mode", "idle"],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget>[
            SizedBox(height: 128.0),
            NavLabel("Home"),
            ColumnGap(),
            NavLabel("Exercise"),
            ColumnGap(),
            NavLabel("Perform"),
            ColumnGap(),
            NavLabel("Profile"),
            ColumnGap(),
            NavLabel("Shelf"),
          ],
        )
      ],
    );
  }
}

class NavLabel extends StatelessWidget {
  final String labelText;

  const NavLabel(this.labelText, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      labelText,
      style: Theme.of(context)
          .textTheme
          .labelLarge!
          .copyWith(fontWeight: FontWeight.w400),
    );
  }
}
