import 'package:flutter/material.dart';

import 'bedtime_tab.dart';
import '../../data/style.dart';
import '../../widgets/utils.dart';
import '../../widgets/list_picker.dart';

class RemindersPage extends StatelessWidget {
  const RemindersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: <Widget>[
        const NavBar(
          child: NavWheel(),
        ),
        const SmallColumnGap(),
        Container(
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              stops: const <double>[0, 0.20, 0.8, 1],
              colors: <Color>[
                Theme.of(context).scaffoldBackgroundColor,
                Theme.of(context).scaffoldBackgroundColor.withOpacity(0),
                Theme.of(context).scaffoldBackgroundColor.withOpacity(0),
                Theme.of(context).scaffoldBackgroundColor,
              ],
            ),
          ),
          child: ListPicker(
            width: width,
            height: defaultPadding * 2,
            itemExtent: width / 2,
            items: const <String>["Sedentary Alert", "Bedtime", "Schedule"],
            selectedTextStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onBackground,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        const ColumnGap(),
        const Expanded(
          // TODO: scroll page not nested tab-view
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: defaultPadding * 2),
            physics: BouncingScrollPhysics(),
            child: BedtimeTab(),
          ),
        ),
      ],
    );
  }
}
