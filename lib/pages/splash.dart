import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:stare/controllers/ocean_animation.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final OceanAnimationController _animationController =
      OceanAnimationController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height / 4,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          alignment: Alignment.topCenter,
          child: Text(
            "Random quote on the splash screen",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        GestureDetector(
          // ? controller use test
          onTap: () {
            _animationController.stopIdle();
            // fade text
            _animationController.playJump = true;
          },
          child: RiveAnimation.asset(
            "assets/rive/ocean.riv",
            fit: BoxFit.fitWidth,
            alignment: Alignment.bottomCenter,
            animations: const ["light_mode"],
            controllers: [_animationController],
          ),
        ),
      ],
    );
  }
}
