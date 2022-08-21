import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../data/style.dart';

class ActionsListView extends StatefulWidget {
  final double width;
  // final List<String> items;
  final Function(int)? onChanged;

  const ActionsListView({
    Key? key,
    required this.width,
    this.onChanged,
    // required this.items,
  }) : super(key: key);

  @override
  State<ActionsListView> createState() => _ActionsListViewState();
}

class _ActionsListViewState extends State<ActionsListView> {
  int focusedElement = 1;
  final double itemExtent = 278;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(
      initialScrollOffset: itemExtent * 1.55 - (widget.width / 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: _onNotification,
      child: ListView.builder(
        itemCount: 4,
        itemExtent: itemExtent,
        clipBehavior: Clip.none,
        controller: _scrollController,
        // itemCount: widget.items.length,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: itemExtent),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: GestureDetector(
              onTap: () {
                _scrollController.animateTo(
                  itemExtent * 0.8 + index * itemExtent,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOutBack,
                );
              },
              child: ActionCard(
                index: index + 1,
                focusedElement: focusedElement,
              ),
            ),
          );
        },
      ),
    );
  }

  int _offsetToMiddleIndex(double offset) =>
      (offset + widget.width / 2) ~/ itemExtent;

  bool _onNotification(Notification notification) {
    if (notification is ScrollNotification) {
      final middleIndex = _offsetToMiddleIndex(notification.metrics.pixels);

      if (middleIndex != focusedElement) {
        setState(() {
          focusedElement = middleIndex;
        });
        widget.onChanged?.call(focusedElement);
      }
    }

    return true;
  }
}

class ActionCard extends StatelessWidget {
  final int index;
  final int focusedElement;

  const ActionCard({
    Key? key,
    required this.index,
    required this.focusedElement,
  }) : super(key: key);

  double _rotation() {
    if (index < focusedElement) {
      return -0.20;
    } else if (index == focusedElement) {
      return 0;
    } else {
      return 0.20;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutBack,
      width: 246,
      height: 304,
      transform: Matrix4.identity()
        ..rotateZ(_rotation())
        ..translate(0.0, index == focusedElement ? 0.0 : 32.0),
      transformAlignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(defaultPadding * 2),
      ),
      child: Stack(
        children: [
          Positioned(
            top: defaultPadding * 2,
            left: defaultPadding * 2,
            child: Text(
              "Eye",
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          Positioned(
            bottom: 0,
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
          // Positioned(
          //   bottom: 0,
          //   left: 121,
          //   child: Container(
          //     height: 294,
          //     width: 4,
          //     color: Colors.black,
          //   ),
          // ),
        ],
      ),
    );
  }
}
