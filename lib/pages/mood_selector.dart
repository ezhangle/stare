import 'package:flutter/material.dart';
import 'package:stare/widgets/utils.dart';

import '../data/style.dart';
import '../widgets/mood_slider.dart';

class MoodSelectorPage extends StatelessWidget {
  const MoodSelectorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding,
          ),
          child: Text(
            "How are you doing damien?",
            // "What's up damien?",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const ColumnGap(),
        const SizedBox(
          width: 256,
          height: 256,
          child: Placeholder(),
        ),
        const Spacer(),
        MoodSlider(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
          width: MediaQuery.of(context).size.width,
          height: 64,
        ),
        const SmallColumnGap(),
        const NextButton(),
        const ColumnGap(),
      ],
    );
  }
}
