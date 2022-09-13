import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class TiltedPushButton extends StatelessWidget {
  final double width;
  final String iconName;
  final Function()? onTapDown;
  final Function()? onLongPressStart;
  final Function()? onLongPressEnd;

  const TiltedPushButton({
    super.key,
    this.width = 28,
    this.onTapDown,
    this.onLongPressStart,
    this.onLongPressEnd,
    required this.iconName,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 28,
      child: GestureDetector(
        onTapDown: (event) => onTapDown?.call(),
        onLongPress: () => onLongPressStart?.call(),
        onLongPressEnd: (details) => onLongPressEnd?.call(),
        child: RiveAnimation.asset(
          "assets/rive/widgets.riv",
          artboard: "push-button",
          animations: [iconName],
          stateMachines: const ["state-machine"],
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
