import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stare/data/style.dart';
import 'package:stare/widgets/utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            top: defaultPadding * 2,
            left: defaultPadding,
          ),
          child: Row(
            children: const <Widget>[
              NavWheel(),
              Spacer(),
            ],
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Text(
            "Let's see what can be done!",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        const ColumnGap(),
        SizedBox(
          height: 320,
          child: Container(
            width: 246,
            height: 310,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(defaultPadding * 2),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: defaultPadding * 2,
                  left: defaultPadding * 2,
                  child: Text(
                    "Eye",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: SizedBox(
                    height: 240,
                    width: 240,
                    child: SvgPicture.asset(
                      "assets/images/illustration.svg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const ColumnGap(),
        ElevatedButton(
          onPressed: () {},
          child: SvgPicture.asset(
            "assets/icons/arrow-left.svg",
            color: Colors.white,
          ),
        ),
        const ColumnGap()
      ],
    );
  }
}
