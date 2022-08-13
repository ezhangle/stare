import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stare/data/properties.dart';
import 'package:stare/providers/scroll_notifier.dart';
import 'package:stare/widgets/action_card.dart';
import 'package:stare/widgets/utils.dart';

class ExercisePage extends StatelessWidget {
  ExercisePage({Key? key}) : super(key: key);

  final pageController = PageController(viewportFraction: 0.75);

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
            "Exercises",
            style: Theme.of(context).textTheme.headlineMedium,
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
              itemCount: exerciseOptions.length,
              itemBuilder: ((context, index) {
                if (index == 0) return const EyeExerciseCard();
                return ExerciseCard(
                  index: index,
                  imageName: exerciseOptions[index].toLowerCase(),
                  labelText: exerciseOptions[index],
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
