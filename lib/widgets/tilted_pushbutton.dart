import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class TiltedPushButton extends StatefulWidget {
  final double width;
  final String iconName;
  final Function()? onTapDown;

  const TiltedPushButton({
    Key? key,
    this.width = 28,
    this.onTapDown,
    required this.iconName,
  }) : super(key: key);

  @override
  State<TiltedPushButton> createState() => _TiltedPushButtonState();
}

class _TiltedPushButtonState extends State<TiltedPushButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 28,
      child: GestureDetector(
        onTapDown: (event) => widget.onTapDown?.call(),
        child: RiveAnimation.asset(
          "assets/rive/widgets.riv",
          artboard: "push-button",
          animations: [widget.iconName],
          stateMachines: const ["state-machine"],
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
