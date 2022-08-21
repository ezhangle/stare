import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ListPicker extends StatefulWidget {
  final double width;
  final double? height;
  final double? itemExtent;
  final List<String> items;
  final int? defaultIndex;
  final Function(int)? onChanged;

  final TextStyle? selectedTextStyle;
  final TextStyle? defaultTextStyle;

  const ListPicker({
    Key? key,
    this.height,
    required this.width,
    required this.items,
    this.itemExtent,
    this.defaultIndex,
    this.onChanged,
    this.selectedTextStyle,
    this.defaultTextStyle,
  }) : super(key: key);

  @override
  State<ListPicker> createState() => _ListPickerState();
}

class _ListPickerState extends State<ListPicker> {
  late final double _itemExtent;
  late final ScrollController _scrollController;
  late final double _defaultExtent;

  late int _focusedElement;

  @override
  void initState() {
    super.initState();

    _itemExtent = widget.itemExtent ?? widget.width / 3;
    _focusedElement = widget.defaultIndex ?? 0;
    _scrollController = ScrollController(
      initialScrollOffset: (_itemExtent * 1.55 - (widget.width / 2)) +
          (_itemExtent * _focusedElement),
    );
    _defaultExtent = (_itemExtent * 1.5) - (widget.width / 2);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: NotificationListener(
        onNotification: _onNotification,
        child: ListView.builder(
          itemCount: widget.items.length,
          itemExtent: _itemExtent,
          physics: const ClampingScrollPhysics(),
          controller: _scrollController,
          padding: EdgeInsets.symmetric(horizontal: _itemExtent),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final bool focused = index == _focusedElement;
            return Align(
              alignment: Alignment.center,
              child: Text(
                widget.items[index],
                textAlign: TextAlign.center,
                style: focused
                    ? widget.selectedTextStyle ??
                        Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            )
                    : widget.defaultTextStyle ??
                        Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context).colorScheme.background,
                            ),
              ),
            );
          },
        ),
      ),
    );
  }

  bool _userStoppedScrolling(Notification notification) {
    return notification is UserScrollNotification &&
        notification.direction == ScrollDirection.idle &&
        _scrollController.position.activity is! HoldScrollActivity;
  }

  _animateTo(int index, {int durationMillis = 200}) {
    final double targetExtent = _defaultExtent + _itemExtent * index;

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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
