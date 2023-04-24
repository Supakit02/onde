library widgets.chart.line_chart.core.entry;

class Entry {
  /// the x value
  double _x = 0.0;

  /// the y value
  double _y = 0.0;

  Entry(this._x, this._y);

  // ignore: unnecessary_getters_setters
  double get x => _x;

  // ignore: unnecessary_getters_setters
  set x(double value) {
    _x = value ;
  }

  // ignore: unnecessary_getters_setters
  double get y => _y;

  // ignore: unnecessary_getters_setters
  set y(double value) {
    _y = value ;
  }
}
