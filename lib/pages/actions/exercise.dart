import 'package:flutter/material.dart';
import 'package:stare/data/properties.dart';

import '../../data/style.dart';
import '../../widgets/actions_listview.dart';
import '../../widgets/utils.dart';

class ExercisePage extends StatelessWidget {
  const ExercisePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const NavBar(
          child: NavWheel(),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Text(
            "Exercises",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const ColumnGap(),
        SizedBox(
          height: 304,
          child: Align(
            alignment: Alignment.center,
            child: ActionsListView(
              width: MediaQuery.of(context).size.width,
              items: exerciseOptions,
            ),
          ),
        ),
        const ColumnGap(),
        const Align(
          alignment: Alignment.center,
          child: NextButton(),
        ),
        const ColumnGap(),
      ],
    );
  }
}
