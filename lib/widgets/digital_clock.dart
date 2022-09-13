import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'utils.dart';
import '../data/style.dart';
import 'tilted_pushbutton.dart';
import 'led_number_display.dart';

// TODO add am/pm selector

class DigitalClock extends StatefulWidget {
  final int hour;
  final int minute;
  final double width; // TODO better relative sizing

  const DigitalClock({
    Key? key,
    this.width = 256,
    required this.hour,
    required this.minute,
  }) : super(key: key);

  @override
  State<DigitalClock> createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> {
  late int _hour;
  late int _minute;

  bool _keepIncreasing = false;
  bool _keepDecreasing = false;

  @override
  void initState() {
    super.initState();
    // init hour and minute
    _hour = widget.hour;
    _minute = widget.minute;
  }

  void _increaseMinuteExponentially() async {
    while (_keepIncreasing && _minute != 59) {
      setState(() => _minute++);
      await Future.delayed(shortTransitionDuration);
    }
  }

  void _decreaseMinuteExponentially() async {
    while (_keepDecreasing && _minute != 0) {
      setState(() => _minute--);
      await Future.delayed(shortTransitionDuration);
    }
  }

  void _increaseHourExponentially() async {
    while (_keepIncreasing && _hour != 23) {
      setState(() => _hour++);
      await Future.delayed(shortTransitionDuration);
    }
  }

  void _decreaseHourExponentially() async {
    while (_keepDecreasing && _hour != 0) {
      setState(() => _hour--);
      await Future.delayed(shortTransitionDuration);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    const Color clockColor = Color(0xffa8a8a8);
    final double buttonWidth = widget.width * 0.1;
    return SizedBox(
      width: widget.width,
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
                        width: buttonWidth,
                        iconName: "plus-icon",
                        onTapDown: () {
                          if (_hour != 23) {
                            setState(() => _hour += 1);
                          }
                        },
                        onLongPressStart: () {
                          _keepIncreasing = true;
                          _increaseHourExponentially();
                        },
                        onLongPressEnd: () => _keepIncreasing = false,
                      ),
                      const SizedBox(width: defaultPadding / 2),
                      TiltedPushButton(
                        width: buttonWidth,
                        iconName: "minus-icon",
                        onTapDown: () {
                          if (_hour != 0) {
                            setState(() => _hour -= 1);
                          }
                        },
                        onLongPressStart: () {
                          _keepDecreasing = true;
                          _decreaseHourExponentially();
                        },
                        onLongPressEnd: () => _keepDecreasing = false,
                      ),
                      const SmallRowGap(),
                      TiltedPushButton(
                        width: buttonWidth,
                        iconName: "plus-icon",
                        onTapDown: () {
                          if (_minute != 59) {
                            setState(() => _minute += 1);
                          }
                        },
                        onLongPressStart: () {
                          _keepIncreasing = true;
                          _increaseMinuteExponentially();
                        },
                        onLongPressEnd: () => _keepIncreasing = false,
                      ),
                      const SizedBox(width: defaultPadding / 2),
                      TiltedPushButton(
                        width: buttonWidth,
                        iconName: "minus-icon",
                        onTapDown: () {
                          if (_minute != 0) {
                            setState(() => _minute -= 1);
                          }
                        },
                        onLongPressStart: () {
                          _keepDecreasing = true;
                          _decreaseMinuteExponentially();
                        },
                        onLongPressEnd: () => _keepDecreasing = false,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            height: widget.width * 0.5,
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
                DoubleLEDNumberDisplay(value: _hour),
                const _ClockSeperator(),
                DoubleLEDNumberDisplay(
                  value: _minute,
                  showZeroInTenthsPlace: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ClockSeperator extends StatelessWidget {
  const _ClockSeperator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double size = defaultPadding / 4;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
      height: size * 2 + defaultPadding,
      width: size,
      child: Column(
        children: [
          _dot(size, context),
          const SmallColumnGap(),
          _dot(size, context),
        ],
      ),
    );
  }

  Widget _dot(double size, BuildContext context) {
    return Container(
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
    );
  }
}
