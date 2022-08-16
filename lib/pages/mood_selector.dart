import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../data/style.dart';
import '../widgets/mood_slider.dart';

class MoodSelectorPage extends StatelessWidget {
  const MoodSelectorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            top: defaultPadding * 2,
            right: defaultPadding,
            left: defaultPadding,
          ),
          child: Text(
            "How are you doing damien?",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        Column(
          children: <Widget>[
            Text(
              "Happy",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            SvgPicture.asset(
              "assets/images/illustration.svg",
              height: 296,
              fit: BoxFit.contain,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: defaultPadding * 3),
          child: MoodSlider(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
            width: MediaQuery.of(context).size.width,
            height: 64,
          ),
        ),
      ],
    );
  }
}
