import "package:flutter/material.dart";
import 'package:stare/data/style.dart';
import "package:vector_math/vector_math.dart" show radians;

class JournalView extends StatefulWidget {
  final double? initalPage;
  final List<Widget> children; // TODO maybe use builder
  final Widget coverBackSide;
  final Widget pageBackSide;
  final double? viewportFraction;
  // final Function(int)? onPageChanged;

  const JournalView({
    super.key,
    this.initalPage,
    // this.onPageChanged,
    this.viewportFraction,
    required this.children,
    required this.coverBackSide,
    required this.pageBackSide,
  });

  @override
  State<JournalView> createState() => JournalViewState();
}

class JournalViewState extends State<JournalView> {
  late final PageController _pageController;

  // last page's index should be flipped
  late final int _lastTurnablePage;

  // recent page's index that has been rotated more than 90°
  late int _latestFlippedPage;

  // page indexes that have been flipped/rotated more than 90°,
  // that needs to placed below _unflippedPages in the Stack
  late Iterable<int> _flippedPages;

  // page indexes that aren't flipped and should be placed
  // on top of the _flippedPages
  late Iterable<int> _unflippedPages;

  // _pageControllers.page
  late double _currentPage;

  @override
  void initState() {
    super.initState();

    _currentPage = widget.initalPage ?? 0;
    _lastTurnablePage = widget.children.length - 2;

    _initPages(_currentPage == 0 ? 0 : _currentPage.toInt() - 1);

    _pageController = PageController(
      initialPage: _currentPage.toInt(),
      viewportFraction: widget.viewportFraction ?? 1.0,
    )..addListener(
        () => setState(
          () => _currentPage = _pageController.page ?? 0,
        ),
      );
  }

  void _initPages(int latestFlippedPage) {
    setState(() {
      _latestFlippedPage = latestFlippedPage;
      _flippedPages = _latestFlippedPage < 3
          ? _latestFlippedPage < 1
              ? const []
              : List.generate(_latestFlippedPage, (index) => index + 1)
          : [_latestFlippedPage - 1, _latestFlippedPage];

      _unflippedPages = _latestFlippedPage == _lastTurnablePage
          ? [_latestFlippedPage + 1]
          // reversed because last item is on top of stack
          : [_latestFlippedPage + 2, _latestFlippedPage + 1];
    });
  }

  void animateTo(int pageIndex) {
    _pageController.animateToPage(
      pageIndex,
      duration: defaultTransitionDuration,
      curve: Curves.decelerate,
    );
  }

  @override
  Widget build(BuildContext context) {
    // last item's index that is rotated over 90°
    final int latestFlippedPage = (_currentPage - 0.5).floor();

    // initalize the pages as if latestFlippedPage is changed
    if (latestFlippedPage != _latestFlippedPage) _initPages(latestFlippedPage);

    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        widget.coverBackSide,

        // Flipped Cover
        if (_currentPage > 0.5)
          _RotatedChild(
            angleY: 180.0 * _currentPage.clamp(0, 0.8),
            child: widget.coverBackSide,
          ),

        // Flipped Pages
        for (final int index in _flippedPages)
          _RotatedChild(
            angleY: 180.0 * (_currentPage - index).clamp(0, 0.8),
            child: widget.pageBackSide,
          ),

        // Unflipped Pages
        for (final int index in _unflippedPages)
          _RotatedChild(
            angleY: 180.0 * (_currentPage - index).clamp(0, 1.0),
            child: widget.children[index],
          ),

        // Gesture Handler
        PageView.builder(
          controller: _pageController,
          physics: const BouncingScrollPhysics(),
          itemCount: widget.children.length,
          // onPageChanged: widget.onPageChanged,
          itemBuilder: (context, index) => const SizedBox(),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class _RotatedChild extends StatelessWidget {
  final double angleY;
  final Widget child;

  const _RotatedChild({
    required this.angleY,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY(radians(angleY)),
      alignment: Alignment.centerLeft,
      child: child,
    );
  }
}
