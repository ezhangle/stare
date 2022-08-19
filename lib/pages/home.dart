import 'package:flutter/material.dart';

import '../data/style.dart';
import '../widgets/utils.dart';
import '../widgets/actions_listview.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const NavBar(
          child: NavWheel(),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Text(
            "Let's see what can be done!",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        const ColumnGap(),
        SizedBox(
          height: 304,
          child: ActionsListView(
            width: MediaQuery.of(context).size.width,
          ),
        ),
        const ColumnGap(),
        const NextButton(),
        const ColumnGap()
      ],
    );
  }
}
