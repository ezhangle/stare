import 'package:rive/rive.dart';
import 'package:flutter/material.dart';

import '../../data/style.dart';
import '../../widgets/dial.dart';
import '../../widgets/panel.dart';
import '../../widgets/push_button.dart';
import '../../widgets/led_indicator.dart';

class SedentaryAlertTab extends StatelessWidget {
  const SedentaryAlertTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Panel(
      children: <Widget>[
        const PanelTitleItem(
          title: "On",
          leading: LEDIndicator(),
          action: PushButton(),
        ),
        const Divider(),
        const PanelItem(
          title: "Interval",
          child: Dial(
            items: <int>[15, 20, 30, 45, 60],
            radius: 112,
          ),
        ),
        const Divider(),
        PanelItem(
          title: "Alert Position", // TODO: improve design
          child: Container(
            width: 196,
            height: 320,
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(defaultPadding),
              border: Border.all(color: colorScheme.background, width: 2),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: const <Widget>[
                    _ReminderPositionOption(),
                    Spacer(),
                    _ReminderPositionOption(),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const <Widget>[
                    _ReminderPositionOption(),
                    _ReminderPositionOption(),
                    _ReminderPositionOption(),
                  ],
                ),
                Row(
                  children: const <Widget>[
                    _ReminderPositionOption(),
                    Spacer(),
                    _ReminderPositionOption(),
                  ],
                ),
              ],
            ),
          ),
        ),
        const Divider(),
        const PanelTitleItem(
          title: "Sound",
          action: SizedBox(
            height: 48,
            width: 48,
            child: RiveAnimation.asset(
              "assets/rive/widgets.riv",
              artboard: "switch",
              stateMachines: ["state-machine"],
            ),
          ),
        ),
      ],
    );
  }
}

class _ReminderPositionOption extends StatelessWidget {
  const _ReminderPositionOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: defaultPadding * 3,
      height: defaultPadding * 3,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(defaultPadding / 2),
      ),
      alignment: Alignment.center,
      child: Text(
        "Top Right",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
