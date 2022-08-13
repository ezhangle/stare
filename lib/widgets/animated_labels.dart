import 'package:flutter/material.dart';
import 'package:stare/data/style.dart';

class FadedLabel extends StatefulWidget {
  final String defaultValue;
  final TextStyle? textStyle;

  const FadedLabel({
    Key? key,
    this.textStyle,
    required this.defaultValue,
  }) : super(key: key);

  @override
  State<FadedLabel> createState() => FadedLabelState();
}

class FadedLabelState extends State<FadedLabel> {
  String firstText = "";
  double firstY = -1.25;
  late String secondText;
  double secondY = 0;

  @override
  void initState() {
    secondText = widget.defaultValue;
    super.initState();
  }

  void change(String label) {
    setState(() {
      if (firstY == 0) {
        secondText = label;
        secondY = 0;
        firstY = 1.4;
      } else {
        firstText = label;
        firstY = 0;
        secondY = 1.4;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedSlide(
          curve: Curves.easeOutCubic,
          duration: const Duration(milliseconds: 400),
          offset: Offset(0, firstY),
          onEnd: () {
            if (firstY == 1.4) {
              setState(() {
                firstY = -1.4;
              });
            }
          },
          child: AnimatedOpacity(
              curve: Curves.easeOutCubic,
              duration: const Duration(milliseconds: 400),
              opacity: firstY == 0 ? 1 : 0,
              child: Text(firstText, style: widget.textStyle)),
        ),
        AnimatedSlide(
          curve: Curves.easeOutCubic,
          duration: const Duration(milliseconds: 400),
          offset: Offset(0, secondY),
          onEnd: () {
            if (secondY == 1.4) {
              setState(() {
                secondY = -1.4;
              });
            }
          },
          child: AnimatedOpacity(
            curve: Curves.easeOutCubic,
            duration: const Duration(milliseconds: 400),
            opacity: secondY == 0 ? 1 : 0,
            child: Text(secondText, style: widget.textStyle),
          ),
        ),
      ],
    );
  }
}
