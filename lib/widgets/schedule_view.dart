import 'package:flutter/material.dart';

import '../data/style.dart';
import 'digital_clock.dart';
import 'utils.dart';

const List<Map<String, String>> _scheduleData = [
  {
    "timestamp": "8:30 am",
    "title": "Wake Up",
    "description": "Perform morning stretches and then have breakfast.",
  },
  {
    "timestamp": "12:30 pm",
    "title": "Meeting with Damien",
    "description": "Scraper working and future development plans.",
  },
  {
    "timestamp": "4:00 pm",
    "title": "Workout",
    "description": "Pump some irons.",
  },
  {
    "timestamp": "5:00 pm",
    "title": "Evening Shift",
    "description": "Do evening shit.",
  },
];

class ScheduleView extends StatelessWidget {
  final double height;

  const ScheduleView({Key? key, this.height = 400}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: height,
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const <double>[
                0,
                0.1,
              ],
              colors: [
                Theme.of(context).colorScheme.onPrimary,
                Theme.of(context).colorScheme.onPrimary.withOpacity(0),
              ],
            ),
          ),
          child: ListView.builder(
            itemCount: _scheduleData.length,
            padding: const EdgeInsets.only(
              top: defaultPadding,
              bottom: defaultPadding * 4.5,
            ),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (_, index) {
              return _ScheduleEntry(
                timestamp: _scheduleData[index]["timestamp"]!,
                title: _scheduleData[index]["title"]!,
                description: _scheduleData[index]["description"]!,
              );
            },
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.only(
              bottom: defaultPadding / 2,
              top: defaultPadding * 4,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const <double>[0, 0.75],
                colors: [
                  Theme.of(context).colorScheme.onPrimary.withOpacity(0),
                  Theme.of(context).colorScheme.onPrimary,
                ],
              ),
            ),
            child: TextButton(
              onPressed: () async {
                showGeneralDialog(
                  context: context,
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const SizedBox(),
                  transitionBuilder: (_, animation, __, ___) {
                    final double curvedValue =
                        Curves.easeOut.transform(animation.value);
                    return Opacity(
                      opacity: curvedValue,
                      child: Transform.scale(
                        scale: 1.1 - (0.1 * curvedValue),
                        child: _dialog(context),
                      ),
                    );
                  },
                );
              },
              child: const Text("+ Add"),
            ),
          ),
        ),
      ],
    );
  }

  SimpleDialog _dialog(BuildContext context) {
    return SimpleDialog(
      title: Text(
        "Add Task",
        style: Theme.of(context).textTheme.titleMedium,
      ),
      titlePadding: const EdgeInsets.all(defaultPadding * 2),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: defaultPadding * 2),
      children: <Widget>[
        Text(
          "Time",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const Align(
          alignment: Alignment.center,
          child: DigitalClock(
            hour: 12,
            minute: 30,
            width: 228,
          ),
        ),
        const ColumnGap(),
        Text(
          "Title",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        TextField(
          maxLength: 30,
          style: Theme.of(context).textTheme.bodyLarge,
          decoration: const InputDecoration(
            hintText: "Eye exercise",
          ),
        ),
        const ColumnGap(),
        Text(
          "Description",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        TextField(
          maxLength: 60,
          style: Theme.of(context).textTheme.bodyLarge,
          decoration: const InputDecoration(
            hintText: "Rest my eyes.",
          ),
        ),
        const ColumnGap(),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: Theme.of(context).outlinedButtonTheme.style?.copyWith(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.all(
                          defaultPadding * 0.75,
                        ),
                      ),
                    ),
                child: Text(
                  "Cancel",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.tertiary),
                ),
              ),
            ),
            const SmallRowGap(),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Save"),
              ),
            ),
          ],
        ),
        const ColumnGap(),
      ],
    );
  }
}

class _ScheduleEntry extends StatelessWidget {
  final String title;
  final String description;
  final String timestamp;

  const _ScheduleEntry({
    Key? key,
    required this.timestamp,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: defaultPadding / 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 80,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  timestamp,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontSize: 14),
                ),
                const _TimeTick(),
                const _TimeTick(),
                const _TimeTick(),
              ],
            ),
          ),
          const RowGap(),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(defaultPadding * 1.25),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(defaultPadding / 2),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: defaultPadding / 4),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TimeTick extends StatelessWidget {
  const _TimeTick({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      width: defaultPadding,
      color: Theme.of(context).colorScheme.background,
    );
  }
}
