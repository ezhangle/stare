import 'package:flutter/material.dart';
import 'package:stare/data/properties.dart';

import '../../data/style.dart';
import '../../widgets/led_indicator.dart';
import '../../widgets/panel.dart';
import '../../widgets/push_button.dart';
import '../../widgets/schedule_view.dart';
import '../../widgets/utils.dart';

class ScheduleTab extends StatefulWidget {
  const ScheduleTab({Key? key}) : super(key: key);

  @override
  State<ScheduleTab> createState() => _ScheduleTabState();
}

class _ScheduleTabState extends State<ScheduleTab> {
  late bool _followSchedule;
  late Map<String, bool> _daysToFollow;

  @override
  void initState() {
    super.initState();
    // init from config data
    _followSchedule = false;
    _daysToFollow = {
      "MONDAY": true,
      "TUESDAY": true,
      "WEDNESDAY": true,
      "THURSDAY": true,
      "FRIDAY": true,
      "SATURDAY": false,
      "SUNDAY": false,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Panel(
      children: <Widget>[
        PanelTitleItem(
          title: "Follow Schedule",
          leading: LEDIndicator(glow: _followSchedule),
          action: PushButton(
            onTap: () {
              setState(() => _followSchedule = !_followSchedule);
            },
          ),
        ),
        const Divider(),
        PanelItem(
          title: "Days",
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: weekDays
                .map(
                  (String day) => _WeekDayLabel(
                    day[0],
                    glow: _daysToFollow[day]!,
                    onTap: () => setState(
                      () => _daysToFollow[day] = !_daysToFollow[day]!,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        const Divider(),
        const RawPanelItem(
          child: ScheduleView(),
        ),
      ],
    );
  }
}

class _WeekDayLabel extends StatelessWidget {
  final String day;
  final bool glow;
  final Function()? onTap;

  const _WeekDayLabel(
    this.day, {
    Key? key,
    this.glow = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: defaultPadding * 2.25,
        height: 21, // lineheight
        alignment: Alignment.center,
        child: Text(
          // TODO animate glow/textStyle
          day,
          style: glow
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
              : Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
