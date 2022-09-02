import 'package:flutter/material.dart';
import 'package:stare/data/properties.dart';
import 'package:stare/data/style.dart';
import 'package:stare/widgets/animated_labels.dart';

class MoodSlider extends StatefulWidget {
  final Color color;
  final double width;
  final double height;
  final double thumbSize;
  final double trackHeight;
  final Function(String)? onChange;

  const MoodSlider({
    Key? key,
    required this.color,
    this.onChange,
    this.width = 256,
    this.height = 128,
    this.thumbSize = 32,
    // TODO: trackHeight as much as illustration/rive-animation stroke width
    this.trackHeight = 4,
  }) : super(key: key);

  @override
  State<MoodSlider> createState() => _MoodSliderState();
}

class _MoodSliderState extends State<MoodSlider>
    with SingleTickerProviderStateMixin {
  late final double _trackStart;
  late final double _trackEnd;
  late final double _divisionExtent;
  late final double _labelPaddingLeft;
  late final double _labelPaddingRight;
  late Offset _dragPosition;

  // animation
  late AnimationController _animationController;
  late Animation _sliderAnimation;

  double _animationBegin = 0;
  double _animationEnd = 0;

  bool _dragging = false;

  // mood
  late String _mood;

  @override
  void initState() {
    super.initState();

    _trackStart = widget.width * 0.1;
    _trackEnd = widget.width * 0.9;
    _divisionExtent = (_trackEnd - _trackStart) / moods.length;

    _labelPaddingLeft = defaultPadding;
    //                                 👇 label container width
    _labelPaddingRight = widget.width - 144 - defaultPadding;

    //                                 default mood index 👇
    _dragPosition = Offset(_trackStart + _divisionExtent * 4, 0);
    // intial mood is previous mood of the day
    // and calm (none) for a new day
    _mood = moods[4];

    // animation
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _handlePanUpdate,
      onPanEnd: _handlePanEnd,
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
                  trackHeight: widget.trackHeight,
                  dragPosition: _dragging
                      ? _dragPosition
                      : Offset(_dragPosition.dx, _sliderAnimation.value),
                ),
              ),
            ),
            Positioned(
              top: -defaultPadding * 2,
              left: (_dragPosition.dx - 72)
                  .clamp(_labelPaddingLeft, _labelPaddingRight),
              child: Container(
                width: 144,
                alignment: Alignment.center,
                child: AnimatedLabel(
                  text: _mood,
                  duration: defaultTransitionDuration,
                  style: Theme.of(context).textTheme.labelMedium,
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
                  ..translate(-widget.thumbSize / 2, -widget.thumbSize / 2)
                  ..scale(_dragging ? 0.9 : 1.0),
                transformAlignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  border: Border.all(
                    color: Colors.black,
                    width: _dragging
                        ? widget.trackHeight * 1.4
                        : widget.trackHeight,
                  ),
                  borderRadius: BorderRadius.circular(widget.thumbSize * 0.45),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _clampDragPosition() {
    // Y Axis
    if (_dragPosition.dy >= widget.height) {
      _dragPosition = Offset(_dragPosition.dx, widget.height);
    } else if (_dragPosition.dy <= 0) {
      _dragPosition = Offset(_dragPosition.dx, 0);
    }
    // X Axis
    if (_dragPosition.dx >= _trackEnd) {
      _dragPosition = Offset(_trackEnd - 1, _dragPosition.dy);
    } else if (_dragPosition.dx <= _trackStart) {
      _dragPosition = Offset(_trackStart, _dragPosition.dy);
    }
  }

  void _handlePanUpdate(details) {
    setState(() {
      _dragging = true;
      _dragPosition = details.localPosition;
      _clampDragPosition();

      final int index = (_dragPosition.dx - _trackStart) ~/ _divisionExtent;
      if (_mood != moods[index]) {
        _mood = moods[index];
        widget.onChange?.call(_mood);
      }
    });
  }

  void _handlePanEnd(details) {
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
    });
    _animationController.forward();
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
  final double trackHeight;
  final Offset dragPosition;

  SliderPainter(
      {required this.color, this.trackHeight = 4, required this.dragPosition});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = trackHeight;

    Path path = Path();

    path.moveTo(0, size.height / 2);
    path.quadraticBezierTo(
        dragPosition.dx, dragPosition.dy, size.width, size.height / 2);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
