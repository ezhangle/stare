import 'dart:math';

import 'package:flutter/material.dart';

class ScrollNotifier extends ChangeNotifier {
  double _offset = 0;
  double? _page;

  ScrollNotifier(PageController pageControl) {
    pageControl.addListener(() {
      _offset = pageControl.offset;
      _page = pageControl.page;
      notifyListeners();
    });
  }

  double get offset => _offset;
  double? get page => _page;

  double animValue(double curPage) {
    final double x = page ?? curPage;
    double anim = 1;

    if (x >= curPage) {
      anim = 1 - (x - curPage);
    } else {
      anim = 1 - (curPage - x);
    }

    return max(0, anim);
  }
}
