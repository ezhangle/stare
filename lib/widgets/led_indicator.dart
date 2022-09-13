import 'package:flutter/material.dart';

import '../data/style.dart';

class LEDIndicator extends StatelessWidget {
  final bool glow;
  final double size;

  const LEDIndicator(
      {Key? key, this.glow = false, this.size = defaultPadding / 2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: defaultTransitionDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: glow
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.background,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: glow
                ? Theme.of(context).colorScheme.primary
                : Colors.transparent,
            offset: Offset(0, size / 4),
            blurRadius: size,
          )
        ],
      ),
    );
  }
}
