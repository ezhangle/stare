import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stare/data/style.dart';

import '../providers/scroll_notifier.dart';

class ExerciseCard extends StatelessWidget {
  final int index;
  final String imageName;
  final String labelText;
  final Function? onTap;

  const ExerciseCard({
    Key? key,
    this.onTap,
    required this.index,
    required this.imageName,
    required this.labelText,
  }) : super(key: key);

  double getAnim(double curPage, double scrolledPage) {
    if (scrolledPage >= curPage) {
      return (1 - (scrolledPage - curPage));
    } else {
      return (1 - (curPage - scrolledPage));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ScrollNotifier>(
      builder: (context, value, child) {
        final double anim =
            getAnim(index.toDouble(), value.page ?? index.toDouble())
                .clamp(0, 1);
        final double imageHeight = 320 + (64 * anim);

        return Container(
          margin: const EdgeInsets.only(right: 16.0),
          height: 384,
          width: 320,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(32.0)),
          ),
          child: Stack(
            // clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(32.0),
                ),
                child: Transform.scale(
                  scale: 1 + (anim * 0.25),
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    "assets/images/actions/$imageName-bg.jpg",
                    width: 320,
                    height: 320,
                    fit: BoxFit.cover,
                    alignment: Alignment.bottomCenter,
                  ),
                ),
              ),
              Image.asset(
                "assets/images/actions/$imageName-fg.png",
                width: 320,
                height: imageHeight,
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter,
              ),
              child!,
            ],
          ),
        );
      },
      child: GestureDetector(
        onTap: () => onTap?.call(),
        child: Container(
          width: 320,
          height: 320,
          padding: const EdgeInsets.all(28.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(32.0),
            ),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: const <double>[0, 0.5],
              colors: <Color>[
                Colors.white.withOpacity(.6),
                Colors.white.withOpacity(0)
              ],
            ),
          ),
          alignment: Alignment.bottomLeft,
          child: Text(
            labelText,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      ),
    );
  }
}

class EyeExerciseCard extends StatelessWidget {
  const EyeExerciseCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ScrollNotifier>(
      builder: (context, value, child) {
        final double anim = 1 - (value.page ?? 0).clamp(0, 1);
        final double imageHeight = 320 + (64 * anim);

        return Container(
          margin: const EdgeInsets.only(right: 16.0),
          height: 384,
          width: 320,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(32.0)),
          ),
          child: Stack(
            // clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(32.0),
                ),
                child: Transform.scale(
                  scale: 1 + (anim * 0.25),
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    "assets/images/actions/eye-bg.jpg",
                    width: 320,
                    height: 320,
                    fit: BoxFit.cover,
                    alignment: Alignment.bottomCenter,
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(12 * (1 - anim), 0),
                child: Image.asset(
                  "assets/images/actions/eye-ball.png",
                  width: 320,
                  height: imageHeight,
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomCenter,
                ),
              ),
              Image.asset(
                "assets/images/actions/eye-socket.png",
                width: 320,
                height: imageHeight,
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter,
              ),
              child!,
            ],
          ),
        );
      },
      child: Container(
        width: 320,
        height: 320,
        padding: const EdgeInsets.all(28.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(32.0),
          ),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: const <double>[0, 0.5],
            colors: <Color>[Colors.white, Colors.white.withOpacity(0)],
          ),
        ),
        alignment: Alignment.bottomLeft,
        child: Text(
          "Eye",
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
    );
  }
}
