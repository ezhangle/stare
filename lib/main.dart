import 'package:flutter/material.dart';
import 'package:stare/data/theme.dart';
import 'package:stare/widgets/animated_labels.dart';

import 'data/style.dart';

void main() {
  runApp(RootApp());
}

class RootApp extends StatelessWidget {
  RootApp({Key? key}) : super(key: key);

  final GlobalKey<FadedLabelState> labelKey = GlobalKey<FadedLabelState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      title: "Stare",
      home: Scaffold(
        body: Builder(builder: (context) {
          return SafeArea(
            minimum: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Display",
                    style: Theme.of(context).textTheme.displayLarge),
                Text("Headline",
                    style: Theme.of(context).textTheme.headlineLarge),
                Text("Title", style: Theme.of(context).textTheme.titleLarge),
                Text("Label", style: Theme.of(context).textTheme.labelLarge),
                Text("Body", style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
          );
        }),
      ),
    );
  }
}
