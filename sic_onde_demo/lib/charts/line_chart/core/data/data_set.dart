part of widgets.chart.line_chart.core.data;

abstract class DataSet implements IDataSet {
  /// the entries that this DataSet represents/holds together.
  List<Entry>? _values;

  /// List representing all colors
  /// that are used for this DataSet.
  Color? _color;

  /// maximum y-value in the value array.
  double _yMax = -double.infinity;

  /// minimum y-value in the value array.
  double _yMin = double.infinity;

  /// maximum x-value in the value array.
  double _xMax = -double.infinity;

  /// minimum x-value in the value array.
  double _xMin = double.infinity;

  /// Creates a  DataSet object with
  /// the given values (entries) it represents.
  ///
  /// Also, a label that describes
  /// the DataSet can be specified.
  ///
  /// The label can also be used to retrieve
  /// the DataSet from a ChartData object.
  ///
  ///     [@param] values
  ///
  DataSet(List<Entry> values) {
    _values = values;
    calcMinMax();
  }

  @override
  void calcMinMax() {
    if ((_values == null) || (_values!.isEmpty)) {
      return;
    }

    _yMax = -double.infinity;
    _yMin = double.infinity;
    _xMax = -double.infinity;
    _xMin = double.infinity;

    for (var entry in _values!) {
      _calcMinMax1(entry);
    }
  }

  /// Use this method to tell the data set
  /// that the underlying data has changed.
  void notifyDataSetChanged() {
    calcMinMax();
  }

  /// Updates the min and max x and y value of
  /// this DataSet based on the given Entry.
  ///
  ///     [@param] entry
  ///
  void _calcMinMax1(Entry entry) {
    if (entry == null) {
      return;
    }

    _calcMinMaxX1(entry);
    _calcMinMaxY1(entry);
  }

  void _calcMinMaxX1(Entry entry) {
    if (entry.x < _xMin) {
      _xMin = entry.x;
    }
    if (entry.x > _xMax) {
      _xMax = entry.x;
    }
  }

  void _calcMinMaxY1(Entry entry) {
    if (entry.y < _yMin) {
      _yMin = entry.y;
    }
    if (entry.y > _yMax) {
      _yMax = entry.y;
    }
  }

  @override
  int getEntryCount() => _values?.length ?? 0;

  List<Entry> get values => _values!;

  /// Sets the array of entries that this DataSet
  /// represents, and calls notifyDataSetChanged()
  ///
  void setValues(List<Entry> values) {
    if (values == null) {
      return;
    }
    _values = List<Entry>.from(values);
    notifyDataSetChanged();
  }

  @override
  Color getColor() => _color ?? Color.fromARGB(255, 140, 234, 255);

  /// Sets the colors that should be used fore this DataSet.
  /// Colors are reused as soon as the number of Entries
  /// the DataSet represents is higher than the size of
  /// the colors array.
  ///
  /// If you are using colors from the resources, make sure
  /// that the colors are already prepared
  /// (by calling getResources().getColor(...))
  /// before adding them to the DataSet.
  ///
  ///     [@param] color
  ///
  void setColor(Color color) {
    _color = color;
  }

  @override
  double getYMin() => _yMin;

  @override
  double getYMax() => _yMax;

  @override
  double getXMin() => _xMin;

  @override
  double getXMax() => _xMax;

  @override
  void addEntryOrdered(Entry entry) {
    if (entry == null) {
      return;
    }

    _values ??= <Entry>[];

    _calcMinMax1(entry);

    if ((_values!.isNotEmpty) && (_values![_values!.length - 1].x > entry.x)) {
      var closestIndex = getEntryIndex1(entry.x, entry.y, Rounding.UP);

      if (closestIndex > -1) {
        _values?.insert(closestIndex, entry);
      }
    } else {
      _values?.add(entry);
    }
  }

  @override
  int getEntryIndex2(Entry e) {
    return _values!.indexOf(e);
  }

  @override
  Entry getEntryForXValue1(
      double xValue, double closestToY, Rounding rounding) {
    var index = getEntryIndex1(xValue, closestToY, rounding);
    List<Entry> win = [Entry(0, 0)];
    if (index > -1) {
      return _values![index];
    }

    return win[0];
  }

  @override
  Entry getEntryForIndex(int index) {
    return (index < _values!.length) ? _values![index] : Entry(0, 0);
  }

  @override
  int getEntryIndex1(double xValue, double closestToY, Rounding rounding) {
    if ((_values == null) || (_values!.isEmpty)) {
      return -1;
    }

    var low = 0;
    var high = _values!.length - 1;
    var closest = high;

    while (low < high) {
      var m = ((low + high) ~/ 2);

      final d1 = (_values![m].x - xValue),
          d2 = (_values![m + 1].x - xValue),
          ad1 = d1.abs(),
          ad2 = d2.abs();

      if (ad2 < ad1) {
        // [m + 1] is closer to xValue
        // Search in an higher place
        low = (m + 1);
      } else if (ad1 < ad2) {
        // [m] is closer to xValue
        // Search in a lower place
        high = m;
      } else {
        // have multiple sequential x-value with same distance
        if (d1 >= 0.0) {
          // Search in a lower place
          high = m;
        } else if (d1 < 0.0) {
          // Search in an higher place
          low = (m + 1);
        }
      }

      closest = high;
    }

    if (closest != -1) {
      var closestXValue = _values![closest].x;

      if (rounding == Rounding.UP) {
        // If rounding up, and found x-value is lower than specified x,
        // and can go upper...
        if ((closestXValue < xValue) && (closest < (_values!.length - 1))) {
          ++closest;
        }
      } else if (rounding == Rounding.DOWN) {
        // If rounding down, and found x-value is upper than specified x,
        // and can go lower...
        if ((closestXValue > xValue) && (closest > 0)) {
          --closest;
        }
      }

      // Search by closest to y-value
      if (!(closestToY.isNaN)) {
        while ((closest > 0) && (_values![closest - 1].x == closestXValue)) {
          closest -= 1;
        }

        var closestYValue = _values![closest].y;
        var closestYIndex = closest;

        while (true) {
          closest += 1;

          if (closest >= _values!.length) {
            break;
          }

          var value = _values![closest];

          if (value.x != closestXValue) {
            break;
          }

          if ((value.y - closestToY).abs() <
              (closestYValue - closestToY).abs()) {
            closestYValue = closestToY;
            closestYIndex = closest;
          }
        }

        closest = closestYIndex;
      }
    }

    return closest;
  }

  @override
  String toString() {
    return 'DataSet { length: ${_values!.length},\n'
        'yMax: $_yMax,\nyMin: $_yMin,\n'
        'xMax: $_xMax,\nxMin: $_xMin }';
  }
}
