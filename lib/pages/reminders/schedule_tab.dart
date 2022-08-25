import 'package:flutter/material.dart';

import '../../data/style.dart';
import '../../widgets/led_indicator.dart';
import '../../widgets/panel.dart';
import '../../widgets/push_button.dart';
import '../../widgets/schedule.dart';
import '../../widgets/utils.dart';

class ScheduleTab extends StatelessWidget {
  const ScheduleTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Panel(
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
