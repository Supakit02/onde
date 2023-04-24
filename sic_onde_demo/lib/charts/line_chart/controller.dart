library widgets.chart.line_chart.controller;

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sic_onde_demo/charts/line_chart/painter/painter.dart';

import 'core/axis/axis_base.dart';
import 'core/data/chart_data.dart';
import 'core/description.dart';
import 'core/render/renderer.dart';
import 'core/transformer.dart';
import 'core/utils/utils.dart';
import 'core/view_port.dart';
import 'line_chart.dart';

typedef XAxisSettingFunction = void Function(XAxis xAxis);
typedef YAxisSettingFunction = void Function(YAxis yAxis);

class ChartController {
  ChartData? _data;
  ForegroundChartState? _state;
  ForegroundPainter? _painter;
  BackgroundPainter? _backPainter;

  // needed
  ViewPortHandler? viewPortHandler;
  XAxis? xAxis;

  // option
  double? extraTopOffset,
    extraRightOffset,
    extraBottomOffset,
    extraLeftOffset;

  // split child property
  Color? backgroundColor;
  double? minOffset;
  YAxis? yAxis;
  XAxisRenderer? xAxisRenderer;
  YAxisRenderer? yAxisRenderer;
  Transformer? yAxisTransformer;
  Paint? borderPaint;
  Description? description;

  Color? gridBackColor;
  Color? borderColor;
  double? borderStrokeWidth;

  XAxisSettingFunction? xAxisSettingFunction;
  YAxisSettingFunction? yAxisSettingFunction;

  ChartController({
    this.minOffset = 30.0,
    this.xAxis,
    this.yAxis,
    this.xAxisRenderer,
    this.yAxisRenderer,
    this.yAxisTransformer,
    this.xAxisSettingFunction,
    this.yAxisSettingFunction,
    this.borderPaint,
    this.gridBackColor,
    this.borderColor,
    this.borderStrokeWidth = 1.0,
    this.viewPortHandler,
    this.extraTopOffset = 0.0,
    this.extraRightOffset = 0.0,
    this.extraBottomOffset = 0.0,
    this.extraLeftOffset = 0.0,
    this.backgroundColor = Colors.white,
    this.description,
  }) {
    borderPaint = Paint()
      ..color = borderColor ?? Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = Utils.convertDpToPixel(
        borderStrokeWidth!);

    viewPortHandler ??= initViewPortHandler();
  }

  XAxis initXAxis() => XAxis();

  YAxis initYAxis() => YAxis();

  XAxisRenderer initXAxisRenderer() =>
      XAxisRenderer(
        viewPortHandler!,
        xAxis!,
        yAxisTransformer!);

  YAxisRenderer initYAxisRenderer() =>
      YAxisRenderer(
        viewPortHandler!,
        yAxis!,
        yAxisTransformer!);

  Transformer initYAxisTransformer() =>
      Transformer(viewPortHandler!);

  ViewPortHandler initViewPortHandler() =>
      ViewPortHandler();

  ForegroundPainter get painter => _painter!;

  BackgroundPainter get backPainter => _backPainter!;

  // ignore: unnecessary_getters_setters
  ChartData get data => _data!;

  // ignore: unnecessary_getters_setters
  set data(ChartData value) {
    _data = value;
  }

  // ignore: unnecessary_getters_setters
  ForegroundChartState get state => _state!;

  // ignore: unnecessary_getters_setters
  set state(ForegroundChartState value) {
    _state = value;
  }

  ForegroundChartState createState() {
    _state = ForegroundChartState();
    return _state!;
  }

  void doneBeforePainterInit() {
    xAxis ??= initXAxis();

    if ( xAxisSettingFunction != null ) {
      xAxisSettingFunction!(xAxis!);
    }

    yAxis ??= initYAxis();

    if ( yAxisSettingFunction != null ) {
      yAxisSettingFunction!(yAxis!);
    }

    yAxisTransformer ??= initYAxisTransformer();

    yAxisRenderer = initYAxisRenderer();
    xAxisRenderer = initXAxisRenderer();

    if ( description != null ) {
      description!
        ..pos = yAxis!.axisMinimum;
    }
  }

  void initialPainter() {
    _backPainter = BackgroundPainter(
      data,
      viewPortHandler!,
      extraTopOffset!,
      extraLeftOffset!,
      extraRightOffset!,
      extraBottomOffset!,
      borderPaint!,
      minOffset!,
      xAxis!,
      yAxis!,
      xAxisRenderer!,
      yAxisRenderer!,
      yAxisTransformer!,
      description!);
  }

  void setPainter() {
    _painter = ForegroundPainter(
      data,
      viewPortHandler!,
      xAxis!,
      yAxisTransformer!);
  }
}