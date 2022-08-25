import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rive/rive.dart';
import 'package:stare/widgets/tilted_pushbutton.dart';
import 'package:stare/widgets/utils.dart';

import '../data/properties.dart';
import '../data/style.dart';

class DigitalClock extends StatefulWidget {
  const DigitalClock({
    Key? key,
  }) : super(key: key);

  @override
  State<DigitalClock> createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> {
  late final RiveAnimationController _hourPlusBtnController;
  late final RiveAnimationController _hourMinusBtnController;
  late final RiveAnimationController _minutePlusBtnController;
  late final RiveAnimationController _minuteMinusBtnController;

  late int hour;
  late int minute;

  @override
  void initState() {
    super.initState();

    // animation controllers
    _minutePlusBtnController = OneShotAnimation("push", autoplay: false);
    _minuteMinusBtnController = OneShotAnimation("push", autoplay: false);
    _hourMinusBtnController = OneShotAnimation("push", autoplay: false);
    _hourPlusBtnController = OneShotAnimation("push", autoplay: false);

    // init hour and minute
    hour = 12;
    minute = 1;
  }

  int? get _hourTenthPlace {
    if (hour < 10) {
      return null;
    } else {
      return (hour / 10).floor();
    }
  }

  int get _hourOnesPlace {
    if (hour < 10) {
      return hour;
    } else {
      return hour - ((hour / 10).floor() * 10);
    }
  }

  int get _minuteTenthPlace {
    if (minute < 10) {
      return 0;
    } else {
      return (minute / 10).floor();
    }
  }

  int get _minuteOnesPlace {
    if (minute < 10) {
      return minute;
    } else {
      return minute - ((minute / 10).floor() * 10);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    const Color clockColor = Color(0xffa8a8a8);
    return SizedBox(
      width: 256,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 46,
            child: Stack(
              children: <Widget>[
                Transform.translate(
                  offset: const Offset(0, 12),
                  child: SvgPicture.asset(
                    "assets/images/clock-back.svg",
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: defaultPadding * 0.75),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TiltedPushButton(
                        artboard: "plus-button",
                        animationController: _hourPlusBtnController,
                        onTapDown: () {
                          _hourPlusBtnController.isActive = true;
                          if (hour == 24) return;
                          setState(() => hour += 1);
                        },
                      ),
                      const SizedBox(width: defaultPadding / 2),
                      TiltedPushButton(
                        artboard: "minus-button",
                        animationController: _hourMinusBtnController,
                        onTapDown: () {
                          _hourMinusBtnController.isActive = true;
                          if (hour == 1) return;
                          setState(() => hour -= 1);
                        },
                      ),
                      const SmallRowGap(),
                      TiltedPushButton(
                        artboard: "plus-button",
                        animationController: _minutePlusBtnController,
                        onTapDown: () {
                          _minutePlusBtnController.isActive = true;
                          if (minute == 59) return;
                          setState(() => minute += 1);
                        },
                      ),
                      const SizedBox(width: defaultPadding / 2),
                      TiltedPushButton(
                        artboard: "minus-button",
                        animationController: _minuteMinusBtnController,
                        onTapDown: () {
                          _minuteMinusBtnController.isActive = true;
                          if (minute == 0) return;
                          setState(() => minute -= 1);
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 128,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(defaultPadding),
              border: Border.all(
                width: 2,
                color: clockColor,
              ),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _ClockLabel(number: _hourTenthPlace ?? 10),
                const SmallRowGap(),
                _ClockLabel(number: _hourOnesPlace),
                const _ClockSeperator(),
                _ClockLabel(number: _minuteTenthPlace),
                const SmallRowGap(),
                _ClockLabel(number: _minuteOnesPlace),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _hourPlusBtnController.dispose();
    _hourMinusBtnController.dispose();
    _minutePlusBtnController.dispose();
    _minuteMinusBtnController.dispose();
    super.dispose();
  }
}

class _ClockLabel extends StatelessWidget {
  final int number;

  const _ClockLabel({Key? key, this.number = 10}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(number >= 0 && number <= 10);
    return SizedBox(
      height: 44,
      width: 26,
      child: Column(
        children: <Widget>[
          _HorizontalSegment(glow: clockLabels[number]![0]),
          Row(
            children: <Widget>[
              _VerticalSegment(glow: clockLabels[number]![1]),
              const Spacer(),
              _VerticalSegment(glow: clockLabels[number]![2]),
            ],
          ),
          _HorizontalSegment(glow: clockLabels[number]![3]),
          Row(
            children: <Widget>[
              _VerticalSegment(glow: clockLabels[number]![4]),
              const Spacer(),
              _VerticalSegment(glow: clockLabels[number]![5]),
            ],
          ),
          _HorizontalSegment(glow: clockLabels[number]![6]),
        ],
      ),
    );
  }
}

class _HorizontalSegment extends StatelessWidget {
  final bool glow;

  const _HorizontalSegment({Key? key, this.glow = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: defaultTransitionDuration,
      width: defaultPadding,
      height: defaultPadding / 4,
      decoration: BoxDecoration(
        color: glow
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(defaultPadding / 4),
        boxShadow: glow
            ? <BoxShadow>[
                BoxShadow(
                  color: Theme.of(context).colorScheme.tertiary,
                  blurRadius: defaultPadding / 4,
                ),
              ]
            : null,
      ),
    );
  }
}

class _VerticalSegment extends StatelessWidget {
  final bool glow;

  const _VerticalSegment({Key? key, this.glow = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: defaultTransitionDuration,
      width: defaultPadding / 4,
      height: defaultPadding,
      decoration: BoxDecoration(
        color: glow
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(defaultPadding / 4),
        boxShadow: glow
            ? <BoxShadow>[
                BoxShadow(
                  color: Theme.of(context).colorScheme.tertiary,
                  blurRadius: defaultPadding / 4,
                ),
              ]
            : null,
      ),
    );
  }
}

class _ClockSeperator extends StatelessWidget {
  const _ClockSeperator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double size = defaultPadding / 3;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
      height: size * 2 + defaultPadding,
      width: size,
      child: Column(
        children: [
          Container(
            height: size,
            width: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.primary,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Theme.of(context).colorScheme.tertiary,
                  blurRadius: defaultPadding / 4,
                ),
              ],
            ),
          ),
          const SmallColumnGap(),
          Container(
            height: size,
            width: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.primary,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Theme.of(context).colorScheme.tertiary,
                  blurRadius: defaultPadding / 4,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
