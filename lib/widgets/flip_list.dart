import 'dart:math';

import 'package:flutter/material.dart';

enum Direction { left, right }

class FlipListViewBuilder extends StatefulWidget {
  final int count;
  final Function(BuildContext context, int idx) builder;
  final Function(int idx)? onChange;

  const FlipListViewBuilder({
    Key? key,
    required this.count,
    required this.builder,
    this.onChange,
  }) : super(key: key);

  @override
  FlipListViewBuilderState createState() => FlipListViewBuilderState();
}

class FlipListViewBuilderState extends State<FlipListViewBuilder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _flip;
  int _curChild = 0;
  double _angle = 0;
  Direction _direction = Direction.left;
  double _backSideAngle = 0.0;
  bool _flipped = false;
  bool _hasPrev = false;
  bool _hasNext = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 200,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: handleDragStart,
      onHorizontalDragUpdate: handleDragUpdate,
      onHorizontalDragEnd: handleDragEnd,
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(_angle / 180 * pi)
          ..rotateY(_backSideAngle),
        alignment: Alignment.center,
        child: widget.builder(context, _curChild),
      ),
    );
  }

  void setDirection(double deltaDir) {
    // ? details.delta.direction : 0 means >> right & pi (3.14) means << left
    if (deltaDir == 0.0) {
      _direction = Direction.right;
    } else {
      _direction = Direction.left;
    }
  }

  void handleDragStart(DragStartDetails details) {
    _controller.reset();
    setState(() {
      _flipped = false;
      _angle = 0;
      _backSideAngle = 0.0;
    });
  }

  void handleDragUpdate(DragUpdateDetails details) {
    setDirection(details.delta.direction);
    if (_direction == Direction.right) {
      if (_angle <= 210 && _hasPrev) {
        updateCardRight(details.delta.dx);
      }
      return;
    } else if (_hasNext) {
      if (_angle == 0) _angle = 360;
      if (_angle >= 150) {
        updateCardLeft(details.delta.dx);
      }
    }
  }

  void updateCardRight(double? dx) {
    setState(() {
      if (dx != null) {
        _angle += dx;
        _angle %= 360;
      }

      if (_curChild != 0 && _angle >= 90.0 && _angle < 210 && !_flipped) {
        _backSideAngle = pi;
        _curChild--;
        _flipped = true;

        widget.onChange?.call(_curChild);
      }
    });
  }

  void updateCardLeft(double? dx) {
    setState(() {
      if (dx != null) {
        _angle += dx;
        _angle %= 360;
      }

      if (_curChild + 1 != widget.count && _angle <= 270.0 && !_flipped) {
        _backSideAngle = pi;
        _curChild++;
        _flipped = true;

        widget.onChange?.call(_curChild);
      }
    });
  }

  void handleDragEnd(DragEndDetails details) {
    checkPrevNext();

    final double end;
    if (_angle <= 90) {
      end = 0;
    } else if (_angle >= 315) {
      end = 360;
    } else if (_angle >= 90) {
      end = 180;
    } else {
      end = 0;
    }

    if (_angle != 0.0 && _angle != 180.0) {
      _flip = Tween<double>(
        begin: _angle,
        end: end,
      ).animate(_controller)
        ..addListener(finishFlip);
      _controller.forward();
    }
  }

  void finishFlip() {
    checkPrevNext();
    setState(() {
      if (_angle != 180.0 && _angle != 0.0) {
        _angle = _flip.value;
      }
    });

    if (_direction == Direction.right) {
      updateCardRight(null);
    } else if (_curChild != (widget.count - 1)) {
      updateCardLeft(null);
    }
  }

  void checkPrevNext() {
    setState(() {
      if (_curChild == 0) {
        _hasPrev = false;
      } else {
        _hasPrev = true;
      }

      if (_curChild + 1 == widget.count) {
        _hasNext = false;
      } else {
        _hasNext = true;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
