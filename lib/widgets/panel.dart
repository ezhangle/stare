import 'package:flutter/material.dart';
import 'package:stare/data/style.dart';

import 'utils.dart';

class Panel extends StatelessWidget {
  final List<Widget> children;

  const Panel({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(defaultPadding / 2),
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

class PanelTitleItem extends StatelessWidget {
  final String title;
  final Widget? leading;
  final Widget action;

  const PanelTitleItem({
    Key? key,
    required this.title,
    this.leading,
    required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: defaultPadding,
        horizontal: defaultPadding * 2,
      ),
      child: Row(
        children: [
          leading ?? const SizedBox(),
          leading != null ? const SmallRowGap() : const SizedBox(),
          Text(
            "Follow Schedule",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const Spacer(),
          action,
        ],
      ),
    );
  }
}

class PanelItem extends StatelessWidget {
  final Widget child;

  const PanelItem({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding * 1.5,
        vertical: defaultPadding,
      ),
      child: child,
    );
  }
}
