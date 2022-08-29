import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stare/data/style.dart';
import 'package:stare/widgets/led_number_display.dart';
import 'package:vector_math/vector_math.dart' hide Colors;

class Dial extends StatefulWidget {
  final double radius;
  final List<int> items;
  final int defaultItemIndex;
  final Function(int)? onChanged;
  // TODO: custom label builder
  final Widget Function(BuildContext, int)? innerWidget;

  const Dial({
    Key? key,
    required this.items,
    this.onChanged,
    this.innerWidget,
    this.radius = 128,
    this.defaultItemIndex = 0,
  }) : super(key: key);

  @override
  State<Dial> createState() => _DialState();
}

class _DialState extends State<Dial> with SingleTickerProviderStateMixin {
  late final double _width;
  late final Offset _center;
  late final double _itemAngleExtent;

  late final AnimationController _animationController;
  late Animation _animation;

  late double _animationBegin;
  late double _animationEnd;

  late double _angle;
  late int _selectedItemIndex;
  bool _dragging = false;
  Offset _dragOffset = Offset.zero;

  @override
  void initState() {
    super.initState();

    assert(widget.items.length > 2); // use a switch instead

    _width = widget.radius * 2;
    _center = Offset(widget.radius, widget.radius);
    _itemAngleExtent = 360 / widget.items.length; // TODO: find in radians

    _selectedItemIndex = widget.defaultItemIndex;
    _angle = radians(_itemAngleExtent * _selectedItemIndex);
    _animationBegin = _angle;
    _animationEnd = _angle;

    // animation initialization
    _animationController = AnimationController(
      vsync: this,
      duration: defaultTransitionDuration,
    );
    _initAnimation();
    _animation.addListener(() => setState(() {}));
  }

  void _initAnimation() {
    _animation = Tween<double>(
      begin: _animationBegin,
      end: _animationEnd,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCirc,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        SvgPicture.asset(
          "assets/images/dial.svg",
          height: _width,
          width: _width,
        ),
        GestureDetector(
          onPanUpdate: _handlePanUpdate,
          onPanEnd: _handlePanEnd,
          child: Transform.rotate(
            angle: _dragging ? _angle : _animation.value,
            child: SvgPicture.asset(
              "assets/images/dial-indicator.svg",
              height: _width,
              width: _width,
            ),
          ),
        ),
        Positioned(
          top: 0,
          // left: auto,
          child: SizedBox(
            height: widget.radius,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: widget.items.map(
                (int item) {
                  final double rotation =
                      radians(widget.items.indexOf(item) * _itemAngleExtent);
                  return Transform.rotate(
                    angle: rotation,
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: widget.radius * 0.56,
                      alignment: Alignment.topCenter,
                      child: Transform.rotate(
                        angle: -rotation,
                        child: Text(
                          item.toString(),
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.background,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ),
        widget.innerWidget == null
            ? DoubleLEDNumberDisplay(
                value: widget.items[_selectedItemIndex],
                segmentWidth: widget.radius / 8,
              )
            : widget.innerWidget!.call(context, _selectedItemIndex),
      ],
    );
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    // dragging out of bounding box
    if (details.localPosition.dx < 0 ||
        details.localPosition.dx > _width ||
        details.localPosition.dy < 0 ||
        details.localPosition.dy > _width) return;

    setState(
      () {
        _dragging = true;
        _dragOffset = details.localPosition;
        _angle = _offsetToRadians(_dragOffset);

        // check for option change
        final int angleInDegrees = degrees(_angle).toInt();
        if (angleInDegrees % _itemAngleExtent == 0) {
          _selectedItemIndex = angleInDegrees ~/ _itemAngleExtent;
          widget.onChanged?.call(_selectedItemIndex);
        }
      },
    );
  }

  void _handlePanEnd(DragEndDetails details) {
    final int angleInDegrees = degrees(_angle).toInt();
    final int lowerIndex = angleInDegrees ~/ _itemAngleExtent;
    final int upperIndex =
        angleInDegrees ~/ _itemAngleExtent + 1 == widget.items.length
            ? 0
            : angleInDegrees ~/ _itemAngleExtent + 1;
    final double lowerAngle = lowerIndex * _itemAngleExtent;
    final double upperAngle =
        upperIndex == 0 ? 360 : upperIndex * _itemAngleExtent;

    final double lowerDiff = angleInDegrees - lowerAngle;
    final double upperDiff = upperAngle - angleInDegrees;

    _animationBegin = _angle;

    if (lowerDiff <= upperDiff) {
      _animationEnd = radians(lowerAngle);
      _selectedItemIndex = lowerIndex;
    } else {
      _animationEnd = radians(upperAngle);
      _selectedItemIndex = upperIndex;
    }

    widget.onChanged?.call(_selectedItemIndex);
    setState(() => _dragging = false);

    _animationController.reset();
    _initAnimation();
    _animationController.forward();
  }

  double _offsetToRadians(Offset offset) {
    Offset perpendicularIntersection = Offset.zero;
    int dragQuarter = 1;

    if (offset.dx > widget.radius && offset.dx < _width) {
      if (offset.dy > 0 && offset.dy < widget.radius) {
        // Quarter 1
        dragQuarter = 1;

        perpendicularIntersection = Offset(_center.dx, offset.dy);
      } else if (offset.dy > widget.radius && offset.dy < _width) {
        // Quarter 2
        dragQuarter = 2;

        perpendicularIntersection = Offset(offset.dx, _center.dy);
      }
    } else if (offset.dx > 0 && offset.dx < widget.radius) {
      if (offset.dy > 0 && offset.dy < widget.radius) {
        // Quarter 4
        dragQuarter = 4;

        perpendicularIntersection = Offset(offset.dx, _center.dy);
      } else if (offset.dy > widget.radius && offset.dy < _width) {
        // Quarter 3
        dragQuarter = 3;

        perpendicularIntersection = Offset(_center.dx, offset.dy);
      }
    }

    final double oppositeSide = (perpendicularIntersection - offset).distance;
    final double hypotaneous = (_center - offset).distance;

    return math.asin(oppositeSide / hypotaneous) +
        radians(90 * (dragQuarter - 1));
  }
}
