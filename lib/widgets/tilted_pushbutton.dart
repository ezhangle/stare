import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class TiltedPushButton extends StatelessWidget {
  final double width;
  final String artboard;
  final Function()? onTapDown;
  final RiveAnimationController animationController;

  const TiltedPushButton({
    Key? key,
    this.width = 28,
    this.onTapDown,
    required this.artboard,
    required this.animationController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 28,
      child: GestureDetector(
        onTapDown: (event) {
          animationController.isActive = true;
          onTapDown?.call();
        },
        // TODO: lower the shadow a bit
        child: RiveAnimation.asset(
          "assets/rive/widgets.riv",
          artboard: artboard,
          controllers: [animationController],
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
