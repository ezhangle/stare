import 'package:flutter/material.dart';

import '../data/style.dart';

class LEDIndicator extends StatelessWidget {
  final bool glow;

  const LEDIndicator({Key? key, this.glow = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: defaultPadding / 2,
      height: defaultPadding / 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: glow ? colorScheme.primary : colorScheme.tertiary,
        boxShadow: glow
            ? <BoxShadow>[
                BoxShadow(
                  color: colorScheme.primary,
                  offset: const Offset(0, 2),
                  blurRadius: defaultPadding / 2,
                )
              ]
            : null,
      ),
    );
  }
}
