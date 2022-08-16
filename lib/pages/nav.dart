import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:stare/data/style.dart';

import '../widgets/utils.dart';

class NavPage extends StatefulWidget {
  final String currentTab;

  const NavPage({Key? key, required this.currentTab}) : super(key: key);

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  late String selectedTab;

  @override
  void initState() {
    super.initState();
    selectedTab = widget.currentTab;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        const RiveAnimation.asset(
          "assets/rive/ocean.riv",
          fit: BoxFit.fitHeight,
          animations: ["light_mode", "idle"],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 1.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <String>[
              "Home",
              "colgap",
              "Profile",
              "colgap",
              "Today",
              "colgap",
              "Exercise",
              "colgap",
              "Perform",
              "colgap",
              "Shelf"
            ]
                .map((String item) => item == "colgap"
                    ? const ColumnGap()
                    : NavLabel(
                        item,
                        selected: selectedTab == item,
                        onTap: () => setState(() => selectedTab = item),
                      ))
                .toList(),
          ),
        )
      ],
    );
  }
}

class NavLabel extends StatelessWidget {
  final String labelText;
  final bool selected;
  final Function onTap;

  const NavLabel(
    this.labelText, {
    Key? key,
    required this.onTap,
    this.selected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Text(
        labelText,
        style: selected
            ? Theme.of(context).textTheme.labelLarge!.copyWith(
                fontWeight: FontWeight.w600,
                shadows: <BoxShadow>[
                  BoxShadow(
                    offset: const Offset(0, defaultPadding / 2),
                    color: Theme.of(context).colorScheme.secondary,
                    blurRadius: 64,
                  ),
                ],
              )
            : Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
      ),
    );
  }
}
