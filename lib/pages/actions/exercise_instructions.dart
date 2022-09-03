import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stare/widgets/utils.dart';

class ExerciseInstructionsPage extends StatelessWidget {
  const ExerciseInstructionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const NavBar(
          child: BackArrow(),
        ),
        const Spacer(),
        SizedBox(
          height: 352,
          child: SvgPicture.asset("assets/images/illustration.svg"),
        ),
        const Spacer(),
        SizedBox(
          width: 320,
          child: Text(
            "Wash your eyes carefully before starting the exercise."
            " You can also wipe your eye-lids with a soaked towel/cloth.",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
