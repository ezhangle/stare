import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../data/style.dart';

class ActionsListView extends StatefulWidget {
  final List<String> items;
  final Function(int)? onChanged;

  const ActionsListView({
    Key? key,
    this.onChanged,
    required this.items,
  }) : super(key: key);

  @override
  State<ActionsListView> createState() => _ListPickerState();
}

class _ListPickerState extends State<ActionsListView> {
  late final PageController _pageController;
  double _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(
      viewportFraction: 0.65,
    )..addListener(
        () => setState(
          () => _currentIndex = _pageController.page ?? 0,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      clipBehavior: Clip.none,
      onPageChanged: (int index) => widget.onChanged?.call(index),
      controller: _pageController,
      itemCount: widget.items.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final double percentage = (index - _currentIndex).clamp(-1, 1);
        return Container(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..rotateZ(0.2 * percentage)
            ..scale(0.85 + (0.15 * (1 - percentage.abs()))),
          transformAlignment: Alignment.bottomCenter,
          child: _ActionCard(label: widget.items[index]),
        );
      },
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class _ActionCard extends StatelessWidget {
  final String label;
  final double width;

  const _ActionCard({
    Key? key,
    required this.label,
    this.width = 240,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: width * 1.25,
      transformAlignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(defaultPadding * 2),
      ),
      child: Stack(
        children: [
          Positioned(
            top: defaultPadding * 1.75,
            left: defaultPadding * 1.75,
            child: Text(
              label,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          Positioned(
            bottom: -defaultPadding,
            right: 0,
            child: SizedBox(
              height: 240,
              width: 240,
              child: SvgPicture.asset(
                "assets/images/illustration.svg",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
