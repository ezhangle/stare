import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PushButton extends StatefulWidget {
  final double size;

  const PushButton({
    Key? key,
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
              colors: [Color(0xffa8a8a8), Color(0xffd8d8d8)],
            ),
          ),
        ),
        Container(
          width: widget.size - 10,
          height: widget.size - 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xff4a4a4a),
              width: _pressed ? 2 : 1,
            ),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xfff2f2f2), Color(0xffa2a2a2)],
            ),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          width: widget.size - 20,
          height: widget.size - 20,
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
            height: widget.size - 35,
            width: widget.size - 35,
          ),
        ),
        GestureDetector(
          onTapDown: (details) => setState(() => _pressed = true),
          onTapUp: (details) => setState(() => _pressed = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: widget.size - 10,
            width: widget.size - 10,
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
