library widgets.chart.line_chart.core.axis;

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:sic_onde_demo/charts/line_chart/core/utils/utils.dart';
import 'package:sic_onde_demo/charts/line_chart/core/vavlue_formatter/value_formatter.dart';

import '../component.dart';

part 'x_axis.dart';
part 'y_axis.dart';

abstract class AxisBase extends ComponentBase {
  /// custom formatter that is used instead of the auto-formatter if set.
  ValueFormatter? _axisValueFormatter;

  List<double> _entries = <double>[];

  /// the number of entries the legend contains.
  int _entryCount = 0;

  /// the number of decimal digits to use.
  int _decimals = 0;

  /// the number of label entries the axis should have, default is 6.
  int _labelCount = 6;

  /// if true, the set number of y-labels will be forced.
  bool _forceLabels = false;

  /// flag indicating that the axis-min value has been customized.
  bool _customAxisMin = false;

  /// flag indicating that the axis-max value has been customized.
  bool _customAxisMax = false;

  /// don't touch this direclty, use setter.
  double _axisMaximum = 0.0;

  /// don't touch this directly, use setter.
  double _axisMinimum = 0.0;

  /// the total range of values this axis covers.
  double _axisRange = 0.0;

  AxisBase() {
    textSize = 10.0;
    xOffset = 5.0;
    yOffset = 5.0;
  }

  bool get forceLabels => _forceLabels;

  int get labelCount => _labelCount;

  bool get customAxisMax => _customAxisMax;

  bool get customAxisMin => _customAxisMin;

  // ignore: avoid_setters_without_getters
  set decimals(int value) {
    _decimals = value;
  }

  // ignore: unnecessary_getters_setters
  List<double> get entries => _entries;

  // ignore: unnecessary_getters_setters
  set entries(List<double> value) {
    _entries = value;
  }

  // ignore: unnecessary_getters_setters
  int get entryCount => _entryCount;

  // ignore: unnecessary_getters_setters
  set entryCount(int value) {
    _entryCount = value;
  }

  double get axisRange => _axisRange;

  @protected
  set axisRange(double value) {
    _axisRange = value ;
  }

  double get axisMinimum => _axisMinimum;

  @protected
  set axisMinimum(double value) {
    _axisMinimum = value;
  }

  /// Set a custom minimum value for this axis. If set, this value will not be
  /// calculated automatically depending on the provided data. Otherwise,
  /// the `axis-minimum` value will still be forced to 0.
  ///
  ///     [@param] min value
  ///
  void setAxisMinimum(double min) {
    min ;

    _customAxisMin = true;
    _axisMinimum = min;
    _axisRange = (_axisMaximum - min).abs();
  }

  double get axisMaximum => _axisMaximum;

  @protected
  set axisMaximum(double value) {
    _axisMaximum = value ;
  }

  /// Set a custom maximum value for this axis. If set, this value will not be
  /// calculated automatically depending on the provided data.
  ///
  /// [@param] max value
  ///
  void setAxisMaximum(double max) {
    max ;

    _customAxisMax = true;
    _axisMaximum = max;
    _axisRange = (max - _axisMinimum).abs();
  }

  /// Sets the number of label entries for the y-axis max = 25, min = 2,
  /// default is 6, be aware that this number is not fixed.
  ///
  ///     [@param] count the number of y-axis labels that should be displayed.
  ///
  void setLabelCount1(int count) {
    count ;
    if ( count > 25 ) { count = 25; }
    if ( count < 2 ) { count = 2; }

    _labelCount = count;
    _forceLabels = false;
  }

  /// sets the number of label entries for the y-axis max = 25, min = 2,
  /// default is 6, be aware that this number is not fixed (if force == false)
  /// and can only be approximated.
  ///
  ///     [@param] count the number of y-axis labels that should be displayed.
  ///     [@param] force if enabled, the set label count will be forced,
  ///              meaning that the exact specified count of labels will be drawn
  ///              and evenly distributed alongside the axis - this might cause
  ///              labels to have uneven values.
  ///
  void setLabelCount2(int count, bool force) {
    setLabelCount1(count);
    _forceLabels = force ;
  }

  /// Returns the formatter used for formatting the axis labels.
  ///
  ///     [return] ValueFormatter
  ///
  ValueFormatter getValueFormatter() {
    if ( (_axisValueFormatter == null) ||
      ((_axisValueFormatter is DefaultAxisValueFormatter) &&
        ((_axisValueFormatter as DefaultAxisValueFormatter).digits != _decimals))
    ) {
      _axisValueFormatter = DefaultAxisValueFormatter(_decimals);
    }

    return _axisValueFormatter!;
  }

  String getFormattedLabel(int index) {
    if ( (index < 0) || (index >= _entries.length) ) {
      return '';
    } else {
      return getValueFormatter()
          .getAxisLabel(_entries[index]);
    }
  }

  /// Returns the longest formatted label (in terms of characters),
  /// this axis contains.
  ///
  ///     [return] longest label
  ///
  String getLongestLabel() {
    var longest = '';

    for ( var i = 0 ; i < _entries.length ; i++ ) {
      var text = getFormattedLabel(i);

      if ( (text != null) &&
           (text.isNotEmpty) ) {
        longest = text;
      }
    }

    return longest;
  }

  /// Calculates the minimum/maximum and range values of the axis with
  /// the given minimum and maximum values from the chart data.
  ///
  ///     [@param] dataMin the min value according to chart data.
  ///     [@param] dataMax the max value according to chart data.
  ///
  void calculate(double dataMin, double dataMax) {
    // if custom, use value as is, else use data value
    var min = _customAxisMin
        ? _axisMinimum
        : ((dataMin ) - 0.0);
    var max = _customAxisMax
        ? _axisMaximum
        : ((dataMax ) + 0.0);

    // temporary range (before calculations)
    var range = (max - min).abs();

    // in case all values are equal
    if ( range == 0 ) {
      max = max + 1;
      min = min - 1;
    }

    _axisMinimum = min;
    _axisMaximum = max;

    // actual range
    _axisRange = (max - min).abs();
  }
}