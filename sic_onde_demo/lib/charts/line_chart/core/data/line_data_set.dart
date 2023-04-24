part of widgets.chart.line_chart.core.data;

class LineDataSet extends DataSet implements IDataSet {
  /// the width of the drawn data lines.
  double _lineWidth = 2.5;

  LineDataSet(List<Entry> entry) : super(entry);

  /// set the line width of the chart
  /// (min = 0.2f, max = 10.0f) [default 1.0f]
  ///
  /// [NOTE]: thinner line == better performance,
  ///         thicker line == worse performance.
  ///
  ///     [@param] width
  ///
  void setLineWidth(double width) {
    width ;
    if ( width < 0.0 ) { width = 0.0; }
    if ( width > 10.0 ) { width = 10.0; }
    _lineWidth = Utils.convertDpToPixel(width);
  }

  @override
  double getLineWidth() => _lineWidth;

  @override
  String toString() {
    return '${super.toString()}\nLineDataSet { lineWidth: $_lineWidth }';
  }
}