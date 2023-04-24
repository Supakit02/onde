library widgets.chart.line_chart.core.bounds;

import 'data/chart_data.dart'
  show
    IDataSet,
    LineDataProvider;
import 'enums.dart';



class XBounds {
  /// minimum visible entry index
  int? _min;

  /// maximum visible entry index
  int? _max;

  /// range of visible entry indices
  int? _range;

  XBounds();

  // ignore: unnecessary_getters_setters
  int get range => _range!;

  // ignore: unnecessary_getters_setters
  set range(int value) {
    _range = value;
  }

  // ignore: unnecessary_getters_setters
  int get max => _max!;

  // ignore: unnecessary_getters_setters
  set max(int value) {
    _max = value;
  }

  // ignore: unnecessary_getters_setters
  int get min => _min!;

  // ignore: unnecessary_getters_setters
  set min(int value) {
    _min = value;
  }

  /// Calculates the minimum and maximum x values
  /// as well as the range between them.
  ///
  ///     [@param] chart
  ///     [@param] dataSet
  ///
  void setBounds(LineDataProvider chart, IDataSet dataSet) {
    var _low = chart.getLowestVisibleX();
    var _high = chart.getHighestVisibleX();

    var _entryFrom = dataSet.getEntryForXValue1(
      _low,
      double.nan,
      Rounding.DOWN);
    var _entryTo = dataSet.getEntryForXValue1(
      _high,
      double.nan,
      Rounding.UP);

    _min = (_entryFrom == null)
        ? 0
        : dataSet.getEntryIndex2(_entryFrom);
    _max = (_entryTo == null)
        ? 0
        : dataSet.getEntryIndex2(_entryTo);

    if ( _min! > _max! ) {
      var _t = _min;

      _min = _max;
      _max = _t;
    }

    _range = (_max! - _min!);
  }
}