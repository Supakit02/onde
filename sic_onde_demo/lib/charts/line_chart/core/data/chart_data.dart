library widgets.chart.line_chart.core.data;



import 'package:flutter/painting.dart'
  show Color;
import 'package:sic_onde_demo/charts/line_chart/core/enums.dart';
import 'package:sic_onde_demo/charts/line_chart/core/transformer.dart';
import 'package:sic_onde_demo/charts/line_chart/core/utils/utils.dart';

import '../entry.dart';
part 'i_data_set.dart';
part 'data_provider.dart';
part 'line_data_set.dart';
part 'data_set.dart';
class ChartData {
  /// maximum x-value in the value array.
  double _xMax = -double.infinity;

  /// minimum x-value in the value array.
  double _xMin = double.infinity;

  /// maximum y-value in the value array
  /// across all axes.
  double _yMax = -double.infinity;

  /// the minimum y-value in the value array
  /// across all axes.
  double _yMin = double.infinity;

  /// array that holds all DataSets
  /// the ChartData object represents.
  List<IDataSet>? _dataSets;

  /// Default constructor.
  ChartData() {
    _dataSets = <IDataSet>[];
  }

  /// Constructor taking single or multiple DataSet objects.
  ///
  ///     [@param] dataSets
  ///
  ChartData.fromList(List<IDataSet> dataSets) {
    _dataSets = dataSets;
    notifyDataChanged();
  }

  /// Call this method to let the ChartData know that
  /// the underlying data has changed.
  ///
  /// Calling this performs all necessary recalculations
  /// needed when the contained data has changed.
  void notifyDataChanged() {
    _calcMinMax1();
  }

  /// Calc minimum and maximum values
  /// (both x and y) over all DataSets.
  void _calcMinMax1() {
    if ( dataSets == null ) { return; }

    _xMax = -double.infinity;
    _xMin = double.infinity;

    for ( var dataSet in dataSets ) {
      _calcMinMax3(dataSet);
    }

    _yMax = -double.infinity;
    _yMin = double.infinity;

    // left axis
    var firstLeft = dataSets.isNotEmpty
        ? dataSets.first
        : null;

    if ( firstLeft != null ) {
      _yMax = firstLeft.getYMax();
      _yMin = firstLeft.getYMin();

      for ( var dataSet in dataSets ) {
        if ( dataSet.getYMin() < _yMin ) {
          _yMin = dataSet.getYMin();
        }

        if ( dataSet.getYMax() > _yMax ) {
          _yMax = dataSet.getYMax();
        }
      }
    }
  }

  /// Returns the number of LineDataSets this
  /// object contains.
  ///
  ///     [return] dataSet length
  ///
  int getDataSetCount() => dataSets.length ;

  double get yMin => _yMin ;
  double get yMax => _yMax ;

  double get xMin => _xMin ;
  double get xMax => _xMax ;

  List<IDataSet> get dataSets => _dataSets!;

  IDataSet? getDataSetByIndex(int index) {
    if ( (dataSets == null) ||
        (index < 0) ||
        (index >= dataSets.length) ) {
      return null;
    }

    return _dataSets![index];
  }

  /// Adds a DataSet dynamically.
  ///
  ///     [@param] data
  ///
  void addDataSet(IDataSet dataSet) {
    if ( dataSet == null ) { return; }

    _calcMinMax3(dataSet);

    _dataSets?.add(dataSet);
  }

  /// Adjusts the minimum and maximum values
  /// based on the given DataSet.
  ///
  ///     [@param] data
  ///
  void _calcMinMax3(IDataSet dataSet) {
    if ( dataSet == null ) { return; }

    if ( _xMax < dataSet.getXMax() ) {
      _xMax = dataSet.getXMax();
    }

    if ( _xMin > dataSet.getXMin() ) {
      _xMin = dataSet.getXMin();
    }

    if ( _yMax < dataSet.getYMax() ) {
      _yMax = dataSet.getYMax();
    }

    if ( _yMin > dataSet.getYMin() ) {
      _yMin = dataSet.getYMin();
    }
  }

  /// Clears this data object from all DataSets
  /// and removes all Entries.
  ///
  /// Don't forget to invalidate the chart after this.
  void clearValues() {
    _dataSets?.clear();
    notifyDataChanged();
  }

  /// Returns the total entry count across all DataSet
  /// objects this data object contains.
  ///
  ///     [return] entry length
  ///
  int getEntryCount() {
    var _count = 0;

    for ( var dataSet in dataSets ) {
      _count += dataSet.getEntryCount();
    }

    return _count;
  }
}