import 'package:flutter/material.dart';

import '../data/style.dart';
import '../widgets/actions_listview.dart';
import '../widgets/utils.dart';

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
          child: ActionsListView(width: MediaQuery.of(context).size.width),
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
