import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stare/data/style.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 32.0,
            left: 16.0,
          ),
          child: SvgPicture.asset(
            "assets/icons/nav-wheel.svg",
            width: 40,
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Mood specific message here.",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const SizedBox(height: 32.0),
        Container(
          height: 320,
          width: double.maxFinite,
          color: grey,
          alignment: Alignment.center,
          child: Text("actions placeholder"),
        ),
        const SizedBox(height: 64.0),
      ],
    );
  }
}
