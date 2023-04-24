library widgets.chart.line_chart.core.view_port;

import 'package:flutter/rendering.dart';

class ViewPortHandler {
  /// this rectangle defines the area in which graph values can be drawn.
  Rect _contentRect = Rect.zero;

  double _chartWidth = 0.0;
  double _chartHeight = 0.0;

  /// Constructor - don't forget calling setChartDimens(...)
  ViewPortHandler();

  /// Sets the width and height of the chart.
  ///
  ///     [@param] width
  ///     [@param] height
  ///
  void setChartDimens(double width, double height) {
    _chartHeight = height;
    _chartWidth = width;
  }

  void restrainViewPort(
      double offsetLeft,
      double offsetTop,
      double offsetRight,
      double offsetBottom) {
    _contentRect = Rect.fromLTRB(
      offsetLeft,
      offsetTop,
      _chartWidth - offsetRight,
      _chartHeight - offsetBottom);
  }

  double offsetLeft() => _contentRect.left;
  double offsetBottom()  => (_chartHeight - _contentRect.bottom);

  double contentTop() => _contentRect.top;
  double contentLeft() => _contentRect.left;
  double contentRight() => _contentRect.right;
  double contentBottom() => _contentRect.bottom;

  double contentWidth() => _contentRect.width;
  double contentHeight() => _contentRect.height;

  Rect get contentRect => _contentRect;

  double get chartHeight => _chartHeight;

  bool isInBoundsX(double x) => (isInBoundsLeft(x) && isInBoundsRight(x));

  bool isInBoundsLeft(double x) {
    if ( x == null ) { return false; }
    return _contentRect.left <= (x + 1);
  }

  bool isInBoundsRight(double x) {
    if ( x == null ) { return false; }
    x = (((x * 100.0).round()) / 100.0);
    return _contentRect.right >= (x - 1);
  }
}