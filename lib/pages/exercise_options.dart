import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stare/data/style.dart';
import 'package:stare/widgets/utils.dart';

const items = 4;

class ExerciseOptionsPage extends StatelessWidget {
  const ExerciseOptionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const NavBar(
          child: BackArrow(),
        ),
        SizedBox(
          height: 272,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            itemCount: items,
            scrollDirection: Axis.horizontal,
            itemExtent: 288,
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 2),
            itemBuilder: (context, index) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                child: SubActionCard(),
              );
            },
          ),
        ),
        const ColumnGap(),
        const Indicator(
          itemCount: items,
          selectItem: 1,
        ),
        const Spacer(),
        Text(
          "Rapid Eye\nMovement",
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        const SmallColumnGap(),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Icon(Icons.timer_outlined),
            SmallRowGap(),
            Text(
              "2 min",
            ),
          ],
        ),
        const SmallColumnGap(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Text(
            "Rapid eye movements to break the stale nature of your eyes. Facilitates your eye muscles.",
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ),
        const Spacer(),
        NextButton(),
        const ColumnGap(),
      ],
    );
  }
}

class Indicator extends StatelessWidget {
  final int itemCount;
  final int selectItem;

  const Indicator({
    Key? key,
    required this.itemCount,
    required this.selectItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(itemCount, (index) {
        final bool selected = selectItem == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 800),
          curve: Curves.elasticOut,
          margin: const EdgeInsets.symmetric(horizontal: defaultPadding / 4),
          width: selected ? 32 : 16,
          height: 8,
          decoration: BoxDecoration(
            color: selected
                ? Theme.of(context).colorScheme.onBackground
                : Theme.of(context).colorScheme.tertiary,
            borderRadius: BorderRadius.circular(3),
            // boxShadow: <BoxShadow>[
            //   BoxShadow(
            //     offset: Offset(0, defaultPadding / 4),
            //     blurRadius: defaultPadding,
            //     color: selected
            //         ? Theme.of(context).colorScheme.secondary
            //         : Theme.of(context).colorScheme.background,
            //   ),
            // ],
          ),
        );
      }),
    );
  }
}

class SubActionCard extends StatelessWidget {
  const SubActionCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          height: 192,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiary,
            borderRadius: BorderRadius.circular(defaultPadding * 2),
          ),
        ),
        SizedBox(
          height: 224,
          width: 224,
          child: SvgPicture.asset(
            "assets/images/illustration.svg",
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
