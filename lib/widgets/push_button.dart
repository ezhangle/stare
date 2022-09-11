import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stare/data/style.dart';

class PushButton extends StatefulWidget {
  final double size;
  final Function()? onTap;

  const PushButton({
    Key? key,
    this.onTap,
    this.size = 56,
  }) : super(key: key);

  @override
  State<PushButton> createState() => _PushButtonState();
}

class _PushButtonState extends State<PushButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: widget.size,
          height: widget.size,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xffa8a8a8), Color(0xfff2f2f2)],
            ),
          ),
        ),
        Container(
          width: widget.size - 8,
          height: widget.size - 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xff4a4a4a),
              width: _pressed ? 2 : 1,
            ),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xfff2f2f2), Color(0xff8f8f8f)],
            ),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 50),
          width: widget.size - 16,
          height: widget.size - 16,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Color(0xffe8e8e8)],
            ),
          ),
          transformAlignment: Alignment.center,
          transform: Matrix4.identity()
            ..scale(_pressed ? 0.9 : 1.0, _pressed ? 0.9 : 1.0),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            "assets/icons/off.svg",
            height: widget.size - 32,
            width: widget.size - 32,
          ),
        ),
        GestureDetector(
          onTapDown: (details) {
            setState(() => _pressed = true);
            widget.onTap?.call();
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.decelerate,
            height: widget.size - 10,
            width: widget.size - 10,
            onEnd: () {
              _pressed == true ? setState(() => _pressed = false) : null;
            },
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: const Alignment(0, 0.5),
                colors: [
                  _pressed ? Colors.black.withOpacity(0.2) : Colors.transparent,
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
