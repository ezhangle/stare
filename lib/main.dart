import 'package:flutter/material.dart';

import 'data/theme.dart';
import 'pages/mood_selector.dart';

void main() {
  runApp(const RootApp());
}

class RootApp extends StatelessWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      title: "Stare",
      home: const Scaffold(
        body: SafeArea(
          child: MoodSelectorPage(),
        ),
      ),
    );
  }
}
