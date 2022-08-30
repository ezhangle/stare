import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stare/data/style.dart';
import 'package:stare/widgets/panel.dart';

import '../../widgets/utils.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding,
              vertical: defaultPadding * 2,
            ),
            child: Row(
              children: <Widget>[
                const NavWheel(),
                const Spacer(),
                SvgPicture.asset(
                  "assets/icons/edit.svg",
                  color: colorScheme.secondary,
                  width: 40,
                )
              ],
            ),
          ),
          const ColumnGap(),
          Container(
            width: 128,
            height: 128,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black),
            ),
            clipBehavior: Clip.antiAlias,
            child: Placeholder(),
          ),
          const ColumnGap(),
          Text(
            "こんにちは",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.normal,
                ),
          ),
          Text(
            "Damein",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const ColumnGap(),
          Panel(
            children: <Widget>[
              PanelItem(
                title: "damien's everyday",
                child: Column(
                  children: <Widget>[
                    const SmallColumnGap(),
                    const SizedBox(
                      width: 180,
                      height: 180,
                      child: Placeholder(),
                    ),
                    const ColumnGap(),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _ActivityLabel(
                          color: colorScheme.primary,
                          title: "Sleep",
                          percent: "42",
                        ),
                        _ActivityLabel(
                          color: colorScheme.tertiary,
                          title: "Mobile",
                          percent: "17",
                        ),
                        _ActivityLabel(
                          color: colorScheme.background,
                          title: "Other",
                          percent: "41",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const ColumnGap(),
          Container(
            margin: const EdgeInsets.only(
              left: defaultPadding * 2,
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              "damien facts",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          const SmallColumnGap(),
          SizedBox(
            height: 188,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              children: const <_FactCard>[
                _FactCard(
                  value: 6101,
                  description: "days old",
                ),
                _FactCard(
                  value: 467,
                  description: "hours phone used",
                ),
                _FactCard(
                  value: 7926,
                  description: "hours spend sleeping",
                ),
              ],
            ),
          ),
          const ColumnGap(),
          Panel(
            children: <Widget>[
              PanelItem(
                title: "Mobile Activity",
                child: SizedBox(
                  height: 228,
                  child: Placeholder(),
                ),
              ),
            ],
          ),
          const ColumnGap(),
          Container(
            margin: const EdgeInsets.only(
              left: defaultPadding * 2,
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              "damien's mood",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          const SmallColumnGap(),
          SizedBox(
            height: 112, //56-80
            child: ListView.builder(
              itemCount: 8,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              itemBuilder: (context, index) =>
                  _MoodCard(date: "${index + 10} Aug"),
            ),
          ),
          const ColumnGap(),
        ],
      ),
    );
  }
}

class _MoodCard extends StatelessWidget {
  final String date;

  const _MoodCard({
    Key? key,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
      padding: const EdgeInsets.all(defaultPadding / 2),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(defaultPadding),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 64,
            height: 64,
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(defaultPadding),
            ),
            child: Placeholder(),
          ),
          Text(
            date,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _FactCard extends StatelessWidget {
  final num value;
  final String description;

  const _FactCard({
    Key? key,
    required this.value,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(defaultPadding / 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: defaultPadding * 2,
            height: defaultPadding * 2,
            padding: const EdgeInsets.all(defaultPadding / 2),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Placeholder(),
          ),
          const Spacer(),
          Text(
            value.toString(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            description,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}

class _ActivityLabel extends StatelessWidget {
  final Color color;
  final String title;
  final String percent;

  const _ActivityLabel({
    Key? key,
    required this.color,
    required this.title,
    required this.percent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SmallRowGap(),
        Text(
          "$title ",
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          "$percent%",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
