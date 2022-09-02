import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../data/style.dart';

const _animationDuration = Duration(milliseconds: 600);

class ActionsListView extends StatefulWidget {
  final double width;
  final double? height;
  final double? itemExtent;
  final List<String> items;
  final int? defaultIndex;
  final double swipeThreshold;
  final Function(int)? onChanged;

  final TextStyle? selectedTextStyle;
  final TextStyle? defaultTextStyle;

  const ActionsListView({
    Key? key,
    this.height,
    required this.width,
    required this.items,
    this.itemExtent,
    this.defaultIndex,
    this.onChanged,
    this.selectedTextStyle,
    this.defaultTextStyle,
    this.swipeThreshold = 100,
  }) : super(key: key);

  @override
  State<ActionsListView> createState() => _ListPickerState();
}

class _ListPickerState extends State<ActionsListView> {
  final double _itemExtent = 272;

  late final double _defaultExtent;
  late final ScrollController _scrollController;

  late int _focusedElement;
  double _startDx = 0;
  double _endDx = 0;

  @override
  void initState() {
    super.initState();

    _focusedElement = widget.defaultIndex ?? 0;
    _scrollController = ScrollController(
      initialScrollOffset: (_itemExtent * 1.55 - (widget.width / 2)) +
          (_itemExtent * _focusedElement),
    );
    _defaultExtent = (_itemExtent * 1.5) - (widget.width / 2);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => _focusedElement == widget.items.length - 1
            ? _focusedElement = 0
            : _focusedElement = _focusedElement + 1);

        _animateTo(_focusedElement);
      },
      onHorizontalDragStart: (details) => _startDx = details.localPosition.dx,
      onHorizontalDragUpdate: (details) => _endDx = details.localPosition.dx,
      onHorizontalDragEnd: (details) {
        final double distance = _startDx - _endDx;

        if (distance.abs() >= widget.swipeThreshold) {
          if (distance < 0 && _focusedElement != 0) {
            // swiped in right direction
            setState(() => _focusedElement -= 1);
          } else if (_focusedElement != widget.items.length - 1) {
            //&& distance > 0
            // swiped in left direction
            setState(() => _focusedElement += 1);
          }
          _animateTo(_focusedElement);
        }
      },
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: ListView.builder(
            clipBehavior: Clip.none,
            itemExtent: _itemExtent,
            controller: _scrollController,
            itemCount: widget.items.length,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: _itemExtent),
            itemBuilder: (_, index) {
              return _ActionCard(
                label: widget.items[index],
                index: index,
                focusedElement: _focusedElement,
              );
            }),
      ),
    );
  }

  _animateTo(int index) {
    final double targetExtent = _defaultExtent + _itemExtent * index;

    _scrollController.animateTo(
      targetExtent,
      duration: _animationDuration,
      curve: Curves.easeOutBack,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class _ActionCard extends StatelessWidget {
  final int index;
  final int focusedElement;
  final String label;
  final double width;

  const _ActionCard({
    Key? key,
    required this.label,
    required this.index,
    required this.focusedElement,
    this.width = 240,
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
      duration: _animationDuration,
      curve: Curves.easeOutBack,
      width: width,
      height: width * 1.25,
      margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
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
              label,
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
        ],
      ),
    );
  }
}
