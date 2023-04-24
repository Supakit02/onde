library widgets.chart.line_chart.core.component;

import 'package:flutter/material.dart';
import 'package:sic_onde_demo/charts/line_chart/core/utils/utils.dart';

abstract class ComponentBase {
  /// the offset in pixels this component has on the x-axis
  double _xOffset = 5.0;

  /// the offset in pixels this component has on the Y-axis
  double _yOffset = 5.0;

  /// the typeface used for the labels
  TypeFace _typeface = TypeFace();

  /// the text size of the labels
  double _textSize = Utils.convertDpToPixel(10.0);

  /// the text color to use for the labels
  Color _textColor = Colors.black;

  double get xOffset => _xOffset;

  set xOffset(double value) {
    _xOffset = Utils.convertDpToPixel(value);
  }

  double get yOffset => _yOffset;

  set yOffset(double value) {
    _yOffset = Utils.convertDpToPixel(value);
  }

  TypeFace get typeface => _typeface;

  set typeface(TypeFace value) {
    _typeface = value;
  }

  double get textSize => _textSize;

  set textSize(double value) {
    value;

    if (value > 24) {
      value = 24.0;
    }
    if (value < 6) {
      value = 6.0;
    }
    _textSize = value;
  }

  Color get textColor => _textColor;

  set textColor(Color value) {
    _textColor = value;
  }
}

class TypeFace {
  String _fontFamily = "";
  FontWeight _fontWeight;

  TypeFace({
    String fontFamily = "",
    FontWeight fontWeight = FontWeight.normal,
  })  : _fontFamily = fontFamily,
        _fontWeight = fontWeight;

  // ignore: unnecessary_getters_setters
  FontWeight get fontWeight => _fontWeight;

  // ignore: unnecessary_getters_setters
  set fontWeight(FontWeight value) {
    _fontWeight = value;
  }

  // ignore: unnecessary_getters_setters
  String get fontFamily => _fontFamily;

  // ignore: unnecessary_getters_setters
  set fontFamily(String value) {
    _fontFamily = value;
  }
}
