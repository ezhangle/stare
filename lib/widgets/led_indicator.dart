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
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: glow ? colorScheme.primary : colorScheme.tertiary,
        boxShadow: glow
            ? <BoxShadow>[
                BoxShadow(
                  color: colorScheme.primary,
                  offset: const Offset(0, 2),
                  blurRadius: size,
                )
              ]
            : null,
      ),
    );
  }
}
