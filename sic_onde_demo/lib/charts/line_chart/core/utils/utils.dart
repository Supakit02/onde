library widgets.chart.line_chart.core.utils;

import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:sic_onde_demo/charts/line_chart/core/poolable/poolable.dart';
import 'package:vector_math/vector_math_64.dart'
  show
    Vector3,
    Matrix4;

part 'painter_utils.dart';
part 'screen_utils.dart';
part 'matrix4_utils.dart';

class Utils {
  static FSize getSizeOfRotatedRectangle(
      double rectangleWidth, double rectangleHeight) {
    return FSize.getInstance((rectangleWidth).abs(), (rectangleHeight).abs());
  }

  static double nextUp(double d) {
    if (d == double.infinity) {
      return d;
    } else {
      var _res = 0.0;

      try {
        var _len = d.toString().split('.')[1].length;
        var _value = '0.';

        for (var i = 0; i < _len; i++) {
          _value += '0';
        }

        _value += '1';

        if (d >= 0) {
          _res = double.parse(_value);
        } else {
          _res = -double.parse(_value);
        }

        return d + _res;
      } catch (e) {
        return d;
      }
    }
  }

  static double convertDpToPixel(double dp) {
    return ScreenUtils.getInstance().getSp(dp);
  }

  static int calcTextWidth(TextPainter p, String demoText) {
    var _painter = PainterUtils.create(
        p, demoText, p.text!.style!.color!, p.text!.style!.fontSize!);

    _painter.layout();
    return _painter.width.toInt();
  }

  static int calcTextHeight(TextPainter p, String demoText) {
    var _painter = PainterUtils.create(
        p, demoText, p.text!.style!.color!, p.text!.style!.fontSize!);

    _painter.layout();
    return _painter.height.toInt();
  }

  static FSize calcTextSize1(TextPainter p, String demoText) {
    var _result = FSize.getInstance(0, 0);

    calcTextSize2(p, demoText, _result);

    return _result;
  }

  static void calcTextSize2(TextPainter p, String demoText, FSize outputFSize) {
    var _painter = PainterUtils.create(
        p, demoText, p.text!.style!.color!, p.text!.style!.fontSize!);

    _painter.layout();

    outputFSize.width = _painter.width;
    outputFSize.height = _painter.height;
  }

  static double roundToNextSignificant(double number) {
    if ((number.isInfinite) || (number.isNaN) || (number == 0.0)) {
      return 0.0;
    }

    final _d = (math.log((number < 0) ? -number : number) / math.ln10).ceil();
    final _pw = 1 - _d;

    final double _magnitude = math.pow(10.0, _pw).toDouble();
    final _shifted = (number * _magnitude).round();

    return _shifted / _magnitude;
  }
}
