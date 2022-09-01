import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AnimatedLabel extends ImplicitlyAnimatedWidget {
  const AnimatedLabel({
    Key? key,
    required this.text,
    this.textStyle,
    this.offsetY = 32,
    Curve curve = Curves.linear,
    required Duration duration,
    VoidCallback? onEnd,
  }) : super(
          key: key,
          curve: curve,
          duration: duration,
          onEnd: onEnd,
        );

  final String text;
  final double offsetY;
  final TextStyle? textStyle;

  @override
  ImplicitlyAnimatedWidgetState<AnimatedLabel> createState() =>
      _AnimatedTestWidgetState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('text', text));
  }
}

class _AnimatedTestWidgetState
    extends ImplicitlyAnimatedWidgetState<AnimatedLabel> {
  late final Alignment _stackAlignment;

  String _firstText = "";
  String _secondText = "";

  double _animationEnd = 0;

  // animation
  Tween<double>? _tween;
  late Animation<double> _tweenAnimation;

  @override
  void initState() {
    super.initState();
    _firstText = _secondText = widget.text;
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    if (_animationEnd == 0) {
      // _secondText in center
      if (_secondText != widget.text) {
        _firstText = widget.text;
        _animationEnd = 1;
      }
    } else if (_animationEnd == 1) {
      // _firstText in center
      if (_firstText != widget.text) {
        _secondText = widget.text;
        _animationEnd = 0;
      }
    }

    _tween = visitor(_tween, _animationEnd,
            (dynamic value) => Tween<double>(begin: value as double))
        as Tween<double>?;
  }

  @override
  void didUpdateTweens() {
    _tweenAnimation = animation.drive(_tween!);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _tweenAnimation,
      builder: (_, __) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Transform.translate(
              offset: Offset(
                0,
                _animationEnd == 1
                    ? -widget.offsetY * (1 - _tweenAnimation.value)
                    : widget.offsetY * (1 - _tweenAnimation.value),
              ),
              child: Opacity(
                opacity: _tweenAnimation.value,
                child: Text(
                  textAlign: TextAlign.center,
                  _firstText,
                  style: widget.textStyle ??
                      Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(
                0,
                _animationEnd == 1
                    ? widget.offsetY * _tweenAnimation.value
                    : -widget.offsetY * _tweenAnimation.value,
              ),
              child: Opacity(
                opacity: 1 - _tweenAnimation.value,
                child: Text(
                  _secondText,
                  textAlign: TextAlign.center,
                  style: widget.textStyle ??
                      Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
