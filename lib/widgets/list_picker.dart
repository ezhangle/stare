import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ListPicker extends StatefulWidget {
  final double width;
  final double? height;
  final double? itemExtent;
  final int itemCount;
  final Widget Function(int index, int focusedElementIndex) itemBuilder;
  final int? defaultIndex;
  final Function(int)? onChanged;

  const ListPicker({
    Key? key,
    this.height,
    required this.width,
    required this.itemCount,
    required this.itemBuilder,
    this.itemExtent,
    this.defaultIndex,
    this.onChanged,
  }) : super(key: key);

  @override
  State<ListPicker> createState() => _ListPickerState();
}

class _ListPickerState extends State<ListPicker> {
  late final double _itemExtent;
  late final ScrollController _scrollController;
  late final double _defaultExtent;

  late int _focusedElementIndex;

  @override
  void initState() {
    super.initState();

    _itemExtent = widget.itemExtent ?? widget.width / 3;
    _focusedElementIndex = widget.defaultIndex ?? 0;
    _scrollController = ScrollController(
      initialScrollOffset: (_itemExtent * 1.55 - (widget.width / 2)) +
          (_itemExtent * _focusedElementIndex),
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
          itemExtent: _itemExtent,
          itemCount: widget.itemCount,
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          physics: const ClampingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: _itemExtent),
          itemBuilder: (context, index) =>
              widget.itemBuilder(index, _focusedElementIndex),
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

      if (middleIndex != _focusedElementIndex) {
        setState(() {
          _focusedElementIndex = middleIndex;
        });
        widget.onChanged?.call(_focusedElementIndex);
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
