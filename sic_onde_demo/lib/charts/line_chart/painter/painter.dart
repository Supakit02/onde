library widgets.chart.line_chart.painter;

import 'dart:math' as math;
import 'package:flutter/widgets.dart';
import 'package:sic_onde_demo/charts/line_chart/core/axis/axis_base.dart';
import 'package:sic_onde_demo/charts/line_chart/core/data/chart_data.dart';
import 'package:sic_onde_demo/charts/line_chart/core/description.dart';
import 'package:sic_onde_demo/charts/line_chart/core/poolable/poolable.dart';
import 'package:sic_onde_demo/charts/line_chart/core/render/renderer.dart';
import 'package:sic_onde_demo/charts/line_chart/core/transformer.dart';
import 'package:sic_onde_demo/charts/line_chart/core/utils/utils.dart';
import 'package:sic_onde_demo/charts/line_chart/core/view_port.dart';

part 'foreground_painter.dart';
part 'background_painter.dart';

abstract class ChartPainter extends CustomPainter {
  /// object that holds all data that was originally
  /// set for the chart, before it was modified or
  /// any filtering algorithms had been applied.
  final ChartData _data;

  /// object that manages the bounds and drawing
  /// constraints of the chart.
  final ViewPortHandler _viewPortHandler;

  /// the object representing the labels on
  /// the x-axis.
  final XAxis _xAxis;

  XAxis get xAxis => _xAxis;

  ViewPortHandler get viewPortHandler => _viewPortHandler;

  ChartPainter(
    ChartData data,
    ViewPortHandler viewPortHandler,
    XAxis xAxis,
  ) : _data = data,
      _viewPortHandler = viewPortHandler,
      _xAxis = xAxis,
      super() {
    if ( (data == null) ||
        (data.dataSets == null) ||
        (data.dataSets.isEmpty) ) {
      return;
    }

    initDefaultWithData();
  }

  void initDefaultWithData();

  @override
  void paint(Canvas canvas, Size size) {
    onPaint(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  void onPaint(Canvas canvas, Size size);

  ChartData getData() => _data;
}