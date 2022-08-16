import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:stare/controllers/ocean_animation.dart';
import 'package:stare/data/style.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final OceanAnimationController _animationController =
      OceanAnimationController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          // ? controller use test
          onTap: () {
            _animationController.stopIdle();
            // fade text
            _animationController.playJump = true;
          },
          child: RiveAnimation.asset(
            // TODO: implement dark mode
            "assets/rive/ocean.riv",
            artboard: "waves",
            fit: BoxFit.fitWidth,
            alignment: Alignment.bottomCenter,
            animations: const ["light_mode"],
            controllers: [_animationController],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          height: MediaQuery.of(context).size.height / 1.4,
          alignment: Alignment.center,
          child: Text(
            "Random quote on the splash screen",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                ),
          ),
        ),
      ],
    );
  }
}
