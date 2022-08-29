import 'package:flutter/material.dart';
import 'package:stare/data/properties.dart';
import 'package:stare/data/style.dart';
import 'package:stare/widgets/digital_clock.dart';
import 'package:stare/widgets/panel.dart';
import 'package:stare/widgets/utils.dart';

import '../../widgets/led_indicator.dart';
import '../../widgets/push_button.dart';

class BedtimeTab extends StatelessWidget {
  const BedtimeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Panel(
          children: <Widget>[
            PanelItem(
              title: "Wake Up at",
              child: DigitalClock(hour: 7, minute: 30),
            ),
          ],
        ),
        const ColumnGap(),
        Panel(
          children: <Widget>[
            const PanelTitleItem(
              title: "Alarm",
              leading: LEDIndicator(),
              action: PushButton(),
            ),
            const Divider(),
            PanelItem(
              title: "Sound",
              child: Container(
                height: 196,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(defaultPadding),
                ),
                child: ListView.builder(
                  itemCount: alarmSounds.length,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(defaultPadding),
                  itemBuilder: (context, index) {
                    return SimpleLabel(
                      text: alarmSounds[index],
                      roundedTop: index == 0,
                      highlighted: index == 2,
                      roundedBottom: index == alarmSounds.length - 1,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
