import 'package:flutter/material.dart';
import 'package:stare/pages/profile.dart';
import 'package:stare/widgets/animated_labels.dart';

import '../data/theme.dart';

void main() {
  runApp(RootApp());
}

class RootApp extends StatelessWidget {
  RootApp({Key? key}) : super(key: key);

  final GlobalKey<FadedLabelState> labelKey = GlobalKey<FadedLabelState>();

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Stare",
      home: SafeArea(
        child: Scaffold(
          body: ProfilePage(),
        ),
      ),
    );
  }
}
