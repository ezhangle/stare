import 'package:flutter/material.dart';

class MoodSlider extends StatefulWidget {
  final Color color;
  final double width;
  final double height;
  final double thumbSize;
  final double trackHeight;
  final Function(double)? onChange;

  const MoodSlider({
    Key? key,
    required this.color,
    this.onChange,
    this.width = 256,
    this.height = 128,
    this.thumbSize = 40,
    this.trackHeight = 8,
  }) : super(key: key);

  @override
  State<MoodSlider> createState() => _MoodSliderState();
}

class _MoodSliderState extends State<MoodSlider>
    with SingleTickerProviderStateMixin {
  late final double _widthOneTenth;
  late final double _widthNinth;
  late Offset _dragPosition;

  // animation
  late AnimationController _animationController;
  late Animation _sliderAnimation;

  double _animationBegin = 0;
  double _animationEnd = 0;

  bool _dragging = false;

  double sliderValue = 50;

  @override
  void initState() {
    super.initState();

    _widthOneTenth = widget.width * 0.1;
    _widthNinth = widget.width * 0.9;
    _dragPosition = Offset(_widthOneTenth, 0);
    _animationBegin = _animationEnd = widget.height / 2;

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _initAnimation();

    _animationController.forward();
  }

  void _initAnimation() {
    _sliderAnimation = Tween<double>(
      begin: _animationBegin,
      end: _animationEnd,
    ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.bounceOut));
    _sliderAnimation.addListener(() => setState(() {}));
  }

  void _clampDragPosition() {
    // Y Axis
    if (_dragPosition.dy >= widget.height) {
      _dragPosition = Offset(_dragPosition.dx, widget.height);
    } else if (_dragPosition.dy <= 0) {
      _dragPosition = Offset(_dragPosition.dx, 0);
    }
    // X Axis
    if (_dragPosition.dx >= _widthNinth) {
      _dragPosition = Offset(_widthNinth, _dragPosition.dy);
    } else if (_dragPosition.dx <= _widthOneTenth) {
      _dragPosition = Offset(_widthOneTenth, _dragPosition.dy);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          _dragging = true;
          _dragPosition = details.localPosition;
          _clampDragPosition();
          widget.onChange?.call(_dragPosition.dx / widget.width);
        });
      },
      onPanEnd: (details) {
        setState(() {
          if (_dragging == false) {
            // tap event, no drag involved
            return;
          }

          _dragging = false;

          // animate back to initial state
          _animationBegin = _dragPosition.dy;
          _animationEnd = widget.height / 2;

          _animationController.reset();
          _initAnimation();

          _animationController.forward();
        });
      },
      child: SizedBox(
        width: widget.width,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              width: widget.width,
              height: widget.height,
              child: CustomPaint(
                painter: SliderPainter(
                  color: Colors.black,
                  dragPosition: _dragging
                      ? _dragPosition
                      : Offset(_dragPosition.dx, _sliderAnimation.value),
                ),
              ),
            ),
            Positioned(
              top: _getThumbY(
                _dragging ? _dragPosition.dy : _sliderAnimation.value,
              ),
              left: _dragPosition.dx,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutCubic,
                width: widget.thumbSize,
                height: widget.thumbSize,
                transform: Matrix4.identity()
                  ..translate(-20.0, -20.0)
                  // ..rotateZ(0.78)
                  ..scale(_dragging ? 0.9 : 1.0),
                transformAlignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                    width: _dragging
                        ? widget.trackHeight * 1.4
                        : widget.trackHeight,
                  ),
                  borderRadius: BorderRadius.circular(widget.thumbSize * 0.4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _getThumbY(double y) {
    // mid-point x of the mid-points
    // of AB and BC respectively
    //
    //            B
    //           /\
    //          /  \
    //         •-❌-•
    //        /      \
    //       /        \
    //      A          C

    return (widget.height / 2 + y) / 2;
  }
}

class SliderPainter extends CustomPainter {
  final Color color;
  final Offset dragPosition;

  SliderPainter({required this.color, required this.dragPosition});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8;

    Path path = Path();

    path.moveTo(0, size.height / 2);
    path.quadraticBezierTo(
        dragPosition.dx, dragPosition.dy, size.width, size.height / 2);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
