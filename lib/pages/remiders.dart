import 'package:flutter/material.dart';
import 'package:stare/data/properties.dart';
import 'package:stare/data/style.dart';
import 'package:stare/widgets/led_indicator.dart';
import 'package:stare/widgets/list_picker.dart';
import 'package:stare/widgets/panel.dart';
import 'package:stare/widgets/push_button.dart';
import 'package:stare/widgets/schedule.dart';
import 'package:stare/widgets/utils.dart';

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
            items: const <String>[
              "Sedentary Alert",
              "Mobile Activity",
              "Schedule"
            ],
            selectedTextStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onBackground,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        const ColumnGap(),
        Panel(
          children: <Widget>[
            const PanelTitleItem(
              title: "Follow Schedule",
              leading: LEDIndicator(),
              action: PushButton(),
            ),
            const Divider(),
            PanelItem(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Days",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SmallColumnGap(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      DayLabel("M", selected: true),
                      DayLabel("T", selected: true),
                      DayLabel("W", selected: false),
                      DayLabel("T", selected: true),
                      DayLabel("F", selected: true),
                      DayLabel("S", selected: true),
                      DayLabel("S", selected: false),
                    ],
                  ),
                  const SmallColumnGap(),
                ],
              ),
            ),
            const Divider(),
            const PanelItem(
              child: ScheduleView(),
            ),
          ],
        ),
      ],
    );
  }
}

class DayLabel extends StatelessWidget {
  final String day;
  final bool selected;
  final Function()? onTap;

  const DayLabel(
    this.day, {
    Key? key,
    this.selected = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding - 2),
        child: Text(day,
            style: selected
                ? Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.w800,
                    shadows: <BoxShadow>[
                      BoxShadow(
                        offset: const Offset(0, defaultPadding / 2),
                        color: Theme.of(context).colorScheme.secondary,
                        blurRadius: defaultPadding * 2,
                      ),
                    ],
                  )
                : Theme.of(context).textTheme.bodyMedium),
      ),
    );
  }
}
