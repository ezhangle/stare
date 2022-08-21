import 'package:flutter/material.dart';

import '../data/style.dart';

class ScheduleView extends StatelessWidget {
  const ScheduleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        ScheduleEntry(
          title: "Wake Up",
          subtitle: "Perform morning stretches and then have breakfast.",
          timestamp: "8:30 am",
        ),
        ScheduleEntry(
          title: "Meeting with John",
          subtitle: "Discuss about scraper working.",
          timestamp: "12:00 pm",
        ),
      ],
    );
  }
}

class ScheduleEntry extends StatelessWidget {
  final String title;
  final String subtitle;
  final String timestamp;

  const ScheduleEntry({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.timestamp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: defaultPadding),
      constraints: const BoxConstraints(
        minHeight: 96,
      ),
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
          const Spacer(),
          Container(
            width: 236,
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
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
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
