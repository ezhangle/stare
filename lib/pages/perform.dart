import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stare/widgets/utils.dart';

import '../data/properties.dart';
import '../widgets/action_card.dart';
import '../providers/scroll_notifier.dart';

class PerformPage extends StatelessWidget {
  PerformPage({Key? key}) : super(key: key);

  final PageController pageController = PageController(viewportFraction: 0.8);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 32.0,
          ),
          child: NavWheel(),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Perform",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        const SizedBox(height: 32.0),
        SizedBox(
          height: 384,
          width: double.maxFinite,
          child: ChangeNotifierProvider(
            create: (_) => ScrollNotifier(pageController),
            child: PageView.builder(
              physics: const BouncingScrollPhysics(),
              controller: pageController,
              itemCount: performOptions.length,
              itemBuilder: ((context, index) {
                return ExerciseCard(
                  index: index,
                  imageName: performOptions[index].toLowerCase(),
                  labelText: performOptions[index],
                );
              }),
            ),
          ),
        ),
        const SizedBox(height: 64.0),
      ],
    );
  }
}
