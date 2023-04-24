library widgets.chart.line_chart.core.description;

import 'dart:core';

import 'component.dart';

class Description extends ComponentBase {
  /// pos (the y-value or xIndex)
  double _pos = 0.0;

  /// the text used in the description
  String _text = '';

  Description(this._text) : super();

  double get pos => _pos;

  set pos(double value) {
    _pos = value ;
  }

  String get text => _text;

  set text(String value) {
    _text = value ;
  }
}