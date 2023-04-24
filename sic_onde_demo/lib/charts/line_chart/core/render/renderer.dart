library widgets.chart.line_chart.core.render;

import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart'
  show Canvas, Paint, PaintingStyle, Path, Rect, TextPainter, TextSpan;

import 'package:sic_onde_demo/charts/line_chart/core/axis/axis_base.dart';
import 'package:sic_onde_demo/charts/line_chart/core/bounds.dart';
import 'package:sic_onde_demo/charts/line_chart/core/data/chart_data.dart';
import 'package:sic_onde_demo/charts/line_chart/core/poolable/poolable.dart';
import 'package:sic_onde_demo/charts/line_chart/core/transformer.dart';
import 'package:sic_onde_demo/charts/line_chart/core/utils/utils.dart';
import 'package:sic_onde_demo/charts/line_chart/core/view_port.dart';

part 'axis_renderer.dart';
part 'line_chart_renderer.dart';
part 'x_axis_renderer.dart';
part 'y_axis_renderer.dart';


abstract class Renderer {
  /// the component that handles the drawing area of
  /// the chart and it's offsets.
  ViewPortHandler _viewPortHandler;

  Renderer(this._viewPortHandler);

  // ignore: unnecessary_getters_setters
  ViewPortHandler get viewPortHandler => _viewPortHandler;

  // ignore: unnecessary_getters_setters
  set viewPortHandler(ViewPortHandler value) {
    _viewPortHandler = value;
  }
}