import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' hide Colors;

class CirclePanAngleExample extends StatefulWidget {
  final double radius;

  const CirclePanAngleExample({Key? key, this.radius = 128}) : super(key: key);

  @override
  State<CirclePanAngleExample> createState() => _CirclePanAngleExampleState();
}

class _CirclePanAngleExampleState extends State<CirclePanAngleExample> {
  late final Offset _center;
  late final double _width;
  Offset _dragOffset = Offset.zero;
  double _oppositeSide = 0;
  int _dragQuarter = 0;
  double _angle = 0;

  @override
  void initState() {
    super.initState();
    _width = widget.radius * 2;
    _center = Offset(widget.radius, widget.radius);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onPanUpdate: (details) {
          if (details.localPosition.dx < 0 ||
              details.localPosition.dx > _width ||
              details.localPosition.dy < 0 ||
              details.localPosition.dy > _width) return;

          _dragOffset = details.localPosition;

          Offset perpendicularIntersection = Offset.zero;

          if (_dragOffset.dx > widget.radius && _dragOffset.dx < _width) {
            if (_dragOffset.dy > 0 && _dragOffset.dy < widget.radius) {
              // Quarter 1
              _dragQuarter = 1;

              perpendicularIntersection = Offset(_center.dx, _dragOffset.dy);
            } else if (_dragOffset.dy > widget.radius &&
                _dragOffset.dy < _width) {
              // Quarter 2
              _dragQuarter = 2;

              perpendicularIntersection = Offset(_dragOffset.dx, _center.dy);
            }
          } else if (_dragOffset.dx > 0 && _dragOffset.dx < widget.radius) {
            if (_dragOffset.dy > 0 && _dragOffset.dy < widget.radius) {
              // Quarter 4
              _dragQuarter = 4;

              perpendicularIntersection = Offset(_dragOffset.dx, _center.dy);
            } else if (_dragOffset.dy > widget.radius &&
                _dragOffset.dy < _width) {
              // Quarter 3
              _dragQuarter = 3;

              perpendicularIntersection = Offset(_center.dx, _dragOffset.dy);
            }
          }

          _oppositeSide = (perpendicularIntersection - _dragOffset).distance;
          final double hypotaneous = (_center - _dragOffset).distance;

          setState(() {
            _angle = math.asin(_oppositeSide / hypotaneous) +
                radians(90 * (_dragQuarter - 1));
          });
        },
        child: SizedBox(
          height: _width,
          width: _width,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: _width,
                width: _width,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 2),
                ),
              ),
              Positioned(
                top: 0,
                left: widget.radius,
                child: Transform.rotate(
                  angle: _angle,
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 2,
                    height: widget.radius,
                    color: Colors.red,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: widget.radius - 8,
                child: Transform.rotate(
                  angle: _angle,
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: widget.radius,
                    alignment: Alignment.center,
                    child: Text("${degrees(_angle).toInt()}∘"),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: widget.radius,
                child: Container(
                  width: widget.radius,
                  height: widget.radius,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: _dragQuarter == 1
                            ? Colors.black12
                            : Colors.transparent),
                  ),
                ),
              ),
              Positioned(
                top: widget.radius,
                left: widget.radius,
                child: Container(
                  width: widget.radius,
                  height: widget.radius,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: _dragQuarter == 2
                            ? Colors.black12
                            : Colors.transparent),
                  ),
                ),
              ),
              Positioned(
                top: widget.radius,
                left: 0,
                child: Container(
                  width: widget.radius,
                  height: widget.radius,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: _dragQuarter == 3
                            ? Colors.black12
                            : Colors.transparent),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  width: widget.radius,
                  height: widget.radius,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: _dragQuarter == 4
                            ? Colors.black12
                            : Colors.transparent),
                  ),
                ),
              ),
              _dragQuarter == 1
                  ? Positioned(
                      top: _dragOffset.dy,
                      left: widget.radius,
                      child: Container(
                        height: 2,
                        width: _oppositeSide,
                        color: Colors.green,
                      ),
                    )
                  : const SizedBox(),
              _dragQuarter == 2
                  ? Positioned(
                      top: widget.radius,
                      left: _dragOffset.dx,
                      child: Container(
                        height: _oppositeSide,
                        width: 2,
                        color: Colors.green,
                      ),
                    )
                  : const SizedBox(),
              _dragQuarter == 3
                  ? Positioned(
                      top: _dragOffset.dy,
                      right: widget.radius,
                      child: Container(
                        height: 2,
                        width: _oppositeSide,
                        color: Colors.green,
                      ),
                    )
                  : const SizedBox(),
              _dragQuarter == 4
                  ? Positioned(
                      bottom: widget.radius,
                      left: _dragOffset.dx,
                      child: Container(
                        height: _oppositeSide,
                        width: 2,
                        color: Colors.green,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

class CircleAngleExmaple extends StatelessWidget {
  const CircleAngleExmaple({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 256,
        width: 256,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 256,
              width: 256,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 2),
              ),
            ),
            Positioned(
              top: 0,
              left: 128,
              child: Container(
                height: 128,
                width: 2,
                color: Colors.black,
              ),
            ),

            Positioned(
              top: 64,
              left: 128,
              child: Container(
                height: 12,
                width: 12,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 128,
              child: Transform.rotate(
                angle: radians(60),
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 128,
                  width: 2,
                  color: Colors.black,
                ),
              ),
            ),
            Positioned(
              top: 64,
              left: 0,
              child: Container(
                height: 2,
                width: 238,
                color: Colors.green,
              ),
            ),
            Positioned(
              top: 0,
              left: 238,
              child: Container(
                height: 64,
                width: 2,
                color: Colors.red,
              ),
            ),
            // points
            Positioned(
              top: -32,
              left: 96,
              child: Text("(128, 0)"),
            ),
            Positioned(
              top: 65,
              left: 250,
              child: Text("(238, 64)"),
            ),
            Positioned(
              top: 132,
              left: 96,
              child: Text("(128, 128)"),
            ),
            Positioned(
              top: 32,
              left: 52,
              child: Text("(128, 64)"),
            ),
            Positioned(
              top: 84,
              left: 100,
              child: Text("64"),
            ),
            Positioned(
              top: 100,
              left: 180,
              child: Text("128"),
            ),
            Positioned(
              top: 36,
              left: 164,
              child: Text("110"),
            ),
          ],
        ),
      ),
    );
  }
}
