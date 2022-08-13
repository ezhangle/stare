import 'package:flutter/material.dart';
import 'package:stare/widgets/animated_labels.dart';
import 'package:stare/widgets/flip_list.dart';

import '../data/style.dart';

const List<String> moods = [
  "Happy",
  "Angry",
  "Sad",
  "Tired",
  "Working",
  "DND",
];

class MoodSelectorPage extends StatefulWidget {
  const MoodSelectorPage({Key? key}) : super(key: key);

  @override
  State<MoodSelectorPage> createState() => _MoodSelectorPageState();
}

class _MoodSelectorPageState extends State<MoodSelectorPage> {
  final GlobalKey<FadedLabelState> labelKey = GlobalKey<FadedLabelState>();
  String _mood = moods[0];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: <Widget>[
          const Spacer(),
          Text(
            "How are you doing damien?", // ?username
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 32),
          FlipListViewBuilder(
            count: moods.length,
            builder: ((context, idx) {
              final String imagePath =
                  "assets/images/moods/${moods[idx].toLowerCase()}.jpg";
              return Container(
                height: 224,
                width: 224,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(imagePath),
                  ),
                ),
              );
            }),
            onChange: (idx) => setState((() {
              _mood = moods[idx];
              labelKey.currentState?.change(_mood);
            })),
          ),
          const SizedBox(height: 48),
          FadedLabel(
            key: labelKey,
            defaultValue: _mood,
            textStyle: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(height: 64),
        ],
      ),
    );
  }
}
