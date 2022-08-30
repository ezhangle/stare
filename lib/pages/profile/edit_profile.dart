import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stare/data/style.dart';
import 'package:stare/widgets/panel.dart';
import 'package:stare/widgets/utils.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const NavBar(child: BackArrow()),
        const ColumnGap(),
        Panel(
          children: <Widget>[
            RawPanelItem(
              child: Column(
                children: <Widget>[
                  _Title("Edit Profile"),
                  const SmallColumnGap(),
                  const Divider(),
                  const SmallColumnGap(),
                  _SubTitle("looking like"),
                  const SmallColumnGap(),
                  SizedBox(
                    height: 160,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: <Widget>[
                        Container(
                          width: 128,
                          height: 128,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: const Placeholder(),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: 64,
                            height: 64,
                            padding: const EdgeInsets.all(defaultPadding),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            child: SvgPicture.asset(
                              "assets/icons/edit.svg",
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SmallColumnGap(),
                  _SubTitle("living since"),
                  const SmallColumnGap(),
                  Container(
                    height: 128,
                    width: 256,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(defaultPadding),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 40,
                          child: ListWheelScrollView(
                            itemExtent: 32,
                            children: [
                              Text("11"),
                              Text("12"),
                              Text("13"),
                              Text("14"),
                              Text("15"),
                              Text("16"),
                              Text("17"),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 64,
                          child: ListWheelScrollView(
                            itemExtent: 32,
                            children: [
                              Text("Mar"),
                              Text("Apr"),
                              Text("Jun"),
                              Text("Jul"),
                              Text("Aug"),
                              Text("Oct"),
                              Text("Nov"),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          child: ListWheelScrollView(
                            itemExtent: 32,
                            children: [
                              Text("2010"),
                              Text("2011"),
                              Text("2012"),
                              Text("2013"),
                              Text("2014"),
                              Text("2015"),
                              Text("2016"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Title extends StatelessWidget {
  final String text;

  const _Title(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

class _SubTitle extends StatelessWidget {
  final String text;

  const _SubTitle(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.tertiary,
            ),
      ),
    );
  }
}
