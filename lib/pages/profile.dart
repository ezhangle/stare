import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/utils.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 32.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const NavWheel(),
              SvgPicture.asset(
                "assets/icons/edit.svg",
                width: 40,
              )
            ],
          ),
        ),
        Container(
          width: 128,
          height: 128,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.asset(
            "assets/images/moods/angry.jpg",
            fit: BoxFit.cover,
          ),
        ),
        const ColumnGap(),
        Text(
          "Greetings",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Text(
          "Damien",
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        const BigColumnGap(),
        SizedBox(
          width: double.maxFinite,
          child: Card(
            child: Column(
              children: <Widget>[
                Text(
                  "damien's everyday",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
