import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ListPicker extends StatefulWidget {
  final double width;
  final List<String> items;
  final int? defaultIndex;
  final Function(int)? onChanged;

  const ListPicker({
    Key? key,
    required this.items,
    required this.width,
    this.defaultIndex,
    this.onChanged,
  }) : super(key: key);

  @override
  State<ListPicker> createState() => _ListPickerState();
}

class _ListPickerState extends State<ListPicker> {
  late final double _itemExtent;
  late final ScrollController _scrollController;

  late int _focusedElement;

  @override
  void initState() {
    super.initState();
    _itemExtent = widget.width / 3;
    _focusedElement = widget.defaultIndex ?? 0;
    _scrollController = ScrollController(
      initialScrollOffset: _itemExtent * _focusedElement,
    );
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: _onNotification,
      child: ListView.builder(
        itemCount: widget.items.length,
        itemExtent: widget.width / 3,
        physics: const BouncingScrollPhysics(),
        controller: _scrollController,
        padding: EdgeInsets.symmetric(horizontal: widget.width / 3),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final bool focused = index == _focusedElement;
          return Text(
            widget.items[index].toUpperCase(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: focused
                      ? Theme.of(context).colorScheme.onBackground
                      : Theme.of(context).colorScheme.tertiary,
                ),
          );
        },
      ),
    );
  }

  bool _userStoppedScrolling(Notification notification) {
    return notification is UserScrollNotification &&
        notification.direction == ScrollDirection.idle &&
        _scrollController.position.activity is! HoldScrollActivity;
  }

  _animateTo(int index, {int durationMillis = 200}) {
    final double targetExtent = index * _itemExtent;
    _scrollController.animateTo(
      targetExtent,
      duration: Duration(milliseconds: durationMillis),
      curve: Curves.decelerate,
    );
  }

  int _offsetToMiddleIndex(double offset) =>
      (offset + widget.width / 2) ~/ _itemExtent;

  bool _onNotification(Notification notification) {
    if (notification is ScrollNotification) {
      final middleIndex = _offsetToMiddleIndex(notification.metrics.pixels) - 1;

      if (_userStoppedScrolling(notification)) {
        _animateTo(middleIndex);
      }

      if (middleIndex != _focusedElement) {
        setState(() {
          _focusedElement = middleIndex;
        });
        widget.onChanged?.call(_focusedElement);
      }
    }
    return true;
  }
}
