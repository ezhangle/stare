import 'package:flutter/material.dart';

import '../data/properties.dart';
import '../data/style.dart';

class DoubleLEDNumberDisplay extends StatelessWidget {
  final int value;
  final double segmentWidth;
  final bool showZeroInTenthsPlace;

  const DoubleLEDNumberDisplay({
    Key? key,
    required this.value,
    this.segmentWidth = defaultPadding,
    this.showZeroInTenthsPlace = false,
  }) : super(key: key);

  int get _tenthsPlace {
    if (value < 10) {
      return showZeroInTenthsPlace ? 0 : 10;
    } else {
      return (value / 10).floor();
    }
  }

  int get _onesPlace {
    if (value < 10) {
      return value;
    } else {
      return value - (_tenthsPlace * 10);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SingleLEDNumberDisplay(value: _tenthsPlace, segmentWidth: segmentWidth),
        SizedBox(width: segmentWidth / 2),
        SingleLEDNumberDisplay(value: _onesPlace, segmentWidth: segmentWidth),
      ],
    );
  }
}

class SingleLEDNumberDisplay extends StatelessWidget {
  final int value;
  final double segmentWidth;

  const SingleLEDNumberDisplay(
      {Key? key, this.value = 10, this.segmentWidth = defaultPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(value >= 0 && value <= 10);
    return SizedBox(
      height: segmentWidth * 2.75,
      width: segmentWidth * 1.5,
      child: Column(
        children: <Widget>[
          _HorizontalSegment(
            glow: ledNumberDisplay[value]![0],
            width: segmentWidth,
          ),
          Row(
            children: <Widget>[
              _VerticalSegment(
                glow: ledNumberDisplay[value]![1],
                width: segmentWidth,
              ),
              const Spacer(),
              _VerticalSegment(
                glow: ledNumberDisplay[value]![2],
                width: segmentWidth,
              ),
            ],
          ),
          _HorizontalSegment(
            glow: ledNumberDisplay[value]![3],
            width: segmentWidth,
          ),
          Row(
            children: <Widget>[
              _VerticalSegment(
                glow: ledNumberDisplay[value]![4],
                width: segmentWidth,
              ),
              const Spacer(),
              _VerticalSegment(
                glow: ledNumberDisplay[value]![5],
                width: segmentWidth,
              ),
            ],
          ),
          _HorizontalSegment(
            glow: ledNumberDisplay[value]![6],
            width: segmentWidth,
          ),
        ],
      ),
    );
  }
}

class _HorizontalSegment extends StatelessWidget {
  final bool glow;
  final double width;

  const _HorizontalSegment(
      {Key? key, this.glow = false, this.width = defaultPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: defaultTransitionDuration,
      width: width,
      height: width / 4,
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
  final double width;

  const _VerticalSegment(
      {Key? key, this.glow = false, this.width = defaultPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: defaultTransitionDuration,
      width: width / 4,
      height: width,
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
